if not game:IsLoaded() then 
    repeat game.Loaded:Wait()
    until game:IsLoaded() 
end
if game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam") then
	if game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Visible == true then
		local args = {
			[1] = "SetTeam",
			[2] = "Pirates"
		}
		
		game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
		wait(0.2)
		game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Visible = false
	end
end
local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera

-- Update the camera's position each frame
game:GetService("RunService").RenderStepped:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local rootPart = player.Character.HumanoidRootPart
        -- Set the camera position to a fixed distance behind the player
        camera.CFrame = CFrame.new(rootPart.Position + Vector3.new(0, 5, 10), rootPart.Position)
    end
end)

Old_World = false
New_World = false
Three_World = false
local placeId = game.PlaceId
if placeId == 2753915549 then
    Old_World = true
elseif placeId == 4442272183 then
    New_World = true
elseif placeId == 7449423635 then
    Three_World = true
end
-- Setting farm function
local Saber_Farm = true
local Mob_Boss = false
local Saber_Kill = false
local Auto_Farm = false
--game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")tt
local Auto_Farm_Bounty = false
local Auto_Farm_Fruit = false
local Mix_Farm = false
local Auto_Raid = false
-- Load item 
function loadAndEquipItem(itemName)
    local args = {
        [1] = "LoadItem",
        [2] = itemName
    }

    -- Call the remote to load the item
    local success, response = pcall(function()
        return game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
    end)

    if not success then
        print("Error loading item: " .. itemName)
        return nil
    end

    -- Wait for the item to be added to the player's backpack and equip it
    local item = game.Players.LocalPlayer.Backpack:WaitForChild(itemName, 1)
    
    if item then
        return item.Level.Value
    else
        print(itemName .. " not found in Backpack")
        return nil  -- Return nil if item not found
    end
end

-- VirtualUser
local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

-- Fast Attack
local combatActive = false  -- Flag to control the combat loop
local combatConnection  -- Variable to store the Stepped connection

local function customCombatFramework()
    -- Load necessary modules
    local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
    local Camera = require(game.ReplicatedStorage.Util.CameraShaker)

    -- Stop camera shaking
    Camera:Stop()

    -- Function to adjust combat parameters
    local function adjustCombat()
        if not combatActive then return end  -- Stop if combatActive is false

        local upvalues = getupvalues(CombatFramework)
        local activeController = upvalues[2]['activeController']
        
        if activeController.timeToNextAttack then
            activeController.timeToNextAttack = 1
            activeController.hitboxMagnitude = 25
            activeController:attack()
        end
    end

    -- Start the combat loop
    combatActive = true
    combatConnection = game:GetService("RunService").Stepped:Connect(adjustCombat)
end

-- Function to stop the combat loop
local function stopCombatFramework()
    combatActive = false
    if combatConnection then
        combatConnection:Disconnect()
        combatConnection = nil
    end
end

function Done()
    local args = {
        [1] = "KenTalk",
        [2] = "Buy"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
    wait(0.5)
    stopCombatFramework()
    wait(1)
    --game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
end
-- Equip Tools Function
function EquipWeapon(ToolSe)
	if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
		local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
		wait(.4)
		game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
	end
end
-- Teleport Function
function TP(P1)
    if not _G.Stop_Tween then
        local Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
        Speed = 100
        if Distance < 250 then
            Speed = 5000
        elseif Distance < 500 then
            Speed = 650
        elseif Distance < 1000 then
            Speed = 350
        elseif Distance >= 1000 then
            Speed = 250
        end
        Tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),{CFrame = P1})
        if _G.Stop_Tween or Auto_Raid then
            Tween:Cancel()
        elseif game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
            Tween:Play()
        end
    end
end

function TP2(P1)
	local Distance = (P1.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
	if Distance < 150 then
		Speed = 5000
	elseif Distance < 200 then
		Speed = 1500
	elseif Distance < 300 then
		Speed = 800
	elseif Distance < 500 then
		Speed = 500
	elseif Distance < 1000 then
		Speed = 250
	elseif Distance >= 1000 then
		Speed = 250
	end
	game:GetService("TweenService"):Create(
		game.Players.LocalPlayer.Character.HumanoidRootPart,
		TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
		{CFrame = P1}
	):Play()
	if _G.Stop_Tween then
		game:GetService("TweenService"):Create(
		game.Players.LocalPlayer.Character.HumanoidRootPart,
		TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
			{CFrame = P1}
		):Cancel()
	end
	_G.Clip = true
	wait(Distance/Speed)
	_G.Clip = false
end

spawn(function()
    while wait(.2) do
        local saberItem = loadAndEquipItem("Saber")
        if saberItem then
            Done()
        end
        local Lv = game:GetService("Players").LocalPlayer.Data.Level.Value
        local Beli = game:GetService("Players").LocalPlayer.Data.Beli.Value
        local FG = game:GetService("Players").LocalPlayer.Data.Fragments.Value
        if Old_World and Saber_Farm then
            if Auto_Farm then
                Auto_Farm = false
            end
            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") ~= 0 then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                Auto_Farm = false
                repeat wait()
                    TP(CFrame.new(-1609.29956, 40.0520697, 162.820404))
                until (Vector3.new(-1609.29956, 40.0520697, 162.820404)-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10
                wait(3)
                for i,v in pairs(game:GetService("Workspace").Map.Jungle.QuestPlates:GetChildren()) do
                    if v.Name == "Plate1" then
                        repeat wait()
                        TP2(v.Button.CFrame)
                        until (v.Button.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 1
                        wait(1)
                    end
                    if v.Name == "Plate2" then
                        repeat wait()
                        TP2(v.Button.CFrame)
                        until (v.Button.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 1
                        wait(1)
                    end
                    if v.Name == "Plate3" then
                        repeat wait()
                        TP2(v.Button.CFrame)
                        until (v.Button.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 1
                        wait(1)
                    end
                    if v.Name == "Plate4" then
                        repeat wait()
                        TP2(v.Button.CFrame)
                        until (v.Button.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 1
                        wait(1)
                    end
                    if v.Name == "Plate5" then
                        repeat wait()
                        TP2(v.Button.CFrame)
                        until (v.Button.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 1
                        wait(1)
                    end
                end
                wait(2)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1609.29956, 12.0520697, 162.820404, -0.993804812, 2.60902091e-08, 0.11113929, 3.47902116e-08, 1, 7.63408607e-08, -0.11113929, 7.97344768e-08, -0.993804812)
                wait(2)
                repeat wait()
                    EquipWeapon("Torch")
                    TP(CFrame.new(1113.9502, 4.92147732, 4350.91992, -0.60768199, 3.86533046e-08, 0.794180453, 6.00742425e-08, 1, -2.70375722e-09, -0.794180453, 4.60667628e-08, -0.60768199))
                until (Vector3.new(1113.9502, 4.92147732, 4350.91992)-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1
                wait(1)
                --fireclickdetector(game:GetService("Workspace").Map.Desert.Burn.Fire.ClickDetector)
                wait(1)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1113.9502, 4.92147732, 4350.91992, -0.60768199, 3.86533046e-08, 0.794180453, 6.00742425e-08, 1, -2.70375722e-09, -0.794180453, 4.60667628e-08, -0.60768199)
                wait(1)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1113.9502, 4.92147732, 4350.91992, -0.60768199, 3.86533046e-08, 0.794180453, 6.00742425e-08, 1, -2.70375722e-09, -0.794180453, 4.60667628e-08, -0.60768199)
                wait(1)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1114.87708, 4.9214654, 4349.8501, -0.612586915, -9.68697833e-08, 0.790403247, -1.2634203e-07, 1, 2.4638446e-08, -0.790403247, -8.47679615e-08, -0.612586915)
                wait(10)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1113.33618, 7.5484705, 4365.56396, -0.618000686, 2.54492516e-08, -0.786177576, -8.16741874e-09, 1, 3.87911392e-08, 0.786177576, 3.03939913e-08, -0.618000686)
                wait(2)
                repeat wait()
                    EquipWeapon("Cup")
                    TP(CFrame.new(1397.73975, 37.3480263, -1321.54456, -0.170597032, -4.99889588e-08, 0.985340893, 2.99880867e-08, 1, 5.59246409e-08, -0.985340893, 3.90890662e-08, -0.170597032))
                until (Vector3.new(1397.73975, 37.3480263, -1321.54456)-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 2
                wait(1)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1397.73975, 37.3480263, -1321.54456, -0.170597032, -4.99889588e-08, 0.985340893, 2.99880867e-08, 1, 5.59246409e-08, -0.985340893, 3.90890662e-08, -0.170597032)
                wait(3)
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan")
                wait(1)
                Mob_Boss = true
                Saber_Farm = false
                
            else
                Auto_Farm = false
                Mob_Boss = true
                Saber_Farm = false
            end
        elseif not Old_World and Saber_Farm then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
        end
    end
end)
spawn(function()
    while wait(.2) do
        local saberItem = loadAndEquipItem("Saber")
        if saberItem then
            Done()
        end
        if Mob_Boss then
            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 then
                if game.Players.LocalPlayer.Backpack:FindFirstChild("Relic") or game.Players.LocalPlayer.Character:FindFirstChild("Relic") then
                    EquipWeapon("Relic")
                    repeat wait()
                        EquipWeapon("Relic")
                        TP2(CFrame.new(-1406.60925, 29.8520069, 4.5805192, 0.882920146, 3.62382622e-08, 0.469523162, -3.61928865e-09, 1, -7.03750587e-08, -0.469523162, 6.04362143e-08, 0.882920146))
                    until (Vector3.new(-1406.60925, 29.8520069, 4.5805192)-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 2
                    wait(1)
                    Saber_Kill = true
                    Mob_Boss = false
                else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
                end
            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 0 then
                if game.Workspace.Enemies:FindFirstChild("Mob Leader") then
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if v.Name == "Mob Leader" then
                            
                            repeat wait()
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
                                wait(0.2)
                                EquipWeapon("Godhuman")
                                v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                TP(v.HumanoidRootPart.CFrame*CFrame.new(0,20,0))
                                customCombatFramework()
                                --game:GetService'VirtualUser':CaptureController()
                                --game:GetService'VirtualUser':Button1Down(Vector2.new(1280,900))
                            until not v.Parent or v.Humanoid.Health <= 0 or Mob_Boss == false
                        end
                    end
                elseif game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader") then
                    TP2(game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader").HumanoidRootPart.CFrame)
                end
            else
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
            end
        end
    end
end)
spawn(function()
    while wait(.2) do
        local saberItem = loadAndEquipItem("Saber")
        if saberItem then
            Done()
        end
        pcall(function()
            if Saber_Kill then
                if game.Workspace.Enemies:FindFirstChild("Saber Expert") then
                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == "Saber Expert" then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
                            
                            repeat wait()
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
                                wait(0.2)
                                EquipWeapon("Godhuman")
                                v.HumanoidRootPart.Size = Vector3.new(50,50,50)
                                TP(v.HumanoidRootPart.CFrame*CFrame.new(0,0,0))
                                --game:GetService'VirtualUser':CaptureController()
                                --game:GetService'VirtualUser':Button1Down(Vector2.new(1280,900))
                                customCombatFramework()
                            until not v.Parent or v.Humanoid.Health <= 0 or Saber_Kill == false
                        end
                    end
                elseif game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert") or game.Workspace.Enemies:FindFirstChild("Saber Expert") then
                    TP(game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert").HumanoidRootPart.CFrame)
                elseif _G.Hop_Saber then
                    wait(5)
                    if not game.Workspace.Enemies:FindFirstChild("Saber Expert") and not game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert") then
                        _G.Hop_Saber_Ex = true
                    end
                else
                    TP2(CFrame.new(-1458.89502, 29.8870335, -50.633564, 0.858821094, 1.13848939e-08, 0.512275636, -4.85649254e-09, 1, -1.40823326e-08, -0.512275636, 9.6063415e-09, 0.858821094))
                end
            end
        end)
    end
end)