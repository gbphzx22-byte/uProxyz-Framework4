
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer

local Settings = {
     BrainrotActive = false,
    KillAuraActive = false,
    KillAuraRange = 15,
    HitboxActive = false,
    HitboxSize = 6,
    ESP_Enabled = false,
    AimbotActive = false,
    InfiniteJumpActive = false,
    FlyActive = false,
    FlySpeed = 100,
    NoclipActive = false,
    RemoteSpamActive = false,
    AntiBanActive = false,
    RemoteSpyActive = false,
    BasePosition = nil,
    ThemeColor = Color3.fromRGB(170, 85, 255)
}

-- [LIMPEZA]
local old = CoreGui:FindFirstChild("uProxyz_UI")
if old then old:Destroy() end

-- [CONSTRUÇÃO DA INTERFACE PRINCIPAL]
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

-- [SISTEMA DE CRIAÇÃO DE BOTÕES]
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

-- [INSTANCIAÇÃO DOS BOTÕES]
local BrainrotBtn = CreateButton("Brainrot: OFF", 13)
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

-- [SISTEMA DE CONFIGURAÇÃO POPUP]
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
ConfigTitle.TextXAlignment = Enum.TextXAlignment.Left
ConfigTitle.Font = Enum.Font.Code
ConfigTitle.TextSize = 16
ConfigTitle.ZIndex = 21

local ConfigValue = Instance.new("TextLabel")
ConfigValue.Parent = ConfigPopup
ConfigValue.Position = UDim2.new(0, 12, 0, 43)
ConfigValue.Size = UDim2.new(1, -24, 0, 28)
ConfigValue.BackgroundTransparency = 1
ConfigValue.TextColor3 = Color3.fromRGB(240,240,255)
ConfigValue.Font = Enum.Font.Code
ConfigValue.TextSize = 15
ConfigValue.ZIndex = 21

local MinusBtn = Instance.new("TextButton")
MinusBtn.Parent = ConfigPopup
MinusBtn.Position = UDim2.new(0, 12, 0, 82)
MinusBtn.Size = UDim2.new(0, 68, 0, 36)
MinusBtn.Text = "-"
MinusBtn.Font = Enum.Font.Code
MinusBtn.TextSize = 22
MinusBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinusBtn.BackgroundColor3 = Color3.fromRGB(55,35,70)
MinusBtn.BorderSizePixel = 0
MinusBtn.ZIndex = 21
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
CloseConfig.Font = Enum.Font.Code
CloseConfig.TextSize = 14
CloseConfig.TextColor3 = Color3.fromRGB(255,255,255)
CloseConfig.BackgroundColor3 = Settings.ThemeColor
CloseConfig.BorderSizePixel = 0
CloseConfig.ZIndex = 21
Instance.new("UICorner", CloseConfig).CornerRadius = UDim.new(0, 6)

local activeConfig = nil

--------------------------------------------------------------------
-- [INTEGRAÇÃO FINAL: SISTEMA DE CONFIGURAÇÃO E MENU]
--------------------------------------------------------------------

-- 1. Tabela de Configurações (Conecta os valores ao Menu)
local configs = {
    Hitbox = {
        title = "HITBOX SIZE",
        get = function() return Settings.HitboxSize end,
        set = function(v) Settings.HitboxSize = math.clamp(v, 2, 20) end,
        step = 1,
        suffix = " studs"
    },
    Fly = {
        title = "FLY SPEED",
        get = function() return Settings.FlySpeed end,
        set = function(v) Settings.FlySpeed = math.clamp(v, 10, 500) end,
        step = 10,
        suffix = ""
    },
    KillAura = {
        title = "KILL AURA RANGE",
        get = function() return Settings.KillAuraRange end,
        set = function(v) Settings.KillAuraRange = math.clamp(v, 3, 50) end,
        step = 1,
        suffix = " studs"
    }
}

-- 2. Funções de Controle do Menu
local function refreshConfig()
    if not activeConfig then return end
    ConfigTitle.Text = activeConfig.title
    ConfigValue.Text = tostring(activeConfig.get()) .. (activeConfig.suffix or "")
end

local function openConfig(config, button)
    activeConfig = config
    refreshConfig()

    local pos = button.AbsolutePosition
    local size = button.AbsoluteSize
    local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920,1080)

    local x = math.min(pos.X + size.X + 8, viewport.X - 260)
    local y = math.min(pos.Y, viewport.Y - 165)
    ConfigPopup.Position = UDim2.fromOffset(x, y)
    ConfigPopup.Visible = true
end

-- 3. Conexões de Clique (Botões + e -)
MinusBtn.MouseButton1Click:Connect(function()
    if activeConfig then
        activeConfig.set(activeConfig.get() - activeConfig.step)
        refreshConfig()
    end
end)

PlusBtn.MouseButton1Click:Connect(function()
    if activeConfig then
        activeConfig.set(activeConfig.get() + activeConfig.step)
        refreshConfig()
    end
end)

CloseConfig.MouseButton1Click:Connect(function()
    ConfigPopup.Visible = false
    activeConfig = nil
end)

-- 4. Conectando o Clique Direito nos Botões da Interface
HitboxBtn.MouseButton2Click:Connect(function() openConfig(configs.Hitbox, HitboxBtn) end)
FlyBtn.MouseButton2Click:Connect(function() openConfig(configs.Fly, FlyBtn) end)
KillAuraBtn.MouseButton2Click:Connect(function() openConfig(configs.KillAura, KillAuraBtn) end)

--------------------------------------------------------------------
-- [MÓDULO DE DRAG - ARRASTAR A JANELA]
--------------------------------------------------------------------

local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X, 
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
end

-- Detecta quando o usuário clica na janela
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

-- Detecta o movimento do mouse/toque
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

-- Atualiza a posição enquanto arrasta
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

print("[uProxyz] Sistema de Arrastar Ativado!")

--------------------------------------------------------------------
-- [BLOCO 2: LÓGICA DE COMBATE, MOVIMENTAÇÃO E CONFIGURAÇÃO]
--------------------------------------------------------------------

local running = true
local originalHitboxes = {}

-- Função auxiliar para obter o HumanoidRootPart
local function getRoot(character)
    return character and character:FindFirstChild("HumanoidRootPart")
end

-- 1. CONFIGURAÇÃO DOS VALORES (Ajustes do Menu)
local configs = {
    Hitbox = {
        title = "HITBOX SIZE",
        get = function() return Settings.HitboxSize end,
        set = function(v) Settings.HitboxSize = math.clamp(v, 2, 20) end,
        step = 1,
        suffix = " studs"
    },
    Fly = {
        title = "FLY SPEED",
        get = function() return Settings.FlySpeed end,
        set = function(v) Settings.FlySpeed = math.clamp(v, 10, 500) end,
        step = 10,
        suffix = ""
    },
    KillAura = {
        title = "KILL AURA RANGE",
        get = function() return Settings.KillAuraRange end,
        set = function(v) Settings.KillAuraRange = math.clamp(v, 3, 50) end,
        step = 1,
        suffix = " studs"
    }
}

-- Funções do Menu de Configuração
local function refreshConfig()
    if not activeConfig then return end
    ConfigTitle.Text = activeConfig.title
    ConfigValue.Text = tostring(activeConfig.get()) .. (activeConfig.suffix or "")
end

local function openConfig(config, button)
    activeConfig = config
    refreshConfig()

    local pos = button.AbsolutePosition
    local size = button.AbsoluteSize
    local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920,1080)

    local x = math.min(pos.X + size.X + 8, viewport.X - 260)
    local y = math.min(pos.Y, viewport.Y - 165)
    ConfigPopup.Position = UDim2.fromOffset(x, y)
    ConfigPopup.Visible = true
end

-- Eventos do Menu (+ e -)
MinusBtn.MouseButton1Click:Connect(function()
    if activeConfig then
        activeConfig.set(activeConfig.get() - activeConfig.step)
        refreshConfig()
    end
end)

PlusBtn.MouseButton1Click:Connect(function()
    if activeConfig then
        activeConfig.set(activeConfig.get() + activeConfig.step)
        refreshConfig()
    end
end)

CloseConfig.MouseButton1Click:Connect(function()
    ConfigPopup.Visible = false
    activeConfig = nil
end)

-- Conectando o Clique Direito nos Botões
HitboxBtn.MouseButton2Click:Connect(function() openConfig(configs.Hitbox, HitboxBtn) end)
FlyBtn.MouseButton2Click:Connect(function() openConfig(configs.Fly, FlyBtn) end)
KillAuraBtn.MouseButton2Click:Connect(function() openConfig(configs.KillAura, KillAuraBtn) end)

-- 2. HITBOX (CORRIGIDO: Loop de Força para manter o tamanho)
task.spawn(function()
    while running do
        task.wait()
        if Settings.HitboxActive then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= Player and p.Character then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        if not originalHitboxes[hrp] then
                            originalHitboxes[hrp] = {
                                Size = hrp.Size,
                                Transparency = hrp.Transparency,
                                CanCollide = hrp.CanCollide
                            }
                        end
                        hrp.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                        hrp.Transparency = 0.6
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

-- 3. AIMBOT (CORRIGIDO: Lock-on suave via CFrame)
task.spawn(function()
    local smoothness = 0.12 
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

-- 4. KILL AURA (CORRIGIDO)
task.spawn(function()
    while running do
        task.wait(0.1)
        if Settings.KillAuraActive then
            local myRoot = getRoot(Player.Character)
            if myRoot then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= Player and p.Character then
                        local targetRoot = getRoot(p.Character)
                        if targetRoot and (myRoot.Position - targetRoot.Position).Magnitude <= Settings.KillAuraRange then
                            print("[uProxyz] KillAura: Atacando " .. p.Name)
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

-- 5. FLY (CORRIGIDO: PlataformStand para evitar lentidão)
local flyVelocity, flyConnection, flyAttachment
local function stopFly()
    if flyConnection then flyConnection:Disconnect() end
    if flyVelocity then flyVelocity:Destroy() end
    if flyAttachment then flyAttachment:Destroy() end
    local char = Player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.PlatformStand = false end
end

FlyBtn.MouseButton1Click:Connect(function()
    Settings.FlyActive = not Settings.FlyActive
    SetToggle(FlyBtn, "Fly", Settings.FlyActive)
    
    if Settings.FlyActive then
        local char = Player.Character
        local hrp = getRoot(char)
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end

        hum.PlatformStand = true 

        flyAttachment = Instance.new("Attachment", hrp)
        flyVelocity = Instance.new("LinearVelocity", hrp)
        flyVelocity.Attachment0 = flyAttachment
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

-- 6. NOCLIP & INFINITE JUMP
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

-------------------------------------------------------------------
-- [BRAINROT DUPER: REMOTE EVENT STRESS TEST]
--------------------------------------------------------------------

local function getAllRemotes()
    local remotes = {}
    for _, v in ipairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            table.insert(remotes, v)
        end
    end
    return remotes
end

local function startBrainrotDuper()
    local remotes = getAllRemotes()
    if #remotes == 0 then
        print("[uProxyz] Nenhum Remote encontrado para duplicar!")
        return
    end

    print("[uProxyz] Iniciando Duper de Brainrot... 💀")

    task.spawn(function()
        while Settings.RemoteSpamActive do
            -- Escolhe um remote aleatório da lista
            local targetRemote = remotes[math.random(1, #remotes)]
            
            if targetRemote:IsA("RemoteEvent") then
                -- Dispara o evento com argumentos "lixo" (Brainrot) para tentar quebrar a lógica
                targetRemote:FireServer(
                    "Brainrot", 
                    math.random(1, 100), 
                    "Skibidi", 
                    true, 
                    Instance.new("Part") -- Tenta enviar uma instância para estressar o servidor
                )
            elseif targetRemote:IsA("RemoteFunction") then
                -- Tenta chamar a função com argumentos aleatórios
                targetRemote:InvokeServer("Brainrot_Dupe", math.random(1, 1000))
            end

            -- Delay mínimo para não crashar o SEU cliente instantaneamente
            -- Mas rápido o suficiente para estressar o servidor
            task.wait(0.01) 
            
            -- Log de progresso no console para você ver o spam acontecendo
            if math.random(1, 50) == 1 then
                print("[uProxyz Duper] Spamming: " .. targetRemote.Name)
            end
        end
    end)
end

-- Conectando ao seu botão de Remote Spam
RemoteSpamBtn.MouseButton1Click:Connect(function()
    Settings.RemoteSpamActive = not Settings.RemoteSpamActive
    SetToggle(RemoteSpamBtn, "Remote Spam", Settings.RemoteSpamActive)
    
    if Settings.RemoteSpamActive then
        -- Inicia o processo de estresse
        startBrainrotDuper()
    else
        print("[uProxyz] Duper de Brainrot parado.")
    end
end)

--------------------------------------------------------------------

-- 8. ANTI-BAN & TP BASE
task.spawn(function()
    while running do
        task.wait(0.1)
        if Settings.AntiBanActive then
            local char = Player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = 16 end
        end
    end
end)

AntiBanBtn.MouseButton1Click:Connect(function()
    Settings.AntiBanActive = not Settings.AntiBanActive
    SetToggle(AntiBanBtn, "Anti-Ban", Settings.AntiBanActive)
end)

TPBaseBtn.MouseButton1Click:Connect(function()
    local hrp = getRoot(Player.Character)
    if not hrp then return end
    if not Settings.BasePosition then
        Settings.BasePosition = hrp.CFrame
        TPBaseBtn.Text = "BASE SET"
    else
        hrp.CFrame = Settings.BasePosition
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
local function shutdown()
    running = false
    print("[uProxyz] Iniciando Shutdown...")
    
    -- Desativa todos os módulos
    Settings.FlyActive = false
    Settings.HitboxActive = false
    Settings.NoclipActive = false
    Settings.AimbotActive = false
    
    stopFly()
    
    -- Limpa Hitboxes (Restaura o tamanho original)
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
