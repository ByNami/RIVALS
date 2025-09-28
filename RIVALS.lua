rollQueue = {}
currentlyRolling = false
currentRoll = nil
autoRollEnabled = false
selectedGachas = {}
queueIndex = 1
webhookEnabled = false
webhookURL = ""
waitingForTokens = false
lastFoundItems = {}

local SavedWebhookPath = "NamiHub_SavedWebhook.txt"

function parseAmount(text)
    local number, suffix = text:match("x?(%d+%.?%d*)([kKmMbB]?)")
    if not number then return 0 end
    number = tonumber(number) or 0
    
    if suffix then
        suffix = suffix:lower()
        if suffix == "k" then
            number = number * 1000
        elseif suffix == "m" then
            number = number * 1000000
        elseif suffix == "b" then
            number = number * 1000000000
        end
    end
    
    return math.floor(number)
end

function getTokenAmount(imageId)
    local success, result = pcall(function()
        local player = game:GetService("Players").LocalPlayer
        if not player or not player.Parent then return 0 end
        
        local playerGui = player.PlayerGui
        local inventory = playerGui:FindFirstChild("Inventory_1")
        if not inventory then return 0 end
        
        local hub = inventory:FindFirstChild("Hub")
        if not hub then return 0 end
        
        local resources = hub:FindFirstChild("Resources")
        if not resources then return 0 end
        
        local listFrame = resources:FindFirstChild("List_Frame")
        if not listFrame then return 0 end
        
        local list = listFrame:FindFirstChild("List")
        if not list then return 0 end
        
        for _, item in ipairs(list:GetChildren()) do
            if item then
                local inside = item:FindFirstChild("Inside")
                if inside then
                    local icon = inside:FindFirstChild("Icon")
                    local title = inside:FindFirstChild("Amount")
                    if icon and title and icon:IsA("ImageLabel") and title:IsA("TextLabel") then
                        if icon.Image == imageId then
                            return parseAmount(title.Text)
                        end
                    end
                end
            end
        end
        
        return 0
    end)
    
    return success and result or 0
end

function checkForTargetItem(targetName)
    local success, result = pcall(function()
        local player = game:GetService("Players").LocalPlayer
        if not player or not player.Parent then return false end
        
        local playerGui = player.PlayerGui
        local dropNotifications = playerGui:FindFirstChild("Drop_Notifications")
        if not dropNotifications then return false end
        
        local dropsFolders = {}
        local drops = dropNotifications:FindFirstChild("Drops")
        local dropsSmall = dropNotifications:FindFirstChild("Drops_Small")
        
        if drops then table.insert(dropsFolders, drops) end
        if dropsSmall then table.insert(dropsFolders, dropsSmall) end
        
        if #dropsFolders == 0 then return false end

        for _, folder in ipairs(dropsFolders) do
            if folder then
                for _, child in ipairs(folder:GetChildren()) do
                    if child and child:IsA("ImageLabel") and (child.Name == "" or child.Name:gsub("%s+", "") == "") then
                        local inside = child:FindFirstChild("Inside")
                        if inside then
                            local title = inside:FindFirstChild("Title")
                            if title and title:IsA("TextLabel") then
                                local titleText = title.Text:gsub("%s+", ""):lower()
                                local targetText = targetName:gsub("%s+", ""):lower()
                                
                                if titleText == targetText then
                                    local itemKey = tostring(child) .. "_" .. titleText
                                    if not lastFoundItems[itemKey] then
                                        lastFoundItems[itemKey] = true
                                        task.delay(5, function()
                                            lastFoundItems[itemKey] = nil
                                        end)
                                        return true
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        
        return false
    end)
    
    return success and result
end

function sendWebhook(itemName, itemType)
    if not webhookEnabled or webhookURL == "" then return end
    
    pcall(function()
        local player = game:GetService("Players").LocalPlayer
        
        local Headers = {
            ['Content-Type'] = 'application/json'
        }
        
        local data = {
            ["embeds"] = {
                {
                    ["title"] = "Item Obtained",
                    ["description"] = "**Nick:** " .. "||" .. player.DisplayName .. "||".. 
                        "\n**Item:** " .. itemName .. 
                        "\n**Type:** " .. itemType,
                    ["color"] = tonumber(0x00FF00),
                    ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
                }
            }
        }
        
        local PlayerData = game:GetService("HttpService"):JSONEncode(data)
        local Request = http_request or request or HttpPost or syn.request
        
        if Request then
            Request({
                Url = webhookURL, 
                Body = PlayerData, 
                Method = "POST", 
                Headers = Headers
            })
        end
    end)
end

function testWebhook()
    if webhookURL == "" then return end
    
    pcall(function()
        local player = game:GetService("Players").LocalPlayer
        
        local Headers = {
            ['Content-Type'] = 'application/json'
        }
        
        local data = {
            ["embeds"] = {
                {
                    ["title"] = "Webhook Test",
                    ["description"] = "**Nick:** " .. "||" .. player.DisplayName .. "||" .. "\n\nTest successful!",
                    ["color"] = tonumber(0x0099FF),
                    ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
                }
            }
        }
        
        local PlayerData = game:GetService("HttpService"):JSONEncode(data)
        local Request = http_request or request or HttpPost or syn.request
        
        if Request then
            Request({
                Url = webhookURL, 
                Body = PlayerData, 
                Method = "POST", 
                Headers = Headers
            })
        end
    end)
end

local function saveWebhook(url)
    if writefile then
        pcall(function()
            writefile(SavedWebhookPath, url)
        end)
    end
end

local function loadWebhook()
    if readfile then
        local success, url = pcall(function()
            return readfile(SavedWebhookPath)
        end)
        if success and url and url ~= "" then
            return url
        end
    end
    return ""
end

function rollGacha(gachaName)
    pcall(function()
        local args = {
            {
                Open_Amount = 10,
                Action = "_Gacha_Activate",
                Name = gachaName
            }
        }
        
        game:GetService("ReplicatedStorage").Events.To_Server:FireServer(unpack(args))
    end)
end

function updateRollParagraph(text)
    if rollParagraph then
        pcall(function()
            rollParagraph:SetDesc(text)
        end)
    end
end

function updateLiveStatus()
    pcall(function()
        if #selectedGachas > 0 then
            local statusLines = {}
            for _, gachaKey in ipairs(selectedGachas) do
                local config = RollConfig[gachaKey]
                if config then
                    local tokens = getTokenAmount(config.tokenId)
                    local status = ""
                    if autoRollEnabled and currentRoll == gachaKey then
                        if waitingForTokens then
                            status = " [WAITING TOKENS]"
                        else
                            status = " [ROLLING]"
                        end
                    end
                    table.insert(statusLines, string.format("%s: %d tokens%s", config.name, tokens, status))
                end
            end
            updateRollParagraph(table.concat(statusLines, "\n"))
        else
            updateRollParagraph("Select gachas to start.")
        end
    end)
end

function processRollQueue()
    currentlyRolling = true
    
    if not currentRoll and #selectedGachas > 0 then
        currentRoll = selectedGachas[1]
        queueIndex = 1
    end

    while autoRollEnabled and currentRoll do
        task.wait(0.1)
        
        local player = game:GetService("Players").LocalPlayer
        if not player or not player.Parent then
            break
        end
        
        local config = RollConfig[currentRoll]
        if config then
            local tokens = getTokenAmount(config.tokenId)

            if tokens < config.tokensRequired then
                local foundAlternative = false
                
                if #selectedGachas > 1 then
                    for i = 1, #selectedGachas do
                        if i ~= queueIndex then
                            local gachaKey = selectedGachas[i]
                            local gachaConfig = RollConfig[gachaKey]
                            if gachaConfig then
                                local gachaTokens = getTokenAmount(gachaConfig.tokenId)
                                if gachaTokens >= gachaConfig.tokensRequired then
                                    currentRoll = gachaKey
                                    queueIndex = i
                                    foundAlternative = true
                                    waitingForTokens = false
                                    break
                                end
                            end
                        end
                    end
                end
                
                if not foundAlternative then
                    waitingForTokens = true
                    task.wait(1.0)
                    continue
                end
            else
                waitingForTokens = false
            end

            rollGacha(currentRoll)
            
            task.wait(0.2)
            
            if checkForTargetItem(config.supremeName) then
                sendWebhook(config.supremeName, config.type or "Unknown")

                local isMultiRoll = config.Rolls and string.lower(config.Rolls) == "multi"
                
                if not isMultiRoll then
                    for i, gachaKey in ipairs(selectedGachas) do
                        if gachaKey == currentRoll then
                            table.remove(selectedGachas, i)
                            break
                        end
                    end

                    if gachaDropdown then
                        local currentValues = {}
                        for _, gacha in ipairs(selectedGachas) do
                            currentValues[gacha] = true
                        end
                        gachaDropdown:SetValue(currentValues)
                    end

                    if #selectedGachas > 0 then
                        if queueIndex > #selectedGachas then
                            queueIndex = 1
                        end
                        currentRoll = selectedGachas[queueIndex]
                    else
                        currentRoll = nil
                        break
                    end
                end
            end
        else
            for i, gachaKey in ipairs(selectedGachas) do
                if gachaKey == currentRoll then
                    table.remove(selectedGachas, i)
                    break
                end
            end

            if #selectedGachas > 0 then
                if queueIndex > #selectedGachas then
                    queueIndex = 1
                end
                currentRoll = selectedGachas[queueIndex]
            else
                currentRoll = nil
                break
            end
        end
    end

    currentlyRolling = false
    currentRoll = nil
    waitingForTokens = false
end

function getOrderedGachaNames()
    local gachaKeys = {}
    for key, _ in pairs(RollConfig) do
        table.insert(gachaKeys, key)
    end
    return gachaKeys
end

Tabs.Roll:AddSection("Gachas")

gachaNames = getOrderedGachaNames()

rollParagraph = Tabs.Roll:AddParagraph({
    Title = "Tokens Status",
    Content = "Select gachas to start."
})

gachaDropdown = Tabs.Roll:AddDropdown("GachaDropdown", {
    Title = "Select Gachas",
    Values = gachaNames,
    Multi = true,
    Default = {},
    Callback = function(selected)
        local validatedSelection = {}
        
        if type(selected) == "table" then
            for i, value in ipairs(selected) do
                table.insert(validatedSelection, value)
            end
            
            for key, value in pairs(selected) do
                if type(key) == "string" and value == true then
                    local found = false
                    for _, existing in ipairs(validatedSelection) do
                        if existing == key then
                            found = true
                            break
                        end
                    end
                    if not found then
                        table.insert(validatedSelection, key)
                    end
                end
            end
        elseif type(selected) == "string" then
            table.insert(validatedSelection, selected)
        else
            validatedSelection = {}
        end
        
        selectedGachas = validatedSelection
        queueIndex = 1
        updateLiveStatus()
        
        if autoRollEnabled and not currentlyRolling and #selectedGachas > 0 then
            task.spawn(processRollQueue)
        end
    end
})

autoRollToggle = Tabs.Roll:AddToggle("AutoRoll", {
    Title = "Auto Roll Gachas",
    Default = false,
    Callback = function(value)
        autoRollEnabled = value
        
        if autoRollEnabled and not currentlyRolling and #selectedGachas > 0 then
            task.spawn(processRollQueue)
        elseif not autoRollEnabled then
            currentlyRolling = false
            currentRoll = nil
            waitingForTokens = false
        end
        
        updateLiveStatus()
    end
})

Tabs.Roll:AddSection("Webhook Configuration")

webhookURL = loadWebhook()

webhookInput = Tabs.Roll:AddInput("WebhookInput", {
    Title = "Webhook URL",
    Default = webhookURL,
    Placeholder = "Paste your webhook URL here",
    Finished = false,
    Callback = function(value)
        webhookURL = value
    end
})

saveWebhookButton = Tabs.Roll:AddButton({
    Title = "Save Webhook",
    Callback = function()
        if webhookURL and webhookURL ~= "" then
            saveWebhook(webhookURL)
        end
    end
})

webhookToggle = Tabs.Roll:AddToggle("WebhookEnabled", {
    Title = "Enable Webhook",
    Default = false,
    Callback = function(value)
        webhookEnabled = value
    end
})

testWebhookButton = Tabs.Roll:AddButton({
    Title = "Test Webhook",
    Callback = function()
        testWebhook()
    end
})

task.spawn(function()
    while true do
        pcall(function()
            updateLiveStatus()
        end)
        task.wait(0.5)
    end
end)
