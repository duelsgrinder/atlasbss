local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")
local lp = Players.LocalPlayer

local teleporting = false

local function okay()
    if teleporting then return end 
    teleporting = true

    task.wait(7)

    local success, _ = pcall(function()
        if game.JobId ~= "" then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
        else
            TeleportService:Teleport(game.PlaceId, lp)
        end
    end)

    task.wait(5)
    teleporting = false
end

GuiService.ErrorMessageChanged:Connect(function()
    okay()
end)

lp.Idled:Connect(function()
    local vu = game:GetService("VirtualUser")
    vu:CaptureController()
    vu:ClickButton2(Vector2.new())
end)

settings().Rendering.QualityLevel = 1
