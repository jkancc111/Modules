local UILibrary = {}

-- Configuration dengan tema yang mirip key system
local config = {
    Title = "LomuHub",
    SubTitle = "Game Library",
    MainColor = Color3.fromRGB(20, 20, 25),    -- Dark background
    SecondaryColor = Color3.fromRGB(30, 30, 35), -- Slightly lighter
    AccentColor = Color3.fromRGB(147, 112, 219), -- Purple accent
    TextColor = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(180, 180, 180),
    Font = Enum.Font.GothamBold,
    SubFont = Enum.Font.Gotham,
    CornerRadius = UDim.new(0, 8),
    AnimationSpeed = 0.6,
    AnimationSpeedFast = 0.3,
    EasingStyle = Enum.EasingStyle.Quint,
    EasingDirection = Enum.EasingDirection.Out,
    ShadowTransparency = 0.5,
    GameItemHeight = 90,
    ButtonHeight = 40
}

-- Fungsi helper untuk membuat animasi yang lebih smooth
local function smoothTween(object, duration, properties)
    return game:GetService("TweenService"):Create(
        object,
        TweenInfo.new(
            duration or config.AnimationSpeed,
            config.EasingStyle,
            config.EasingDirection
        ),
        properties
    )
end

-- Create a new hub instance
function UILibrary.new(customConfig)
    local hub = {}
    
    -- Main container setup
    local ScreenGui = Instance.new("ScreenGui")
    local MainContainer = Instance.new("Frame")
    local MainFrame = Instance.new("Frame")
    local Shadow = Instance.new("ImageLabel")
    
    -- Setup like key system UI
    MainContainer.Size = UDim2.new(0, 800, 0, 400)
    MainContainer.Position = UDim2.new(0.5, -400, 0.5, -200)
    MainContainer.BackgroundTransparency = 1
    
    MainFrame.Size = UDim2.new(0, 400, 1, 0)
    MainFrame.BackgroundColor3 = config.MainColor
    MainFrame.Position = UDim2.new(0, 0, 0, 0)
    
    -- Add shadow effect
    Shadow.Image = "rbxassetid://7912134082"
    Shadow.ImageColor3 = config.AccentColor
    Shadow.ImageTransparency = config.ShadowTransparency
    Shadow.Size = UDim2.new(1.2, 0, 1.2, 0)
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    
    -- Add top bar with title
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.BackgroundColor3 = config.SecondaryColor
    
    local Title = Instance.new("TextLabel")
    Title.Text = config.Title
    Title.Font = config.Font
    Title.TextSize = 24
    Title.TextColor3 = config.TextColor
    Title.Position = UDim2.new(0, 20, 0, 10)
    
    local SubTitle = Instance.new("TextLabel")
    SubTitle.Text = config.SubTitle
    SubTitle.Font = config.SubFont
    SubTitle.TextSize = 14
    SubTitle.TextColor3 = config.TextDark
    SubTitle.Position = UDim2.new(0, 20, 0, 35)
    
    -- Game list container with modern scroll
    local GameList = Instance.new("ScrollingFrame")
    GameList.Size = UDim2.new(1, -40, 1, -70)
    GameList.Position = UDim2.new(0, 20, 0, 60)
    GameList.BackgroundTransparency = 1
    GameList.ScrollBarThickness = 3
    GameList.ScrollBarImageColor3 = config.AccentColor
    
    -- Add game function with modern design
    function hub:AddGame(gameData)
        local GameItem = Instance.new("Frame")
        GameItem.Size = UDim2.new(1, 0, 0, config.GameItemHeight)
        GameItem.BackgroundColor3 = config.SecondaryColor
        
        -- Add hover effects
        local hoverTween = TweenService:Create(GameItem, 
            TweenInfo.new(0.3, config.EasingStyle, config.EasingDirection),
            {BackgroundColor3 = Color3.fromRGB(40, 40, 45)}
        )
        
        GameItem.MouseEnter:Connect(function()
            hoverTween:Play()
        end)
        
        -- Add play button with glow effect
        local PlayButton = Instance.new("ImageButton")
        PlayButton.Size = UDim2.new(0, 40, 0, 40)
        PlayButton.Position = UDim2.new(1, -50, 0.5, -20)
        PlayButton.BackgroundColor3 = config.AccentColor
        
        local ButtonGlow = Instance.new("ImageLabel")
        ButtonGlow.Image = "rbxassetid://7912134082"
        ButtonGlow.ImageColor3 = config.AccentColor
        ButtonGlow.ImageTransparency = 0.7
        ButtonGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
        ButtonGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
        ButtonGlow.AnchorPoint = Vector2.new(0.5, 0.5)
        
        -- Add game info with modern typography
        local GameName = Instance.new("TextLabel")
        GameName.Text = gameData.Name
        GameName.Font = config.Font
        GameName.TextSize = 18
        GameName.TextColor3 = config.TextColor
        
        local GameStatus = Instance.new("TextLabel")
        GameStatus.Text = "Status: " .. (gameData.Status or "Unknown")
        GameStatus.Font = config.SubFont
        GameStatus.TextSize = 14
        GameStatus.TextColor3 = config.TextDark
        
        -- Add animations
        local function playClickAnimation()
            TweenService:Create(PlayButton,
                TweenInfo.new(0.2, config.EasingStyle, config.EasingDirection),
                {Size = UDim2.new(0, 38, 0, 38)}
            ):Play()
            
            TweenService:Create(ButtonGlow,
                TweenInfo.new(0.3, config.EasingStyle, config.EasingDirection),
                {ImageTransparency = 0.5}
            ):Play()
        end
        
        PlayButton.MouseButton1Click:Connect(function()
            playClickAnimation()
            if gameData.Callback then
                gameData.Callback()
            end
        end)
        
        return GameItem
    end
    
    -- Add minimize/close buttons with animations
    local function addControlButtons()
        local CloseButton = Instance.new("ImageButton")
        CloseButton.Size = UDim2.new(0, 24, 0, 24)
        CloseButton.Position = UDim2.new(1, -30, 0, 13)
        CloseButton.Image = "rbxassetid://11293981586"
        CloseButton.ImageColor3 = config.TextDark
        
        local MinimizeButton = Instance.new("ImageButton")
        MinimizeButton.Size = UDim2.new(0, 24, 0, 24)
        MinimizeButton.Position = UDim2.new(1, -60, 0, 13)
        MinimizeButton.Image = "rbxassetid://7072718840"
        MinimizeButton.ImageColor3 = config.TextDark
        
        -- Add hover effects
        local function addButtonHoverEffect(button)
            button.MouseEnter:Connect(function()
                TweenService:Create(button,
                    TweenInfo.new(0.2),
                    {ImageTransparency = 0}
                ):Play()
            end)
            
            button.MouseLeave:Connect(function()
                TweenService:Create(button,
                    TweenInfo.new(0.2),
                    {ImageTransparency = 0.4}
                ):Play()
            end)
        end
        
        addButtonHoverEffect(CloseButton)
        addButtonHoverEffect(MinimizeButton)
        
        return CloseButton, MinimizeButton
    end
    
    -- Initialize UI with smooth animations
    local function initializeUI()
        MainContainer.Position = UDim2.new(0.5, -400, -0.5, -200)
        
        local openTween = TweenService:Create(MainContainer,
            TweenInfo.new(0.8, config.EasingStyle, config.EasingDirection),
            {Position = UDim2.new(0.5, -400, 0.5, -200)}
        )
        
        openTween:Play()
    end
    
    initializeUI()
    return hub
end

-- Create Start Menu Function
function UILibrary.CreateStartMenu(customConfig, hubCallback, universalCallback)
    local startMenu = {}
    local userConfig = customConfig or {}
    
    -- Apply custom config if provided
    for key, value in pairs(userConfig) do
        config[key] = value
    end
    
    -- Main GUI elements for start menu
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Shadow = Instance.new("ImageLabel")
    local AvatarSection = Instance.new("Frame")
    local AvatarImage = Instance.new("ImageLabel")
    local AvatarLabel = Instance.new("TextLabel")
    local NameSection = Instance.new("Frame")
    local NameLabel = Instance.new("TextLabel")
    local ButtonHubSection = Instance.new("Frame")
    local ButtonHub = Instance.new("TextButton")
    local ButtonHubCorner = Instance.new("UICorner")
    local ButtonUniversalSection = Instance.new("Frame")
    local ButtonUniversal = Instance.new("TextButton")
    local ButtonUniversalCorner = Instance.new("UICorner")
    
    -- Set up ScreenGui
    ScreenGui.Name = "LomuStartMenuGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 9999
    ScreenGui.IgnoreGuiInset = true
    
    -- Check if game is running on mobile
    local isMobile = (game:GetService("UserInputService").TouchEnabled and 
                      not game:GetService("UserInputService").KeyboardEnabled and
                      not game:GetService("UserInputService").MouseEnabled)
    
    -- Setup MainFrame for start menu (bar at the bottom)
    MainFrame.Name = "StartMenuFrame"
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 15, 5) -- Dark orange background
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 1, -config.StartMenuHeight - 15) -- Slightly higher from bottom
    MainFrame.AnchorPoint = Vector2.new(0.5, 0) -- Anchor at center top
    MainFrame.Size = UDim2.new(0, 700, 0, config.StartMenuHeight) -- Smaller but proportional
    
    -- Ensure visibility
    MainFrame.BackgroundTransparency = 0
    MainFrame.ZIndex = 10000
    
    -- Mobile and small screen adjustments
    if isMobile then
        MainFrame.Size = UDim2.new(0.9, 0, 0, config.StartMenuHeight)
    elseif MainFrame.AbsoluteSize.X > 800 then
        MainFrame.Size = UDim2.new(0.7, 0, 0, config.StartMenuHeight)
    end
    
    -- Add rounded corners
    UICorner.CornerRadius = UDim.new(0, 10) -- More rounded corners
    UICorner.Parent = MainFrame
    
    -- Add orange-tinted shadow
    Shadow.Name = "Shadow"
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://5028857084" -- Drop shadow image
    Shadow.ImageColor3 = Color3.fromRGB(50, 25, 0) -- Orange-tinted shadow
    Shadow.ImageTransparency = 0.5 -- Stronger shadow
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.Size = UDim2.new(1, 50, 1, 50) -- Larger shadow
    Shadow.ZIndex = -1
    Shadow.Parent = MainFrame
    
    -- Hapus SectionLayout lama dan ganti dengan HorizontalLayout
    if MainFrame:FindFirstChild("UIGridLayout") then
        MainFrame:FindFirstChild("UIGridLayout"):Destroy()
    end
    
    -- Buat layout horizontal yang tetap dengan 4 bagian yang sama
    local HorizontalLayout = Instance.new("UIListLayout")
    HorizontalLayout.FillDirection = Enum.FillDirection.Horizontal
    HorizontalLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    HorizontalLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    HorizontalLayout.Padding = UDim.new(0, 20)
    HorizontalLayout.Parent = MainFrame
    
    -- Buat padding untuk margin kiri dan kanan
    local FramePadding = Instance.new("UIPadding")
    FramePadding.PaddingLeft = UDim.new(0, 20)
    FramePadding.PaddingRight = UDim.new(0, 20)
    FramePadding.Parent = MainFrame
    
    -- Reset dan buat ulang semua section
    if MainFrame:FindFirstChild("AvatarSection") then
        MainFrame:FindFirstChild("AvatarSection"):Destroy()
    end
    if MainFrame:FindFirstChild("NameSection") then 
        MainFrame:FindFirstChild("NameSection"):Destroy()
    end
    if MainFrame:FindFirstChild("ButtonHubSection") then
        MainFrame:FindFirstChild("ButtonHubSection"):Destroy()
    end
    if MainFrame:FindFirstChild("ButtonUniversalSection") then
        MainFrame:FindFirstChild("ButtonUniversalSection"):Destroy()
    end
    
    -- Buat ulang section Avatar dengan ukuran tetap
    AvatarSection = Instance.new("Frame")
    AvatarSection.Name = "AvatarSection"
    AvatarSection.BackgroundTransparency = 1
    AvatarSection.Size = UDim2.new(0, 130, 0, config.StartMenuHeight - 20)
    AvatarSection.Parent = MainFrame
    
    -- Avatar Image with orange border
    AvatarImage = Instance.new("ImageLabel")
    AvatarImage.BackgroundTransparency = 1
    AvatarImage.Position = UDim2.new(0.5, 0, 0, 8)
    AvatarImage.Size = UDim2.new(0, 60, 0, 60)
    AvatarImage.AnchorPoint = Vector2.new(0.5, 0)
    AvatarImage.Image = ""
    
    -- Add orange border to avatar
    local AvatarBorder = Instance.new("UIStroke")
    AvatarBorder.Color = config.AccentColor
    AvatarBorder.Thickness = 2
    AvatarBorder.Parent = AvatarImage
    
    AvatarImage.Parent = AvatarSection
    
    -- Add circular shape to avatar
    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.CornerRadius = UDim.new(1, 0) -- Perfectly round
    AvatarCorner.Parent = AvatarImage
    
    -- Avatar Label - perbaiki posisi dan ukuran
    AvatarLabel.Position = UDim2.new(0.5, 0, 0, 80)
    AvatarLabel.Size = UDim2.new(1, 0, 0, 20)
    AvatarLabel.TextSize = 16
    AvatarLabel.TextXAlignment = Enum.TextXAlignment.Center
    AvatarLabel.Parent = AvatarSection
    
    -- Buat ulang section Nama dengan ukuran tetap
    NameSection = Instance.new("Frame")
    NameSection.Name = "NameSection"
    NameSection.BackgroundTransparency = 1
    NameSection.Size = UDim2.new(0, 150, 0, config.StartMenuHeight - 20)
    NameSection.Parent = MainFrame
    
    -- Name Label - perbaiki tampilan
    NameLabel.Position = UDim2.new(0.5, 0, 0.5, -10)
    NameLabel.Size = UDim2.new(1, 0, 0, 20)
    NameLabel.TextSize = 18
    NameLabel.TextXAlignment = Enum.TextXAlignment.Center
    NameLabel.Parent = NameSection
    
    -- Buat ulang section Button Lomu Hub dengan ukuran tetap
    ButtonHubSection = Instance.new("Frame")
    ButtonHubSection.Name = "ButtonHubSection"
    ButtonHubSection.BackgroundTransparency = 1
    ButtonHubSection.Size = UDim2.new(0, 200, 0, config.StartMenuHeight - 20)
    ButtonHubSection.Parent = MainFrame
    
    -- Orange-themed Hub button
    ButtonHub = Instance.new("TextButton")
    ButtonHub.Name = "ButtonHub"
    ButtonHub.BackgroundColor3 = config.AccentColor
    ButtonHub.Position = UDim2.new(0.5, 0, 0.5, -15)
    ButtonHub.Size = UDim2.new(0, 160, 0, config.ButtonHeight)
    ButtonHub.AnchorPoint = Vector2.new(0.5, 0.5)
    ButtonHub.TextSize = 14
    ButtonHub.Font = config.ButtonFont
    ButtonHub.Text = "Load Lomu Hub"
    ButtonHub.TextColor3 = Color3.fromRGB(255, 255, 255)
    ButtonHub.AutoButtonColor = false
    ButtonHub.Parent = ButtonHubSection
    
    -- Add subtle glow to button
    local ButtonHubGlow = Instance.new("ImageLabel")
    ButtonHubGlow.Name = "Glow"
    ButtonHubGlow.BackgroundTransparency = 1
    ButtonHubGlow.Image = "rbxassetid://5028857084"
    ButtonHubGlow.ImageColor3 = Color3.fromRGB(255, 150, 50)
    ButtonHubGlow.ImageTransparency = 0.8
    ButtonHubGlow.Size = UDim2.new(1.2, 0, 1.5, 0)
    ButtonHubGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    ButtonHubGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    ButtonHubGlow.ZIndex = -1
    ButtonHubGlow.Parent = ButtonHub
    
    ButtonHubCorner = Instance.new("UICorner")
    ButtonHubCorner.CornerRadius = UDim.new(0, 6)
    ButtonHubCorner.Parent = ButtonHub
    
    -- Buat ulang section Button Universal Script dengan ukuran tetap
    ButtonUniversalSection = Instance.new("Frame")
    ButtonUniversalSection.Name = "ButtonUniversalSection"
    ButtonUniversalSection.BackgroundTransparency = 1
    ButtonUniversalSection.Size = UDim2.new(0, 200, 0, config.StartMenuHeight - 20)
    ButtonUniversalSection.Parent = MainFrame
    
    -- Orange-themed Universal Button
    ButtonUniversal = Instance.new("TextButton")
    ButtonUniversal.Name = "ButtonUniversal"
    ButtonUniversal.BackgroundColor3 = config.AccentColor
    ButtonUniversal.Position = UDim2.new(0.5, 0, 0.5, -15)
    ButtonUniversal.Size = UDim2.new(0, 160, 0, config.ButtonHeight)
    ButtonUniversal.AnchorPoint = Vector2.new(0.5, 0.5)
    ButtonUniversal.TextSize = 14
    ButtonUniversal.Font = config.ButtonFont
    ButtonUniversal.Text = "Load Universal Script"
    ButtonUniversal.TextColor3 = Color3.fromRGB(255, 255, 255)
    ButtonUniversal.AutoButtonColor = false
    ButtonUniversal.Parent = ButtonUniversalSection
    
    -- Add subtle glow to universal button
    local ButtonUniversalGlow = ButtonHubGlow:Clone()
    ButtonUniversalGlow.Parent = ButtonUniversal
    
    ButtonUniversalCorner = Instance.new("UICorner")
    ButtonUniversalCorner.CornerRadius = UDim.new(0, 6)
    ButtonUniversalCorner.Parent = ButtonUniversal
    
    -- Get player avatar
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local userId = player.UserId
    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size420x420
    local avatarUrl = ""
    
    -- Try to get avatar thumbnail
    pcall(function()
        avatarUrl = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
    end)
    
    -- Avatar Image
    AvatarImage.Image = avatarUrl
    
    -- Avatar Label
    AvatarLabel.Text = player.Name
    
    -- Button hover effects for Hub button with orange glow
    ButtonHub.MouseEnter:Connect(function()
        smoothTween(ButtonHub, config.AnimationSpeedFast, {
            BackgroundColor3 = Color3.fromRGB(
                math.clamp(config.AccentColor.R * 255 + 30, 0, 255)/255,
                math.clamp(config.AccentColor.G * 255 + 20, 0, 255)/255,
                math.clamp(config.AccentColor.B * 255 + 5, 0, 255)/255
            ),
            Size = UDim2.new(0, 164, 0, config.ButtonHeight + 2)
        }):Play()
        
        smoothTween(ButtonHubGlow, config.AnimationSpeedFast, {
            ImageTransparency = 0.6
        }):Play()
    end)
    
    ButtonHub.MouseLeave:Connect(function()
        smoothTween(ButtonHub, config.AnimationSpeedFast, {
            BackgroundColor3 = config.AccentColor,
            Size = UDim2.new(0, 160, 0, config.ButtonHeight)
        }):Play()
        
        smoothTween(ButtonHubGlow, config.AnimationSpeedFast, {
            ImageTransparency = 0.8
        }):Play()
    end)
    
    -- Button hover effects for Universal button with orange glow
    ButtonUniversal.MouseEnter:Connect(function()
        smoothTween(ButtonUniversal, config.AnimationSpeedFast, {
            BackgroundColor3 = Color3.fromRGB(
                math.clamp(config.AccentColor.R * 255 + 30, 0, 255)/255,
                math.clamp(config.AccentColor.G * 255 + 20, 0, 255)/255,
                math.clamp(config.AccentColor.B * 255 + 5, 0, 255)/255
            ),
            Size = UDim2.new(0, 164, 0, config.ButtonHeight + 2)
        }):Play()
        
        smoothTween(ButtonUniversalGlow, config.AnimationSpeedFast, {
            ImageTransparency = 0.6
        }):Play()
    end)
    
    ButtonUniversal.MouseLeave:Connect(function()
        smoothTween(ButtonUniversal, config.AnimationSpeedFast, {
            BackgroundColor3 = config.AccentColor,
            Size = UDim2.new(0, 160, 0, config.ButtonHeight)
        }):Play()
        
        smoothTween(ButtonUniversalGlow, config.AnimationSpeedFast, {
            ImageTransparency = 0.8
        }):Play()
    end)
    
    -- Button click functionality
    ButtonHub.MouseButton1Click:Connect(function()
        smoothTween(ButtonHub, 0.1, {
            BackgroundTransparency = 0.2,
            Size = UDim2.new(1, -12, 0, 28)
        }):Play()
        
        task.wait(0.1)
        
        local hideTween = smoothTween(MainFrame, config.AnimationSpeed, {
            Position = UDim2.new(0.5, 0, 1.1, 0),
            BackgroundTransparency = 0.2
        })
        
        hideTween:Play()
        
        hideTween.Completed:Connect(function()
            if hubCallback then
                hubCallback()
            end
        end)
    end)
    
    ButtonUniversal.MouseButton1Click:Connect(function()
        smoothTween(ButtonUniversal, 0.1, {
            BackgroundTransparency = 0.2,
            Size = UDim2.new(1, -12, 0, 28)
        }):Play()
        
        task.wait(0.1)
        
        local hideTween = smoothTween(MainFrame, config.AnimationSpeed, {
            Position = UDim2.new(0.5, 0, 1.1, 0),
            BackgroundTransparency = 0.2
        })
        
        hideTween:Play()
        
        hideTween.Completed:Connect(function()
            if universalCallback then
                universalCallback()
            end
        end)
    end)
    
    -- Animation for opening the UI with improved smoothness
    MainFrame.Parent = ScreenGui
    
    -- Coba dengan dua pendekatan berbeda untuk menampilkan UI
    -- Opsi 1: Menggunakan game.CoreGui
    pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    
    -- Opsi 2: Jika opsi 1 gagal, gunakan PlayerGui
    if not ScreenGui.Parent then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Tambahkan debug message untuk memeriksa apakah UI berhasil dibuat
    print("UI Menu created and parented to: " .. tostring(ScreenGui.Parent))
    
    -- Mulai dengan transparan 0
    MainFrame.BackgroundTransparency = 0
    
    -- Animasi UI - dimulai dari posisi awal, bukan dari luar layar
    smoothTween(MainFrame, config.AnimationSpeed, {
        Position = UDim2.new(0.5, 0, 0.9, 0), -- Slightly lower
        BackgroundTransparency = 0
    }):Play()
    
    -- Smoother hide and show functions
    function startMenu:Hide()
        local hideTween = smoothTween(MainFrame, config.AnimationSpeed, {
            Position = UDim2.new(0.5, 0, 1.1, 0),
            BackgroundTransparency = 0.2
        })
        
        hideTween:Play()
        
        hideTween.Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end
    
    function startMenu:Show()
        MainFrame.BackgroundTransparency = 0.2
        
        smoothTween(MainFrame, config.AnimationSpeed, {
            Position = UDim2.new(0.5, 0, 0.9, 0),
            BackgroundTransparency = 0
        }):Play()
    end
    
    return startMenu
end

-- Debug helper untuk memastikan script berjalan
local function DebugUI(msg)
    print("[LOMU HUB DEBUG] " .. msg)
    
    -- Tambahkan visual feedback agar terlihat saat debugging
    local debugLabel = Instance.new("TextLabel")
    debugLabel.Size = UDim2.new(0, 300, 0, 30)
    debugLabel.Position = UDim2.new(0.5, -150, 0.2, 0)
    debugLabel.AnchorPoint = Vector2.new(0, 0)
    debugLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    debugLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    debugLabel.TextSize = 14
    debugLabel.Text = msg
    debugLabel.ZIndex = 10001
    
    -- Pastikan debugLabel muncul
    local screenGui = Instance.new("ScreenGui")
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 10000
    screenGui.Parent = game:GetService("CoreGui")
    debugLabel.Parent = screenGui
    
    -- Hapus setelah beberapa detik
    task.delay(5, function()
        screenGui:Destroy()
    end)
end

-- Alternatif manual jika masih tidak muncul
local function CreateManualBar()
    DebugUI("Creating manual bar as fallback...")
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ManualLomuBar"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 10000
    
    -- Pastikan IgnoreGuiInset true agar tidak terpotong
    screenGui.IgnoreGuiInset = true
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 800, 0, 120)
    frame.Position = UDim2.new(0.5, 0, 1, -130)
    frame.AnchorPoint = Vector2.new(0.5, 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BorderSizePixel = 0
    frame.ZIndex = 10000
    frame.Parent = screenGui
    
    -- Add avatar button, name, and function buttons
    -- ... (kode untuk menambahkan elemen UI)
    
    -- Parent to CoreGui
    screenGui.Parent = game:GetService("CoreGui")
    return screenGui
end

return UILibrary
