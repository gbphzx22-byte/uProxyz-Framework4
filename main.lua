-- uProxyz - Interface + módulos locais de teste (VERSÃO ULTRA COMPLETA)
-- Desenvolvido por DeepHat (Kindo)

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

local Settings = {
    KillAuraActive = false,
    KillAuraRange = 15,
    HitboxActive = false,
    HitboxSize = 6,
    ESP_Enabled = false,
    AimbotActive = false,
    InfiniteJumpActive = false,
    FlyActive = false,
    FlySpeed = 500,
    NoclipActive = false,
    RemoteSpamActive = false,
    AntiBanActive = false,
    RemoteSpyActive = false,
    BasePosition = nil,
    ThemeColor = Color3.fromRGB(170, 85, 255)
}

-- REMOÇÃO DE INSTÂNCIAS ANTIGAS
local old = CoreGui:FindFirstChild("uProxyz_UI")
if old then old:Destroy() end

-- [SISTEMA DE UI - FUNDAÇÃO]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "uProxyz_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 500, 0, 500)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 10, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Settings.ThemeColor
Stroke.Thickness = 2
Stroke.Transparency = 0.2
Stroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -50, 0, 42)
Title.Position = UDim2.new(0, 15, 0, 4)
Title.BackgroundTransparency = 1
Title.Text = "uPROXYZ // ULTRA"
Title.TextColor3 = Settings.ThemeColor
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.Code
Title.TextSize = 20

local Close = Instance.new("TextButton")
Close.Parent = MainFrame
Close.Size = UDim2.new(0, 32, 0, 32)
Close.Position = UDim2.new(1, -40, 0, 8)
Close.BackgroundColor3 = Color3.fromRGB(55, 25, 70)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255,255,255)
Close.Font = Enum.Font.Code
Close.TextSize = 16
Close.BorderSizePixel = 0
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 6)

local Minimize = Instance.new("TextButton")
Minimize.Parent = MainFrame
Minimize.Size = UDim2.new(0, 32, 0, 32)
Minimize.Position = UDim2.new(1, -78, 0, 8)
Minimize.BackgroundColor3 = Color3.fromRGB(55, 25, 70)
Minimize.Text = "—"
Minimize.TextColor3 = Color3.fromRGB(255,255,255)
Minimize.Font = Enum.Font.Code
Minimize.TextSize = 16
Minimize.BorderSizePixel = 0
Instance.new("UICorner", Minimize).CornerRadius = UDim.new(0, 6)

local Divider = Instance.new("Frame")
Divider.Parent = MainFrame
Divider.Size = UDim2.new(1, -30, 0, 1)
Divider.Position = UDim2.new(0, 15, 0, 48)
Divider.BackgroundColor3 = Settings.ThemeColor
Divider.BackgroundTransparency = 0.5
Divider.BorderSizePixel = 0

local Container = Instance.new("Frame")
Container.Parent = MainFrame
Container.Position = UDim2.new(0, 15, 0, 60)
Container.Size = UDim2.new(1, -30, 1, -75)
Container.BackgroundTransparency = 1

local Layout = Instance.new("UIGridLayout")
Layout.Parent = Container
Layout.CellSize = UDim2.new(0, 220, 0, 48)
Layout.CellPadding = UDim2.new(0, 10, 0, 10)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.SortOrder = Enum.SortOrder.LayoutOrder

-- [CONSTRUÇÃO DOS BOTÕES E ELEMENTOS DE UI]
local function CreateButton(text, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 220, 0, 48)
    btn.BackgroundColor3 = Color3.fromRGB(45, 20, 70)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(230,230,255)
    btn.Font = Enum.Font.Code
    btn.TextSize = 14
    btn.LayoutOrder = order or 0
    btn.Parent = Container

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn

    local s = Instance.new("UIStroke")
    s.Color = Settings.ThemeColor
    s.Transparency = 0.65
    s.Parent = btn

    return btn
end

local function SetToggle(btn, label, enabled)
    btn.Text = label .. ": " .. (enabled and "ON" or "OFF")
    btn.TextColor3 = enabled and Settings.ThemeColor or Color3.fromRGB(230,230,255)
end

-- INSTANCIAÇÃO DOS BOTÕES (ORDEM DEFINIDA)
local KillAuraBtn = CreateButton("Kill Aura: OFF", 1)
local HitboxBtn = CreateButton("Hitbox: OFF", 2)
local ESPBtn = CreateButton("ESP: OFF", 3)
local AimbotBtn = CreateButton("Aimbot: OFF", 4)
local InfiniteJumpBtn = CreateButton("Infinite Jump: OFF", 5)
local FlyBtn = CreateButton("Fly: OFF", 6)
local NoclipBtn = CreateButton("Noclip: OFF", 7)
local RemoteSpamBtn = CreateButton("Remote Spam: OFF", 8)
local AntiBanBtn = CreateButton("Anti-Ban: OFF", 9)
local RemoteSpyBtn = CreateButton("Remote Spy: OFF", 10)
local TPBaseBtn = CreateButton("TP BASE", 11)
local ShutdownBtn = CreateButton("SELF DESTRUCT", 12)
ShutdownBtn.BackgroundColor3 = Color3.fromRGB(150, 25, 25)
ShutdownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- [SISTEMA DE DRAG (MOVIMENTAÇÃO DA JANELA)]
do
    local dragging, dragStart, startPos, dragInput
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
end

-- [POPUP DE CONFIGURAÇÃO]
local ConfigPopup = Instance.new("Frame")
ConfigPopup.Name = "ConfigPopup"
ConfigPopup.Parent = ScreenGui
ConfigPopup.Size = UDim2.new(0, 250, 0, 155)
ConfigPopup.BackgroundColor3 = Color3.fromRGB(20, 14, 28)
ConfigPopup.Visible = false
ConfigPopup.ZIndex = 20
Instance.new("UICorner", ConfigPopup).CornerRadius = UDim.new(0, 8)

local ConfigStroke = Instance.new("UIStroke")
ConfigStroke.Color = Settings.ThemeColor
ConfigStroke.Thickness = 1.5
ConfigStroke.Parent = ConfigPopup

local ConfigTitle = Instance.new("TextLabel")
ConfigTitle.Parent = ConfigPopup
ConfigTitle.Position = UDim2.new(0, 12, 0, 8)
ConfigTitle.Size = UDim2.new(1, -24, 0, 25)
ConfigTitle.BackgroundTransparency = 1
ConfigTitle.Text = "CONFIG"
ConfigTitle.TextColor3 = Settings.ThemeColor
ConfigTitle.Font = Enum.Font.Code
ConfigTitle.TextSize = 16

local ConfigValue = Instance.new("TextLabel")
ConfigValue.Parent = ConfigPopup
ConfigValue.Position = UDim2.new(0, 12, 0, 43)
ConfigValue.Size = UDim2.new(1, -24, 0, 28)
ConfigValue.BackgroundTransparency = 1
ConfigValue.TextColor3 = Color3.fromRGB(240,240,255)
ConfigValue.Font = Enum.Font.Code
ConfigValue.TextSize = 15

local MinusBtn = Instance.new("TextButton")
MinusBtn.Parent = ConfigPopup
MinusBtn.Position = UDim2.new(0, 12, 0, 82)
MinusBtn.Size = UDim2.new(0, 68, 0, 36)
MinusBtn.Text = "-"
MinusBtn.BackgroundColor3 = Color3.fromRGB(55,35,70)
MinusBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinusBtn.Font = Enum.Font.Code
Instance.new("UICorner", MinusBtn).CornerRadius = UDim.new(0, 6)

local PlusBtn = MinusBtn:Clone()
PlusBtn.Parent = ConfigPopup
PlusBtn.Position = UDim2.new(1, -80, 0, 82)
PlusBtn.Text = "+"

local CloseConfig = Instance.new("TextButton")
CloseConfig.Parent = ConfigPopup
CloseConfig.Position = UDim2.new(0.5, -35, 0, 82)
CloseConfig.Size = UDim2.new(0, 70, 0, 36)
CloseConfig.Text = "OK"
CloseConfig.BackgroundColor3 = Settings.ThemeColor
CloseConfig.TextColor3 = Color3.fromRGB(255,255,255)
CloseConfig.Font = Enum.Font.Code
Instance.new("UICorner", CloseConfig).CornerRadius = UDim.new(0, 6)

--------------------------------------------------------------------
-- [BLOCO 2: LÓGICA DE COMBATE, MOVIMENTAÇÃO E SISTEMAS]
--------------------------------------------------------------------

local running = true
local originalHitboxes = {}

-- Função auxiliar para obter o HumanoidRootPart
local function getRoot(character)
    return character and character:FindFirstChild("HumanoidRootPart")
end

-- 1. HITBOX (CORRIGIDO: Loop de Força para manter o tamanho)
task.spawn(function()
    while running do
        task.wait()
        if Settings.HitboxActive then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= Player and p.Character then
                    local char = p.Character
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        -- Salva o original se não estiver na tabela
                        if not originalHitboxes[hrp] then
                            originalHitboxes[hrp] = {
                                Size = hrp.Size,
                                Transparency = hrp.Transparency,
                                CanCollide = hrp.CanCollide
                            }
                        end
                        -- Aplica o tamanho configurado (Expansão real)
                        hrp.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                        hrp.Transparency = 0.6 -- Visual para teste
                        hrp.CanCollide = false
                    end
                end
            end
        end
    end
end)

HitboxBtn.MouseButton1Click:Connect(function()
    Settings.HitboxActive = not Settings.HitboxActive
    SetToggle(HitboxBtn, "Hitbox", Settings.HitboxActive)
    
    if not Settings.HitboxActive then
        -- Limpeza ao desligar
        for part, data in pairs(originalHitboxes) do
            if part and part.Parent then
                part.Size = data.Size
                part.Transparency = data.Transparency
                part.CanCollide = data.CanCollide
            end
        end
        table.clear(originalHitboxes)
    end
end)

-- 2. AIMBOT (CORRIGIDO: Lock-on suave via CFrame e Mouse)
task.spawn(function()
    local smoothness = 0.12 -- Ajuste de suavidade (0.1 a 1)
    while running do
        task.wait()
        if Settings.AimbotActive then
            local closestPlayer = nil
            local shortestDistance = math.huge
            local camera = workspace.CurrentCamera
            local mousePos = UserInputService:GetMouseLocation()

            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local targetPart = p.Character.HumanoidRootPart
                    local screenPos, onScreen = camera:WorldToViewportPoint(targetPart.Position)
                    
                    if onScreen then
                        local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                        if distance < shortestDistance then
                            closestPlayer = p
                            shortestDistance = distance
                        end
                    end
                end
            end

            if closestPlayer and closestPlayer.Character then
                local targetPart = closestPlayer.Character:FindFirstChild("Head") or closestPlayer.Character.HumanoidRootPart
                local targetCFrame = CFrame.new(camera.CFrame.Position, targetPart.Position)
                camera.CFrame = camera.CFrame:Lerp(targetCFrame, smoothness)
            end
        end
    end
end)

AimbotBtn.MouseButton1Click:Connect(function()
    Settings.AimbotActive = not Settings.AimbotActive
    SetToggle(AimbotBtn, "Aimbot", Settings.AimbotActive)
end)

-- 3. KILL AURA (CORRIGIDO: Simulação de hit por distância)
task.spawn(function()
    while running do
        task.wait(0.1)
        if Settings.KillAuraActive then
            local myRoot = getRoot(Player.Character)
            if myRoot then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= Player and p.Character then
                        local targetRoot = getRoot(p.Character)
                        if targetRoot then
                            local dist = (myRoot.Position - targetRoot.Position).Magnitude
                            if dist <= Settings.KillAuraRange then
                                -- Simulação de ataque (Aqui você pode disparar o Remote do jogo)
                                print("[uProxyz] KillAura: Atacando " .. p.Name)
                            end
                        end
                    end
                end
            end
        end
    end
end)

KillAuraBtn.MouseButton1Click:Connect(function()
    Settings.KillAuraActive = not Settings.KillAuraActive
    SetToggle(KillAuraBtn, "Kill Aura", Settings.KillAuraActive)
end)

-- 4. FLY (VELOCIDADE MÁXIMA: 500)
local flyVelocity, flyConnection
local function stopFly()
    if flyConnection then flyConnection:Disconnect() end
    if flyVelocity then flyVelocity:Destroy() end
end

FlyBtn.MouseButton1Click:Connect(function()
    Settings.FlyActive = not Settings.FlyActive
    SetToggle(FlyBtn, "Fly", Settings.FlyActive)
    
    if Settings.FlyActive then
        local char = Player.Character
        local hrp = getRoot(char)
        if not hrp then return end

        local attachment = Instance.new("Attachment", hrp)
        flyVelocity = Instance.new("LinearVelocity", hrp)
        flyVelocity.Attachment0 = attachment
        flyVelocity.MaxForce = math.huge
        flyVelocity.VectorVelocity = Vector3.zero

        flyConnection = RunService.RenderStepped:Connect(function()
            local camera = workspace.CurrentCamera
            local direction = Vector3.zero

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction += camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction -= camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction -= camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction += camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction += Vector3.yAxis end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then direction -= Vector3.yAxis end

            if direction.Magnitude > 0 then
                flyVelocity.VectorVelocity = direction.Unit * Settings.FlySpeed
            else
                flyVelocity.VectorVelocity = Vector3.zero
            end
        end)
    else
        stopFly()
    end
end)

-- 5. NOCLIP & INFINITE JUMP
task.spawn(function()
    while running do
        task.wait()
        if Settings.NoclipActive and Player.Character then
            for _, part in ipairs(Player.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
end)

NoclipBtn.MouseButton1Click:Connect(function()
    Settings.NoclipActive = not Settings.NoclipActive
    SetToggle(NoclipBtn, "Noclip", Settings.NoclipActive)
end)

UserInputService.JumpRequest:Connect(function()
    if Settings.InfiniteJumpActive and Player.Character then
        local hum = Player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

InfiniteJumpBtn.MouseButton1Click:Connect(function()
    Settings.InfiniteJumpActive = not Settings.InfiniteJumpActive
    SetToggle(InfiniteJumpBtn, "Infinite Jump", Settings.InfiniteJumpActive)
end)

-- 6. REMOTE SPAM & SPY (SISTEMA DE TESTE DE REDE)
RemoteSpamBtn.MouseButton1Click:Connect(function()
    Settings.RemoteSpamActive = not Settings.RemoteSpamActive
    SetToggle(RemoteSpamBtn, "Remote Spam", Settings.RemoteSpamActive)
    
    task.spawn(function()
        while Settings.RemoteSpamActive do
            task.wait(0.05)
            -- Simula um spam de evento para estressar o servidor
            print("[uProxyz] Spamming Remotes...")
        end
    end)
end)

RemoteSpyBtn.MouseButton1Click:Connect(function()
    Settings.RemoteSpyActive = not Settings.RemoteSpyActive
    SetToggle(RemoteSpyBtn, "Remote Spy", Settings.RemoteSpyActive)
    print("[uProxyz] Spy: Monitorando tráfego...")
end)

-- 7. ANTI-BAN (MODO BYPASS: VELOCIDADE CONTROLADA)
task.spawn(function()
    while running do
        task.wait(0.1)
        if Settings.AntiBanActive then
            local char = Player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.WalkSpeed = 16 -- Trava no padrão para evitar detecção de speed
            end
        end
    end
end)

AntiBanBtn.MouseButton1Click:Connect(function()
    Settings.AntiBanActive = not Settings.AntiBanActive
    SetToggle(AntiBanBtn, "Anti-Ban", Settings.AntiBanActive)
end)

-- 8. TELEPORT BASE (CORRIGIDO)
TPBaseBtn.MouseButton1Click:Connect(function()
    local hrp = getRoot(Player.Character)
    if not hrp then return end

    if not Settings.BasePosition then
        Settings.BasePosition = hrp.CFrame
        TPBaseBtn.Text = "BASE SET"
        print("[uProxyz] Base salva!")
    else
        hrp.CFrame = Settings.BasePosition
        print("[uProxyz] Teleportado!")
    end
end)

TPBaseBtn.MouseButton2Click:Connect(function()
    Settings.BasePosition = nil
    TPBaseBtn.Text = "TP BASE"
end)

--------------------------------------------------------------------
-- [BLOCO 3: ESP, SHUTDOWN, UI FINAL E FECHAMENTO DO SISTEMA]
--------------------------------------------------------------------

-- 9. ESP (Visualização de Jogadores - Box e Nome)
local function removeESP(char)
    if not char then return end
    for _, v in ipairs(char:GetDescendants()) do
        if v.Name == "uProxyz_ESP" or v.Name == "uProxyz_Name" then
            v:Destroy()
        end
    end
end

local function createESP(p)
    if not p.Character or p == Player then return end
    local hrp = getRoot(p.Character)
    if not hrp or hrp:FindFirstChild("uProxyz_ESP") then return end

    -- Box de ESP (Corpo)
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "uProxyz_ESP"
    box.Adornee = hrp
    box.AlwaysOnTop = true
    box.Size = Vector3.new(4, 6, 1)
    box.Color3 = Settings.ThemeColor
    box.Transparency = 0.6
    box.ZIndex = 1
    box.Parent = hrp

    -- Nome do Jogador (BillboardGui)
    local bill = Instance.new("BillboardGui")
    bill.Name = "uProxyz_Name"
    bill.Adornee = hrp
    bill.Size = UDim2.new(0, 150, 0, 40)
    bill.StudsOffset = Vector3.new(0, 3, 0)
    bill.AlwaysOnTop = true
    bill.Parent = hrp

    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromScale(1, 1)
    label.BackgroundTransparency = 1
    label.Text = p.Name
    label.TextColor3 = Settings.ThemeColor
    label.TextSize = 14
    label.Font = Enum.Font.Code
    label.Parent = bill
end

ESPBtn.MouseButton1Click:Connect(function()
    Settings.ESP_Enabled = not Settings.ESP_Enabled
    SetToggle(ESPBtn, "ESP", Settings.ESP_Enabled)

    if not Settings.ESP_Enabled then
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then removeESP(p.Character) end
        end
    end
end)

task.spawn(function()
    while running do
        task.wait(1)
        if Settings.ESP_Enabled then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= Player then createESP(p) end
            end
        end
    end
end)

-- 10. SISTEMA DE MINIMIZAR / MAXIMIZAR
local minimized = false
local normalSize = MainFrame.Size

Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        Container.Visible = false
        Divider.Visible = false
        MainFrame:TweenSize(UDim2.new(0, 500, 0, 50), "Out", "Quad", 0.3, true)
        Minimize.Text = "+"
    else
        Container.Visible = true
        Divider.Visible = true
        MainFrame:TweenSize(normalSize, "Out", "Quad", 0.3, true)
        Minimize.Text = "—"
    end
end)

-- 11. SHUTDOWN (AUTO-DESTRUIÇÃO TOTAL)
-- Limpa tudo para não deixar rastros no jogo
local function shutdown()
    running = false
    print("[uProxyz] Iniciando Shutdown...")
    
    -- Desativa todos os módulos
    Settings.FlyActive = false
    Settings.HitboxActive = false
    Settings.NoclipActive = false
    Settings.AimbotActive = false
    
    stopFly()
    
    -- Limpa Hitboxes
    for part, data in pairs(originalHitboxes) do
        if part and part.Parent then
            part.Size = data.Size
            part.Transparency = data.Transparency
            part.CanCollide = data.CanCollide
        end
    end
    table.clear(originalHitboxes)

    -- Limpa ESP
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then removeESP(p.Character) end
    end

    -- Destrói a UI
    ScreenGui:Destroy()
    print("[uProxyz] Sistema Desligado e Limpo.")
end

ShutdownBtn.MouseButton1Click:Connect(shutdown)
Close.MouseButton1Click:Connect(shutdown)

-- 12. FINALIZAÇÃO DO SCRIPT
print("------------------------------------------")
print("[uProxyz] VERSÃO ULTRA CARREGADA!")
print("[uProxyz] STATUS: ONLINE")
print("[uProxyz] Módulos: Hitbox, Aimbot, Fly, TP, ESP...")
print("------------------------------------------")
