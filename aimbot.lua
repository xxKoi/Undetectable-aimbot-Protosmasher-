local RunService = game:GetService("RunService")
local m = game:GetService("Players").LocalPlayer:GetMouse()
local camera = workspace.Camera
local enabled = false
_G.sound = true -- Use to enable the sound on toggling the aimbot; run the script "_G.sound = true/false" to toggle.
_G.ffa = false -- Toggle by using the script "_G.ffa = true/false"; Toggle on if the game isn't a FFA game/there is no teams.

local toggleSound = Instance.new("Sound", game.Workspace)
toggleSound.SoundId = "rbxassetid://582374365"

function WTS(position)
    return camera:WorldToScreenPoint(position)
end

function getNearestCharacterToUs()
    local smallestPositionFound = math.huge
    local nearestPlayerRightNow = nil
    for i, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game:GetService("Players").LocalPlayer and (_G.ffa or player.Team ~= game:GetService("Players").LocalPlayer.Team) and WTS(player.Character.Head.Position).Z > 0 then
            if player.Character then
                local distanceFromUs = player:DistanceFromCharacter(game:GetService("Players").LocalPlayer.Character.Head.Position or Vector3.new(0,0,0))
                if distanceFromUs < smallestPositionFound then
                    smallestPositionFound = distanceFromUs
                    nearestPlayerRightNow = player
                end
            end
        end
    end
    return nearestPlayerRightNow
end

function toggle(inputObject, gameProcessedEvent)
    if inputObject.KeyCode == Enum.KeyCode.LeftAlt then
        if _G.sound then
            toggleSound:Play()
        end
        if enabled then
            enabled = false
            warn "Off"
        else
            enabled = true
            warn "On"
        end
    end
end

RunService.RenderStepped:Connect(function()
    target = WTS(getNearestCharacterToUs().Character.Head.Position)
    if enabled then
         Input.MoveMouse(target.X - m.X, target.Y - m.Y)
    end
end)

game:GetService("UserInputService").InputBegan:connect(toggle)
