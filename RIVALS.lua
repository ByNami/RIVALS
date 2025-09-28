

Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
MarketplaceService = game:GetService("MarketplaceService")
PlaceId = game.PlaceId
ProductInfo = MarketplaceService:GetProductInfo(PlaceId)
GameName = ProductInfo.Name
Plr = game.Players.LocalPlayer
Char = Plr.Character
Humanoid = Char:WaitForChild("Humanoid")
Players = game:GetService("Players")
LocalPlayer = Players.LocalPlayer
CoreGui = game:GetService("CoreGui")
ReplicatedStorage = game:GetService("ReplicatedStorage")
Workspace = game:GetService("Workspace")
RunService = game:GetService("RunService")

Window = Fluent:CreateWindow({
    Title = "With ❤️ Nami Hub -",
    SubTitle = "" .. GameName,
    Icon = "rbxassetid://79457684163404", --!
    TabWidth = 115,
    Size = UDim2.fromOffset(465, 360),
    Acrylic = false,
    Theme = "Amethyst",
    MinimizeKey = Enum.KeyCode.LeftControl,
})

Tabs = {
    Roll = Window:AddTab({Title = "• Roll", Icon = "rbxassetid://18786832523"}),
}



RollConfig = {
    ["Dragon_Race"] = {
        name = "Dragon Race",
        tokenId = "rbxassetid://80543035071847",
        tokensRequired = 10,
        supremeName = "Saiyan",
        type = "Phantom"
    },
    ["Saiyan_Evolution"] = {
        name = "Saiyan Evolution",
        tokenId = "rbxassetid://109763458341872",
        tokensRequired = 10,
        supremeName = "Super Saiyan 3",
        type = "Phantom"
    },
    ["Pirate_Crew"] = {
        name = "Pirate Crew",
        tokenId = "rbxassetid://103797445341764",
        tokensRequired = 10,
        supremeName = "Red-Haired Pirates",
        type = "Phantom"
    },
    ["Demon_Fruits"] = {
        name = "Demon Fruits",
        tokenId = "rbxassetid://131567976287121",
        tokensRequired = 10,
        supremeName = "Dough Fruit",
        type = "Phantom"
    },
    ["Swords"] = {
        name = "Swords",
        tokenId = "rbxassetid://73036819543324",
        tokensRequired = 10,
        supremeName = "Venomstrike",
        type = "Phantom",
        Rolls = "Multi",
    },
    ["Reiatsu_Color"] = {
        name = "Reiatsu_Color",
        tokenId = "rbxassetid://74708155020004",
        tokensRequired = 10,
        supremeName = "Black Reiatsu",
        type = "Phantom"
    },
    ["Zanpakuto"] = {
        name = "Zanpakuto",
        tokenId = "rbxassetid://71279193449431",
        tokensRequired = 10,
        supremeName = "Zangetsu",
        type = "Phantom"
    },
    ["Curses"] = {
        name = "Curses",
        tokenId = "rbxassetid://130464802953428",
        tokensRequired = 10,
        supremeName = "Wandered Mind",
        type = "Phantom"
    },
    ["Demon_Arts"] = {
        name = "Demon Arts",
        tokenId = "rbxassetid://101242883563591",
        tokensRequired = 10,
        supremeName = "Blood Control",
        type = "Phantom"
    },
    ["Solo_Hunter_Rank"] = {
        name = "Solo Hunter Rank",
        tokenId = "rbxassetid://72419446650770",
        tokensRequired = 10,
        supremeName = "National Level Hunter",
        type = "Phantom"
    },
    ["Grimoire"] = {
        name = "Grimoire",
        tokenId = "rbxassetid://103501763167478",
        tokensRequired = 10,
        supremeName = "Time Magic Grimoire",
        type = "Phantom"
    },
    ["Power_Eyes"] = {
        name = "Power Eyes",
        tokenId = "rbxassetid://98415560656782",
        tokensRequired = 10,
        supremeName = "Eye of Six Paths",
        type = "Supreme"
    },
    ["Psychic_Mayhem"] = {
        name = "Psychic Mayhem",
        tokenId = "rbxassetid://94544842370105",
        tokensRequired = 10,
        supremeName = "Energy Aura Blast",
        type = "Phantom"
    },
    ["Energy_Card_Shop"] = {
        name = "Energy Card Shop",
        tokenId = "rbxassetid://73680690544439",
        tokensRequired = 10,
        supremeName = "Energy Card VII",
        type = "Phantom"
    },
    ["Damage_Card_Shop"] = {
        name = "Damage Card Shop",
        tokenId = "rbxassetid://138364269346563",
        tokensRequired = 10,
        supremeName = "Damage Card VIII",
        type = "Supreme"
    },
    ["Families"] = {
        name = "Families",
        tokenId = "rbxassetid://78180237497824",
        tokensRequired = 10,
        supremeName = "Reiss Family",
        type = "Phantom"
    },
    ["Titans"] = {
        name = "Titans",
        tokenId = "rbxassetid://95930329863911",
        tokensRequired = 10,
        supremeName = "Colossal Titan",
        type = "Phantom",
        Rolls = "Multi",
    },
    ["Sins"] = {
        name = "Sins",
        tokenId = "rbxassetid://117257507417148",
        tokensRequired = 10,
        supremeName = "Pride",
        type = "Phantom"
    },
    ["Commandments"] = {
        name = "Commandments",
        tokenId = "rbxassetid://79120710139967",
        tokensRequired = 10,
        supremeName = "Love",
        type = "Supreme"
    },
    ["Kaiju_Powers"] = {
        name = "Kaiju Powers",
        tokenId = "rbxassetid://100513684359057",
        tokensRequired = 10,
        supremeName = "No. 8",
        type = "Supreme"
    },
    ["Ultimate_Skills"] = {
        name = "Ultimate Skills",
        tokenId = "rbxassetid://76253382630191",
        tokensRequired = 10,
        supremeName = "Raphael",
        type = "Supreme"
    },
    ["Species"] = {
        name = "Species",
        tokenId = "rbxassetid://99431844767275",
        tokensRequired = 10,
        supremeName = "True Dragon",
        type = "Supreme"
    },
    ["Power_Energy_Runes"] = {
        name = "Power Energy Runes",
        tokenId = "rbxassetid://127737736998154",
        tokensRequired = 10,
        supremeName = "Supreme Energy Rune",
        type = "Supreme"
    },
    ["Stands"] = {
        name = "Stands",
        tokenId = "rbxassetid://87007917599015",
        tokensRequired = 10,
        supremeName = "World",
        type = "Supreme",
        Rolls = "Multi",
    },
    ["Onomatopoeia"] = {
        name = "Onomatopoeia",
        tokenId = "rbxassetid://88264916841585",
        tokensRequired = 10,
        supremeName = "Supreme Onomatopoeia",
        type = "Supreme"
    },
    ["Investigators"] = {
        name = "Investigators",
        tokenId = "rbxassetid://83373491209093",
        tokensRequired = 10,
        supremeName = "Special Class",
        type = "Supreme",
    },
    ["Kagune"] = {
        name = "Kagune",
        tokenId = "rbxassetid://96844634232385",
        tokensRequired = 10,
        supremeName = "Koumyaku",
        type = "Supreme",
    },
    ["Debiru_Hunter"] = {
        name = "Debiru_Hunter",
        tokenId = "rbxassetid://84031550212582",
        tokensRequired = 10,
        supremeName = "Primal Threat Hunter",
        type = "Supreme",
    },
    ["Akuma_Powers"] = {
        name = "Akuma_Powers",
        tokenId = "rbxassetid://71328302349281",
        tokensRequired = 10,
        supremeName = "Akuma: Control",
        type = "Supreme",
    },
    ["Special_Fire_Force"] = {
        name = "Special_Fire_Force",
        tokenId = "rbxassetid://81573129394061",
        tokensRequired = 10,
        supremeName = "Company 8",
        type = "Supreme",
    },
}


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
