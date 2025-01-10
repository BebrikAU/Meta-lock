-- Создаем ScreenGui, чтобы разместить элементы пользовательского интерфейса
local screenGui = Instance.new('ScreenGui')
screenGui.Parent = game.Players.LocalPlayer:WaitForChild('PlayerGui')

-- Создаем рамку для кнопки и задаем размеры в зависимости от ширины экрана
local screenWidth = game:GetService('Workspace').CurrentCamera.ViewportSize.X
local buttonWidth = screenWidth * 0.15 -- Ширина кнопки 15% от ширины экрана
local buttonHeight = buttonWidth * 0.5 -- Высота кнопки 50% от её ширины
local frame = Instance.new('Frame')
frame.Size = UDim2.new(0, buttonWidth + 20, 0, buttonHeight + 20) -- Размер рамки
frame.Position = UDim2.new(0.5, -((buttonWidth + 20) / 2), 0.5, -((buttonHeight + 20) / 2)) -- Позиция рамки
frame.AnchorPoint = Vector2.new(0.5, 0.5) -- Якорная точка рамки (центр)
frame.BackgroundColor3 = Color3.new(1, 1, 1) -- Цвет рамки (белый)
frame.BorderSizePixel = 2 -- Толщина границы
frame.Parent = screenGui

-- Создаем кнопку внутри рамки
local button = Instance.new('TextButton')
button.Size = UDim2.new(1, -10, 1, -10) -- Размер кнопки (внутри рамки)
button.Position = UDim2.new(0, 5, 0, 5) -- Позиция кнопки (немного отступая от краев рамки)
button.Text = 'Нажми меня' -- Текст на кнопке
button.Parent = frame

-- Логика для перемещения рамки с кнопкой
local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService('UserInputService').InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)

-- Функция, которая будет вызываться при нажатии кнопки
function onButtonClicked()
    print('Кнопка нажата!')
    -- Выполняем серверное событие
    game:GetService("Players").LocalPlayer.Character.TackleHitbox_RE:FireServer(workspace:WaitForChild("Ball"))
end

-- Привязываем функцию к событию 'MouseButton1Click' кнопки
button.MouseButton1Click:Connect(onButtonClicked)
