local player = game:GetService("Players").LocalPlayer
local gunshot = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gunshot")
local zombies = workspace:WaitForChild("AliveZombies")

local toggle = false

-- GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "ToggleGunGUI"

local button = Instance.new("TextButton", gui)
button.Size = UDim2.new(0, 160, 0, 50)
button.Position = UDim2.new(0, 20, 0, 100)
button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 20
button.Text = "BẮN ZOMBIE: TẮT"

button.MouseButton1Click:Connect(function()
	toggle = not toggle
	button.Text = toggle and "BẮN ZOMBIE: BẬT" or "BẮN ZOMBIE: TẮT"
	button.BackgroundColor3 = toggle and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(60, 60, 60)
end)

-- Tự động bắn (giống code gốc)
task.spawn(function()
	while task.wait(0.1) do
		if toggle then
			local character = player.Character or player.CharacterAdded:Wait()
			local tool = character and character:FindFirstChildOfClass("Tool")
			if tool then
				for _, zombie in ipairs(zombies:GetChildren()) do
					if zombie:IsA("Model") then
						local position = zombie.PrimaryPart and zombie.PrimaryPart.Position or zombie:GetModelCFrame().p
						gunshot:FireServer(tool, { zombie }, position, BrickColor.new(333), true)
					end
				end
			end
		end
	end
end)
