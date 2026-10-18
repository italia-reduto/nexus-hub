-- Serviços Necessários
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove versões anteriores se existirem
if playerGui:FindFirstChild("FlyMenuGui") then
	playerGui.FlyMenuGui:Destroy()
end

---------------------------------------------------------
-- 1. CRIAÇÃO DA INTERFACE GRÁFICA AVANÇADA
---------------------------------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlyMenuGui"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999
screenGui.Parent = playerGui

-- Janela Principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 360, 0, 370)
mainFrame.Position = UDim2.new(0.5, -180, 0.5, -185)
mainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(45, 45, 55)
mainStroke.Thickness = 1.5
mainStroke.Parent = mainFrame

-- Barra Superior
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 46)
topBar.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 14)
topCorner.Parent = topBar

local topCover = Instance.new("Frame")
topCover.Size = UDim2.new(1, 0, 0, 10)
topCover.Position = UDim2.new(0, 0, 1, -10)
topCover.BackgroundColor3 = Color3.fromRGB(32, 32, 38)
topCover.BorderSizePixel = 0
topCover.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 16, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚡ Nexus Hub"
titleLabel.TextColor3 = Color3.fromRGB(240, 240, 245)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 32, 0, 32)
minimizeButton.Position = UDim2.new(1, -40, 0.5, -16)
minimizeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextSize = 18
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Parent = topBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minimizeButton

local floatingBlock = Instance.new("TextButton")
floatingBlock.Name = "FloatingBlock"
floatingBlock.Size = UDim2.new(0, 65, 0, 65)
floatingBlock.Position = UDim2.new(0.05, 0, 0.2, 0)
floatingBlock.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
floatingBlock.Text = "MENU"
floatingBlock.TextColor3 = Color3.fromRGB(255, 255, 255)
floatingBlock.TextSize = 13
floatingBlock.Font = Enum.Font.GothamBold
floatingBlock.Visible = false
floatingBlock.Parent = screenGui

local blockCorner = Instance.new("UICorner")
blockCorner.CornerRadius = UDim.new(0, 16)
blockCorner.Parent = floatingBlock

local blockStroke = Instance.new("UIStroke")
blockStroke.Color = Color3.fromRGB(255, 255, 255)
blockStroke.Thickness = 2
blockStroke.Parent = floatingBlock

-- Container Interno do Conteúdo
local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, -32, 1, -66)
contentContainer.Position = UDim2.new(0, 16, 0, 56)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = mainFrame

-- 1. BOTÃO FLY
local flyToggleButton = Instance.new("TextButton")
flyToggleButton.Size = UDim2.new(1, 0, 0, 50)
flyToggleButton.Position = UDim2.new(0, 0, 0, 0)
flyToggleButton.BackgroundColor3 = Color3.fromRGB(190, 45, 45)
flyToggleButton.Text = "🚀  Fly: DESLIGADO"
flyToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyToggleButton.TextSize = 15
flyToggleButton.Font = Enum.Font.GothamBold
flyToggleButton.Parent = contentContainer

local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 10)
flyCorner.Parent = flyToggleButton

-- 2. CARD DE VELOCIDADE
local speedCard = Instance.new("Frame")
speedCard.Size = UDim2.new(1, 0, 0, 65)
speedCard.Position = UDim2.new(0, 0, 0, 62)
speedCard.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
speedCard.BorderSizePixel = 0
speedCard.Parent = contentContainer

local cardCorner = Instance.new("UICorner")
cardCorner.CornerRadius = UDim.new(0, 10)
cardCorner.Parent = speedCard

local speedTitle = Instance.new("TextLabel")
speedTitle.Size = UDim2.new(1, -20, 0, 20)
speedTitle.Position = UDim2.new(0, 14, 0, 8)
speedTitle.BackgroundTransparency = 1
speedTitle.Text = "Controle de Velocidade (Arraste ↔)"
speedTitle.TextColor3 = Color3.fromRGB(160, 160, 175)
speedTitle.TextSize = 12
speedTitle.Font = Enum.Font.GothamMedium
speedTitle.TextXAlignment = Enum.TextXAlignment.Left
speedTitle.Parent = speedCard

local speedDisplayContainer = Instance.new("Frame")
speedDisplayContainer.Size = UDim2.new(1, -28, 0, 28)
speedDisplayContainer.Position = UDim2.new(0, 14, 0, 28)
speedDisplayContainer.BackgroundTransparency = 1
speedDisplayContainer.Parent = speedCard

local speedTextLabel = Instance.new("TextLabel")
speedTextLabel.Size = UDim2.new(0.6, 0, 1, 0)
speedTextLabel.BackgroundTransparency = 1
speedTextLabel.Text = "Velocidade Atual:"
speedTextLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
speedTextLabel.TextSize = 14
speedTextLabel.Font = Enum.Font.GothamBold
speedTextLabel.TextXAlignment = Enum.TextXAlignment.Left
speedTextLabel.Parent = speedDisplayContainer

local speedDisplay = Instance.new("TextLabel")
speedDisplay.Size = UDim2.new(0.4, 0, 1, 0)
speedDisplay.Position = UDim2.new(0.6, 0, 0, 0)
speedDisplay.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
speedDisplay.Text = "50"
speedDisplay.TextColor3 = Color3.fromRGB(0, 255, 128)
speedDisplay.TextSize = 15
speedDisplay.Font = Enum.Font.GothamBold
speedDisplay.Parent = speedDisplayContainer

local displayCorner = Instance.new("UICorner")
displayCorner.CornerRadius = UDim.new(0, 6)
displayCorner.Parent = speedDisplay

-- 3. BOTÃO ESP
local espToggleButton = Instance.new("TextButton")
espToggleButton.Size = UDim2.new(1, 0, 0, 50)
espToggleButton.Position = UDim2.new(0, 0, 0, 139)
espToggleButton.BackgroundColor3 = Color3.fromRGB(190, 45, 45)
espToggleButton.Text = "👁️  ESP Jogadores: DESLIGADO"
espToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espToggleButton.TextSize = 15
espToggleButton.Font = Enum.Font.GothamBold
espToggleButton.Parent = contentContainer

local espCorner = Instance.new("UICorner")
espCorner.CornerRadius = UDim.new(0, 10)
espCorner.Parent = espToggleButton

-- Rodapé
local footerLabel = Instance.new("TextLabel")
footerLabel.Size = UDim2.new(1, 0, 0, 25)
footerLabel.Position = UDim2.new(0, 0, 0, 202)
footerLabel.BackgroundTransparency = 1
footerLabel.Text = "Sistema Otimizado para Mobile & PC"
footerLabel.TextColor3 = Color3.fromRGB(100, 100, 115)
footerLabel.TextSize = 11
footerLabel.Font = Enum.Font.Gotham
footerLabel.TextXAlignment = Enum.TextXAlignment.Center
footerLabel.Parent = contentContainer

---------------------------------------------------------
-- 2. SISTEMA DE ARRASTAR O PAINEL
---------------------------------------------------------
local dragging, dragInput, dragStart, startPos

topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

RunService.RenderStepped:Connect(function()
	if dragging and dragInput then
		local delta = dragInput.Position - dragStart
		mainFrame.Position = UDim2.new(
			startPos.X.Scale, 
			startPos.X.Offset + delta.X, 
			startPos.Y.Scale, 
			startPos.Y.Offset + delta.Y
		)
	end
end)

---------------------------------------------------------
-- 3. MINIMIZAR E TRANSFORMAR EM BLOCO
---------------------------------------------------------
minimizeButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	floatingBlock.Visible = true
end)

floatingBlock.MouseButton1Click:Connect(function()
	floatingBlock.Visible = false
	mainFrame.Visible = true
end)

---------------------------------------------------------
-- 4. CONTROLE DE VELOCIDADE POR GESTO DE ARRASTAR
---------------------------------------------------------
local flySpeed = 50
local adjustingSpeed = false
local startTouchX = 0
local initialSpeedOnTouch = 50

speedCard.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		adjustingSpeed = true
		startTouchX = input.Position.X
		initialSpeedOnTouch = flySpeed
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				adjustingSpeed = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if adjustingSpeed and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local currentX = input.Position.X
		local deltaX = currentX - startTouchX
		
		local newSpeed = initialSpeedOnTouch + math.floor(deltaX / 1.5)
		
		if newSpeed > 200 then
			newSpeed = 200
		elseif newSpeed < 1 then
			newSpeed = 1
		end
		
		flySpeed = newSpeed
		speedDisplay.Text = tostring(flySpeed)
	end
end)

---------------------------------------------------------
-- 5. SISTEMA DE ESP (TRACERS 3D RGB DO TORSO)
---------------------------------------------------------
local espEnabled = false
local espElements = {}
local myAttachment = nil

local function getMyAttachment()
	local myChar = player.Character
	if not myChar then return nil end
	local myRoot = myChar:FindFirstChild("HumanoidRootPart")
	if not myRoot then return nil end
	
	if not myAttachment or myAttachment.Parent ~= myRoot then
		if myAttachment then myAttachment:Destroy() end
		myAttachment = Instance.new("Attachment")
		myAttachment.Name = "MyESP_TracerAttachment"
		myAttachment.Parent = myRoot
	end
	return myAttachment
end

local function removeESPForPlayer(otherPlayer)
	if espElements[otherPlayer] then
		if espElements[otherPlayer].billboard then espElements[otherPlayer].billboard:Destroy() end
		if espElements[otherPlayer].beam then espElements[otherPlayer].beam:Destroy() end
		if espElements[otherPlayer].targetAttachment then espElements[otherPlayer].targetAttachment:Destroy() end
		espElements[otherPlayer] = nil
	end
	if otherPlayer.Character then
		local hl = otherPlayer.Character:FindFirstChild("CustomESPHighlight")
		if hl then hl:Destroy() end
	end
end

local function setupESPForPlayer(otherPlayer)
	if otherPlayer == player then return end
	
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "ESP_Info"
	billboard.Size = UDim2.new(0, 200, 0, 50)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true
	billboard.Enabled = false
	billboard.Parent = screenGui
	
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.TextStrokeTransparency = 0
	textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	textLabel.TextSize = 13
	textLabel.Font = Enum.Font.GothamBold
	textLabel.Parent = billboard
	
	local beam = Instance.new("Beam")
	beam.Width0 = 0.15
	beam.Width1 = 0.15
	beam.FaceCamera = true
	beam.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
	beam.Transparency = NumberSequence.new(0)
	beam.Enabled = false
	beam.Parent = workspace
	
	espElements[otherPlayer] = {
		billboard = billboard,
		textLabel = textLabel,
		beam = beam,
		targetAttachment = nil
	}
	
	otherPlayer.CharacterRemoving:Connect(function()
		removeESPForPlayer(otherPlayer)
	end)
end

for _, p in ipairs(Players:GetPlayers()) do
	setupESPForPlayer(p)
end
Players.PlayerAdded:Connect(setupESPForPlayer)
Players.PlayerRemoving:Connect(removeESPForPlayer)

RunService.RenderStepped:Connect(function()
	if not espEnabled then return end
	
	local myAtt = getMyAttachment()
	local myChar = player.Character
	local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
	
	local tickTime = tick() * 2
	local rgbColor = Color3.fromHSV((tickTime % 5) / 5, 1, 1)
	local colorSeq = ColorSequence.new(rgbColor)
	
	for _, otherPlayer in ipairs(Players:GetPlayers()) do
		if otherPlayer ~= player then
			local elements = espElements[otherPlayer]
			local otherChar = otherPlayer.Character
			local otherRoot = otherChar and otherChar:FindFirstChild("HumanoidRootPart")
			
			if otherChar and otherRoot and elements and myAtt then
				local highlight = otherChar:FindFirstChild("CustomESPHighlight")
				if not highlight then
					highlight = Instance.new("Highlight")
					highlight.Name = "CustomESPHighlight"
					highlight.Adornee = otherChar
					highlight.FillColor = Color3.fromRGB(255, 50, 50)
					highlight.FillTransparency = 0.5
					highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
					highlight.OutlineTransparency = 0
					highlight.Parent = otherChar
				end
				
				if not elements.targetAttachment or elements.targetAttachment.Parent ~= otherRoot then
					if elements.targetAttachment then elements.targetAttachment:Destroy() end
					local targetAtt = Instance.new("Attachment")
					targetAtt.Name = "TargetESP_Attachment"
					targetAtt.Parent = otherRoot
					elements.targetAttachment = targetAtt
				end
				
				elements.beam.Attachment0 = myAtt
				elements.beam.Attachment1 = elements.targetAttachment
				elements.beam.Color = colorSeq
				elements.beam.Enabled = true
				
				elements.billboard.Adornee = otherRoot
				elements.billboard.Enabled = true
				
				local distance = myRoot and math.floor((otherRoot.Position - myRoot.Position).Magnitude) or 0
				elements.textLabel.Text = otherPlayer.Name .. " [" .. distance .. "m]"
			else
				if elements then
					if elements.beam then elements.beam.Enabled = false end
					if elements.billboard then elements.billboard.Enabled = false end
				end
			end
		end
	end
end)

local function toggleESP()
	espEnabled = not espEnabled
	
	if espEnabled then
		espToggleButton.Text = "👁️  ESP Jogadores: LIGADO"
		espToggleButton.BackgroundColor3 = Color3.fromRGB(45, 180, 75)
	else
		espToggleButton.Text = "👁️  ESP Jogadores: DESLIGADO"
		espToggleButton.BackgroundColor3 = Color3.fromRGB(190, 45, 45)
		
		for _, elements in pairs(espElements) do
			if elements.billboard then elements.billboard.Enabled = false end
			if elements.beam then elements.beam.Enabled = false end
		end
		for _, p in ipairs(Players:GetPlayers()) do
			if p.Character then
				local hl = p.Character:FindFirstChild("CustomESPHighlight")
				if hl then hl:Destroy() end
			end
		end
	end
end

espToggleButton.MouseButton1Click:Connect(toggleESP)

---------------------------------------------------------
-- 6. SISTEMA DE VOO
---------------------------------------------------------
local flying = false
local bodyVelocity, bodyGyro

local function startFlying()
	local character = player.Character
	if not character then return end
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	
	if not rootPart or not humanoid then return end
	
	flying = true
	flyToggleButton.Text = "🚀  Fly: LIGADO"
	flyToggleButton.BackgroundColor3 = Color3.fromRGB(45, 180, 75)
	
	humanoid.PlatformStand = true
	
	bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bodyVelocity.Velocity = Vector3.new(0, 0, 0)
	bodyVelocity.Parent = rootPart
	
	bodyGyro = Instance.new("BodyGyro")
	bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	bodyGyro.P = 10000
	bodyGyro.CFrame = rootPart.CFrame
	bodyGyro.Parent = rootPart
end

local function stopFlying()
	flying = false
	flyToggleButton.Text = "🚀  Fly: DESLIGADO"
	flyToggleButton.BackgroundColor3 = Color3.fromRGB(190, 45, 45)
	
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.PlatformStand = false
		end
	end
	
	if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
	if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
end

flyToggleButton.MouseButton1Click:Connect(function()
	if flying then
		stopFlying()
	else
		startFlying()
	end
end)

RunService.RenderStepped:Connect(function()
	if flying then
		local character = player.Character
		if not character then return end
		local rootPart = character:FindFirstChild("HumanoidRootPart")
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		
		if not rootPart or not bodyVelocity or not bodyGyro then return end
		
		local camera = workspace.CurrentCamera
		local moveVector = humanoid.MoveDirection
		
		if moveVector.Magnitude > 0 then
			local look = camera.CFrame.LookVector
			local dot = moveVector:Dot(look)
			
			if dot > 0.1 then
				bodyVelocity.Velocity = look * flySpeed
			elseif dot < -0.1 then
				bodyVelocity.Velocity = -look * flySpeed
			else
				bodyVelocity.Velocity = Vector3.new(0, 0, 0)
			end
		else
			bodyVelocity.Velocity = Vector3.new(0, 0, 0)
		end
		
		bodyGyro.CFrame = camera.CFrame
	end
end)

player.CharacterAdded:Connect(function()
	stopFlying()
end)
