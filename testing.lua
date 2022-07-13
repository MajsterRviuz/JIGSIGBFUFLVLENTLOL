-- Whitelist thing --

local Final = {}
local data = game:service"HttpService":JSONDecode(game:HttpGet("https://groups.roblox.com/v1/groups/14007434/roles/79833425/users?sortOrder=Asc&limit=100"))
if data then
    for i,v in pairs(data.data) do
        table.insert(Final,v)
    end
end
local Picked = Final[math.random(#Final)]
local string_ = Picked.username.."|"..tostring(Picked.userId).."|"..Picked.displayName
return string_

getgenv().HasRunnedDropCMD = true

getgenv().DropCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then
                
                game.ReplicatedStorage.MainEvent:FireServer("Block", true)

                getgenv().MUF_sendChatMessage('Started Dropping!')    

                getgenv().CA_Dropping = true

                local LF_Loop

                local LF_loopFunction = function(amount)

                    game:GetService("ReplicatedStorage").MainEvent:FireServer('DropMoney', tostring(amount))

                end;

                local LF_Start = function(amount)

                    LF_Loop = getgenv().RunService.Heartbeat:Connect(function()

                        LF_loopFunction(amount)

                    end)

                end;

                local LF_Pause = function()

                    LF_Loop:Disconnect()

                    if getgenv().CA_DroppingUntil == true then

                        getgenv().CA_DroppingUntil = false

                        getgenv().CA_DropUntilAmount = 0

                    end

                    if game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000 then

                        getgenv().MUF_sendChatMessage("I don't have enough money, must have atleast 10K")

                    end

                    getgenv().MUF_sendChatMessage('Stopped Droping')

                end;

            

                LF_Start(10000)

                repeat wait() until getgenv().CA_Dropping == false or getgenv().CA_DroppingUntil == true or game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000

                LF_Pause()

            end

        end

    else

        MUF_sendChatMessage('Started Dropping!')

        getgenv().CA_Dropping = true

        local LF_Loop

        local LF_loopFunction = function(amount)

            game:GetService("ReplicatedStorage").MainEvent:FireServer('DropMoney', tostring(amount))

        end;

        local LF_Start = function(amount)

            LF_Loop = getgenv().RunService.Heartbeat:Connect(function()

                LF_loopFunction(amount)

            end)

        end;

        local LF_Pause = function()

            LF_Loop:Disconnect()

            if getgenv().CA_DroppingUntil == true then

                getgenv().CA_DroppingUntil = false

                getgenv().CA_DropUntilAmount = 0

            end

            if game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000 then

                getgenv().MUF_sendChatMessage("I don't have enough money, must have atleast 10K")

            end

            getgenv().MUF_sendChatMessage('Stopped Dropping')

        end;

    

        LF_Start(10000)

        repeat wait() until getgenv().CA_Dropping == false or getgenv().CA_DroppingUntil == true or game.Players.LocalPlayer:FindFirstChild('DataFolder'):FindFirstChild('Currency').Value < 10000

        LF_Pause()

    end

end

getgenv().HasRunnedStopCMD = true



getgenv().StopCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                game.ReplicatedStorage.MainEvent:FireServer("Block", false)

                getgenv().CA_DroppingUntil = false

                getgenv().CA_DropUntilDroppedAmount = 0

                getgenv().CA_DropUntilAmount = 0

                getgenv().CA_Dropping = false

                getgenv().MUF_sendChatMessage('Stopped Dropping!')

            end

        else

            getgenv().MUF_sendChatMessage('unknown alt')

        end

    else

        getgenv().CA_DroppingUntil = false

        getgenv().CA_DropUntilDroppedAmount = 0

        getgenv().CA_DropUntilAmount = 0

        getgenv().CA_Dropping = false

        getgenv().MUF_sendChatMessage('Stopped Dropping!')

    end

end

getgenv().HasRunnedWalletCMD = true



getgenv().WalletCMD = function(args)

    if args[2] then

        if getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                if game.Players.LocalPlayer.Character:FindFirstChild('Wallet') then

                    game.Players.LocalPlayer.Character:FindFirstChild('Wallet').Parent = game.Players.LocalPlayer.Backpack

                elseif game.Players.LocalPlayer.Backpack:FindFirstChild('Wallet') then

                    game.Players.LocalPlayer.Backpack:FindFirstChild('Wallet').Parent = game.Players.LocalPlayer.Character

                else

                    getgenv().MUF_sendChatMessage('I can not find wallet')

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        if game.Players.LocalPlayer.Character:FindFirstChild('Wallet') then

            game.Players.LocalPlayer.Character:FindFirstChild('Wallet').Parent = game.Players.LocalPlayer.Backpack

        elseif game.Players.LocalPlayer.Backpack:FindFirstChild('Wallet') then

            game.Players.LocalPlayer.Backpack:FindFirstChild('Wallet').Parent = game.Players.LocalPlayer.Character

        else

            getgenv().MUF_sendChatMessage('I can not find wallet')

        end

    end

end

getgenv().HasRunnedAirlockCMD = true



getgenv().AirlockCMD = function(args)

    if args[2] then

        if args[2]:lower() == 'all' then

            if getgenv().CA_IsAirlocking == true then

                getgenv().CA_IsAirlocking = false

                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                getgenv().MUF_sendChatMessage('Unairlocked!')

            else

                getgenv().CA_IsAirlocking = true

                if getgenv().CA_IsFreezing == true then

                    getgenv().CA_IsFreezing = false

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                end

                if getgenv().CA_IsGraving == true then

                    getgenv().CA_IsGraving = false

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                end

                if args[3] then

                    if tonumber(args[3]) then

                        local plrpos = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(plrpos.X, plrpos.Y + tonumber(args[3]), plrpos.Z)

                        wait(0.02)

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

                        getgenv().MUF_sendChatMessage('Airlocked!')

                    else

                        getgenv().MUF_sendChatMessage('Argument 3 must be number')

                    end

                else

                    local plrpos = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(plrpos.X, plrpos.Y + 15, plrpos.Z)

                    wait(0.02)

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

                    getgenv().MUF_sendChatMessage('Airlocked!')

                end

            end

        elseif getgenv().MUF_ReturnClosestPlayer(args[2]) then

            if getgenv().MUF_ReturnClosestPlayer(args[2]) == game.Players.LocalPlayer then

                if getgenv().CA_IsAirlocking == true then

                    getgenv().CA_IsAirlocking = false

                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                    getgenv().MUF_sendChatMessage('Unairlocked!')

                else

                    getgenv().CA_IsAirlocking = true

                    if getgenv().CA_IsFreezing == true then

                        getgenv().CA_IsFreezing = false

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                    end

                    if getgenv().CA_IsGraving == true then

                        getgenv().CA_IsGraving = false

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

                    end

                    if args[3] then

                        if tonumber(args[3]) then

                            local plrpos = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position

                            game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(plrpos.X, plrpos.Y + tonumber(args[3]), plrpos.Z)

                            wait(0.02)

                            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

                            getgenv().MUF_sendChatMessage('Airlocked!')

                        else

                            getgenv().MUF_sendChatMessage('Argument 3 must be number')

                        end

                    else

                        local plrpos = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position

                        game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(plrpos.X, plrpos.Y + 15, plrpos.Z)

                        wait(0.02)

                        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

                        getgenv().MUF_sendChatMessage('Airlocked!')

                    end

                end

            end

        else

            getgenv().MUF_sendChatMessage('Unknown Alt')

        end

    else

        if getgenv().CA_IsAirlocking == true then

            getgenv().CA_IsAirlocking = false

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

            getgenv().MUF_sendChatMessage('Unairlocked!')

        else

            getgenv().CA_IsAirlocking = true

            if getgenv().CA_IsFreezing == true then

                getgenv().CA_IsFreezing = false

                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

            end

            if getgenv().CA_IsGraving == true then

                getgenv().CA_IsGraving = false

                game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false

            end

            local plrpos = game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position

            game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(plrpos.X, plrpos.Y + 15, plrpos.Z)

            wait(0.02)

            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true

            getgenv().MUF_sendChatMessage('Airlocked!')

        end

    end

end

getgenv().HasRunnedSetupCMD = true



getgenv().SetupCMD = function(args)

    if args[2] then

        if args[2]:lower() == 'bank' then

            getgenv().LGF_TeleportAltsToBank = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-391.28, 21.47, -339.90)

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-383.29, 21.47, -340.17)

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-373.30, 21.47, -340.27)

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-364.55, 21.47, -339.91)

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-357.42, 21.47, -339.57)

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-391.72, 21.47, -330.29)

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-384.14, 21.47, -329.72)

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-376.74, 21.47, -329.23)

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-368.96, 21.47, -328.89)

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-357.75, 21.47, -328.77)

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-391.41, 21.47, -320.83)

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-383.24, 21.47, -320.56)

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-374.50, 21.47, -320.36)

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-366.63, 21.47, -320.08)

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-357.28, 21.47, -319.69)
                end

            end

            getgenv().LGF_TeleportAltsToBank()

        elseif args[2]:lower() == 'admin' then

            getgenv().LGF_TeleportAltsToAdminBase = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-894.8657836914062, -39.401187896728516, -553.9047241210938) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-895.1825561523438, -39.401187896728516, -567.8170776367188) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-895.1011352539062, -38.901187896728516, -580.698974609375) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-895.02099609375, -38.901187896728516, -593.3446044921875) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-894.9393310546875, -39.10118865966797, -606.1416015625) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-880.18701171875, -38.40118408203125, -554.1747436523438) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-880.10009765625, -38.40118408203125, -567.90576171875) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-880.017333984375, -38.40118408203125, -580.9703369140625) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-879.9363403320312, -38.40118408203125, -593.6342163085938) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-880.517822265625, -38.40118408203125, -607.0358276367188) -- 10

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-865.4531860351562, -38.401187896728516, -554.8992919921875) -- 11

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-865.2959594726562, -38.401187896728516, -567.2496948242188) -- 12

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-865.4403076171875, -38.401187896728516, -580.424560546875) -- 13

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-865.5025024414062, -38.401187896728516, -594.418212890625) -- 14

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-865.2288208007812, -38.401187896728516, -607.0742797851562) -- 15
                
                end

            end

            getgenv().LGF_TeleportAltsToAdminBase()

        elseif args[2]:lower() == 'basket' then

            getgenv().LGF_TeleportAltsToBasket = function()

                if getgenv().alts['Alt1'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-994.48, 22.22, -482.50) -- 1

                elseif getgenv().alts['Alt2'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-963.27, 22.22, -482.23) -- 2

                elseif getgenv().alts['Alt3'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-969.70, 22.22, -482.20) -- 3

                elseif getgenv().alts['Alt4'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-974.50, 22.22, -493.81) -- 4

                elseif getgenv().alts['Alt5'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-980.78, 22.22, -493.28) -- 5

                elseif getgenv().alts['Alt6'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-986.61, 22.22, -493.32) -- 6

                elseif getgenv().alts['Alt7'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-993.15, 22.22, -491.21) -- 7

                elseif getgenv().alts['Alt8'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-993.40, 22.22, -473.13) -- 8

                elseif getgenv().alts['Alt9'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-986.64, 22.22, -471.45) -- 9

                elseif getgenv().alts['Alt10'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-980.88, 22.22, -471.29) -- 10

                elseif getgenv().alts['Alt11'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-974.70, 22.22, -471.20) -- 11

                elseif getgenv().alts['Alt12'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-947.43, 22.22, -480.84) -- 12

                elseif getgenv().alts['Alt13'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-916.27, 22.22, -482.99) -- 13

                elseif getgenv().alts['Alt14'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-931.92, 22.32, -499.14) -- 14

                elseif getgenv().alts['Alt15'] == game.Players.LocalPlayer.UserId then

                    game.Players.LocalPlayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(-932.08, 22.32, -466.60) -- 15
                end

            end
            
            getgenv().LGF_TeleportAltsToBasket()

        elseif getgenv().MUF_ReturnClosestPlayer(args[2]) then

            local choosenplrpos = getgenv().MUF_ReturnClosestPlayer(args[2]).Character:FindFirstChild('HumanoidRootPart').Position
        
            plr.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(choosenplrpos.X - math.random(1,25), choosenplrpos.Y, choosenplrpos.Z - math.random(1,25))
        
        end
        
    else
        
        local hostlolpos = getgenv().PlayersService:FindFirstChild(getgenv().PlayersService:GetNameFromUserIdAsync(tonumber(getgenv().hostlol))).Character:FindFirstChild('HumanoidRootPart').Position
        
        plr.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(hostlolpos.X - math.random(1,25), hostlolpos.Y, hostlolpos.Z - math.random(1,25))
        
    end
        
end

getgenv().HasRunnedFlyCMD = true

getgenv().FlyCMD = function(args)

    if game.Players.LocalPlayer.UserId == getgenv().hostlol then

        loadstring(game:HttpGet('https://pastebin.com/raw/2E25BR70'))()

    end
end