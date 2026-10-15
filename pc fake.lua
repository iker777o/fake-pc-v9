-- Script: PC Fake V9 + Auto Clicker
-- Contraseña: wnexus

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Evitar duplicados
if CoreGui:FindFirstChild("PCFakeGUI_V9") then
    CoreGui.PCFakeGUI_V9:Destroy()
end

-- GUI Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PCFakeGUI_V9"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

---------------------------------------------------------
-- 1. SISTEMA DE CONTRASEÑA (KEY SYSTEM)
---------------------------------------------------------
local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeyFrame"
KeyFrame.Parent = ScreenGui
KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
KeyFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
KeyFrame.Size = UDim2.new(0, 300, 0, 180)
KeyFrame.Active = true

local UICornerKey = Instance.new("UICorner")
UICornerKey.CornerRadius = UDim.new(0, 12)
UICornerKey.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Parent = KeyFrame
KeyTitle.BackgroundTransparency = 1
KeyTitle.Position = UDim2.new(0, 0, 0, 15)
KeyTitle.Size = UDim2.new(1, 0, 0, 30)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Text = "PC FAKE - Key System"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 16

local KeyInput = Instance.new("TextBox")
KeyInput.Parent = KeyFrame
KeyInput.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyInput.Size = UDim2.new(0.8, 0, 0, 35)
KeyInput.Font = Enum.Font.Gotham
KeyInput.PlaceholderText = "Introduce la contraseña..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 14

local UICornerInput = Instance.new("UICorner")
UICornerInput.CornerRadius = UDim.new(0, 8)
UICornerInput.Parent = KeyInput

local KeyBtn = Instance.new("TextButton")
KeyBtn.Parent = KeyFrame
KeyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
KeyBtn.Position = UDim2.new(0.2, 0, 0.68, 0)
KeyBtn.Size = UDim2.new(0.6, 0, 0, 35)
KeyBtn.Font = Enum.Font.GothamBold
KeyBtn.Text = "Entrar"
KeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBtn.TextSize = 14

local UICornerBtnKey = Instance.new("UICorner")
UICornerBtnKey.CornerRadius = UDim.new(0, 8)
UICornerBtnKey.Parent = KeyBtn

---------------------------------------------------------
-- MOVIMIENTO DE PANELES (Mantener presionado 6 segundos)
---------------------------------------------------------
local function habilitarMovimientoPorTiempo(frame)
    local isHolding = false
    local canMove = false
    local holdTimer = 0

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            isHolding = true
            holdTimer = 0
            canMove = false
            
            task.spawn(function()
                while isHolding do
                    holdTimer = holdTimer + 0.1
                    if holdTimer >= 6.0 then
                        canMove = true
                        break
                    end
                    task.wait(0.1)
                end
            end)
        end
    end)

    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            isHolding = false
            canMove = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if canMove and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            local mousePos = input.Position
            frame.Position = UDim2.new(0, mousePos.X - (frame.AbsoluteSize.X / 2), 0, mousePos.Y - (frame.AbsoluteSize.Y / 2))
        end
    end)
end

---------------------------------------------------------
-- 2. PANEL DE TECLADO (Teclas sostenidas transparentes)
---------------------------------------------------------
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ToggleButton.Position = UDim2.new(0.85, 0, 0.25, 0)
ToggleButton.Size = UDim2.new(0, 100, 0, 40)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "PC Fake"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 13
ToggleButton.Visible = false

local UICornerToggle = Instance.new("UICorner")
UICornerToggle.CornerRadius = UDim.new(0, 20)
UICornerToggle.Parent = ToggleButton

local PCPanel = Instance.new("Frame")
PCPanel.Name = "PCPanel"
PCPanel.Parent = ScreenGui
PCPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
PCPanel.BackgroundTransparency = 0.4 
PCPanel.Position = UDim2.new(0.05, 0, 0.35, 0)
PCPanel.Size = UDim2.new(0, 300, 0, 320)
PCPanel.Visible = false
habilitarMovimientoPorTiempo(PCPanel)

local UICornerPanel = Instance.new("UICorner")
UICornerPanel.CornerRadius = UDim.new(0, 12)
UICornerPanel.Parent = PCPanel

local PCTitle = Instance.new("TextLabel")
PCTitle.Parent = PCPanel
PCTitle.BackgroundTransparency = 1
PCTitle.Position = UDim2.new(0, 0, 0, 5)
PCTitle.Size = UDim2.new(1, 0, 0, 20)
PCTitle.Font = Enum.Font.GothamBold
PCTitle.Text = "🖥️ Teclado (Mantén 6s para mover)"
PCTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
PCTitle.TextSize = 10

local function crearTeclaSostenida(texto, keyCode, posX, posY, sizeX, sizeY)
    local btn = Instance.new("TextButton")
    btn.Parent = PCPanel
    btn.BackgroundTransparency = 1 
    btn.Position = UDim2.new(posX, 0, posY, 0)
    btn.Size = UDim2.new(sizeX, 0, sizeY, 0)
    btn.Font = Enum.Font.GothamBold
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 15

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.5
    stroke.Thickness = 1.5
    stroke.Parent = btn

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
        end
    end)

    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
        end
    end)

    return btn
end

crearTeclaSostenida("W", Enum.KeyCode.W, 0.38, 0.15, 0.24, 0.13)
crearTeclaSostenida("A", Enum.KeyCode.A, 0.10, 0.31, 0.24, 0.13)
crearTeclaSostenida("S", Enum.KeyCode.S, 0.38, 0.31, 0.24, 0.13)
crearTeclaSostenida("D", Enum.KeyCode.D, 0.66, 0.31, 0.24, 0.13)

crearTeclaSostenida("SPACE", Enum.KeyCode.Space, 0.10, 0.48, 0.80, 0.13)
crearTeclaSostenida("SHIFT", Enum.KeyCode.LeftShift, 0.10, 0.65, 0.38, 0.13)
crearTeclaSostenida("E", Enum.KeyCode.E, 0.52, 0.65, 0.38, 0.13)

---------------------------------------------------------
-- 3. TRACKPAD + AUTO CLICKER INTEGRADO
---------------------------------------------------------
local TouchPad = Instance.new("Frame")
TouchPad.Name = "TouchPad"
TouchPad.Parent = ScreenGui
TouchPad.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
TouchPad.BackgroundTransparency = 0.3
TouchPad.Position = UDim2.new(0.65, 0, 0.50, 0)
TouchPad.Size = UDim2.new(0, 220, 0, 220)
TouchPad.Visible = false
habilitarMovimientoPorTiempo(TouchPad)

local UICornerPad = Instance.new("UICorner")
UICornerPad.CornerRadius = UDim.new(0, 12)
UICornerPad.Parent = TouchPad

local UIStrokePad = Instance.new("UIStroke")
UIStrokePad.Color = Color3.fromRGB(0, 170, 255)
UIStrokePad.Thickness = 2
UIStrokePad.Parent = TouchPad

local PadText = Instance.new("TextLabel")
PadText.Parent = TouchPad
PadText.BackgroundTransparency = 1
PadText.Position = UDim2.new(0, 0, 0.1, 0)
PadText.Size = UDim2.new(1, 0, 0, 25)
PadText.Font = Enum.Font.GothamSemibold
PadText.Text = "🖱️ Touchpad Mouse"
PadText.TextColor3 = Color3.fromRGB(200, 200, 220)
PadText.TextSize = 13

local PadSubText = Instance.new("TextLabel")
PadSubText.Parent = TouchPad
PadSubText.BackgroundTransparency = 1
PadSubText.Position = UDim2.new(0, 0, 0.23, 0)
PadSubText.Size = UDim2.new(1, 0, 0, 20)
PadSubText.Font = Enum.Font.Gotham
PadSubText.Text = "(Toca = Clic | Desliza = Mover)"
PadSubText.TextColor3 = Color3.fromRGB(130, 130, 150)
PadSubText.TextSize = 10

-- Cursor gráfico personalizado
local MouseIcon = Instance.new("ImageLabel")
MouseIcon.Name = "VirtualMouseVisible"
MouseIcon.Parent = ScreenGui
MouseIcon.BackgroundTransparency = 1
MouseIcon.Size = UDim2.new(0, 32, 0, 32)
MouseIcon.Image = "rbxassetid://6031280882"
MouseIcon.Visible = false
MouseIcon.ZIndex = 9999999
MouseIcon.Position = UDim2.new(0.5, 0, 0.5, 0)

-- Botón de Auto Clicker
local AutoClickBtn = Instance.new("TextButton")
AutoClickBtn.Name = "AutoClickBtn"
AutoClickBtn.Parent = TouchPad
AutoClickBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
AutoClickBtn.Position = UDim2.new(0.1, 0, 0.72, 0)
AutoClickBtn.Size = UDim2.new(0.8, 0, 0, 32)
AutoClickBtn.Font = Enum.Font.GothamBold
AutoClickBtn.Text = "⚡ Auto Click: OFF"
AutoClickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoClickBtn.TextSize = 12

local UICornerAutoClick = Instance.new("UICorner")
UICornerAutoClick.CornerRadius = UDim.new(0, 8)
UICornerAutoClick.Parent = AutoClickBtn

local autoClicking = false

AutoClickBtn.MouseButton1Click:Connect(function()
    autoClicking = not autoClicking
    if autoClicking then
        AutoClickBtn.Text = "⚡ Auto Click: ON"
        AutoClickBtn.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
        MouseIcon.Visible = true
        
        -- Bucle de Auto Click
        task.spawn(function()
            while autoClicking do
                VirtualInputManager:SendMouseButtonEvent(MouseIcon.AbsolutePosition.X, MouseIcon.AbsolutePosition.Y, 0, true, game, 0)
                task.wait(0.02)
                VirtualInputManager:SendMouseButtonEvent(MouseIcon.AbsolutePosition.X, MouseIcon.AbsolutePosition.Y, 0, false, game, 0)
                task.wait(0.05)
            end
        end)
    else
        AutoClickBtn.Text = "⚡ Auto Click: OFF"
        AutoClickBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
    end
end)

-- Movimiento de Mouse por Deslizamiento
local draggingMouse = false
local lastMousePos = Vector2.new(0, 0)

TouchPad.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) and input.Target ~= AutoClickBtn then
        draggingMouse = true
        MouseIcon.Visible = true
        lastMousePos = Vector2.new(input.Position.X, input.Position.Y)
        
        if not autoClicking then
            VirtualInputManager:SendMouseButtonEvent(MouseIcon.AbsolutePosition.X, MouseIcon.AbsolutePosition.Y, 0, true, game, 0)
        end
    end
end)

TouchPad.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingMouse = false
        if not autoClicking then
            VirtualInputManager:SendMouseButtonEvent(MouseIcon.AbsolutePosition.X, MouseIcon.AbsolutePosition.Y, 0, false, game, 0)
        end
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingMouse and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local currentPos = Vector2.new(input.Position.X, input.Position.Y)
        local delta = currentPos - lastMousePos
        lastMousePos = currentPos

        local currentUDim = MouseIcon.Position
        local newX = currentUDim.X.Offset + delta.X
        local newY = currentUDim.Y.Offset + delta.Y
        MouseIcon.Position = UDim2.new(0, newX, 0, newY)
    end
end)

---------------------------------------------------------
-- 4. VERIFICACIÓN DE CLAVE Y MOSTRAR/OCULTAR
---------------------------------------------------------
KeyBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == "wnexus" then
        KeyFrame:Destroy()
        ToggleButton.Visible = true
        PCPanel.Visible = true
        TouchPad.Visible = true
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "❌ Contraseña Incorrecta"
    end
end)

local panelOpen = true
ToggleButton.MouseButton1Click:Connect(function()
    panelOpen = not panelOpen
    PCPanel.Visible = panelOpen
    TouchPad.Visible = panelOpen
    if not panelOpen then
        MouseIcon.Visible = false
        autoClicking = false
        AutoClickBtn.Text = "⚡ Auto Click: OFF"
        AutoClickBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
    end
end)
