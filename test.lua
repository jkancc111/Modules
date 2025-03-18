local UILibrary = {}

-- Configuration
local config = {
    Title = "Lomu Hub",
    SubTitle = "Game Library",
    MainColor = Color3.fromRGB(20, 20, 25), -- Dark background
    SecondaryColor = Color3.fromRGB(30, 30, 35), -- Slightly lighter for game items
    AccentColor = Color3.fromRGB(255, 120, 20), -- Dark Orange accent
    TextColor = Color3.fromRGB(255, 255, 255),
    SecondaryTextColor = Color3.fromRGB(200, 200, 200),
    Font = Enum.Font.GothamSemibold,
    ButtonFont = Enum.Font.Gotham,
    CornerRadius = UDim.new(0, 8), -- Rounded corners
    AnimationSpeed = 0.6,
    AnimationSpeedFast = 0.3,
    AnimationEasingStyle = Enum.EasingStyle.Quint,
    AnimationEasingDirection = Enum.EasingDirection.Out,
    ShadowTransparency = 0.5, -- Clearer shadow
    MobileScaling = true,
    GameItemHeight = 90, -- Slightly smaller
    MobileGameItemHeight = 75, -- Slightly smaller
    DefaultThumbnail = "rbxassetid://6894586021",
    StartMenuHeight = 110, -- Slightly smaller
    Padding = 12, -- Consistent padding
    ButtonHeight = 36, -- Consistent button height
    OrangeDark = Color3.fromRGB(40, 25, 15), -- Dark orange backdrop
    OrangeDarker = Color3.fromRGB(30, 20, 10) -- Darker orange for top bar
}

-- Fungsi helper untuk membuat animasi yang lebih smooth
local function smoothTween(object, duration, properties)
    return game:GetService("TweenService"):Create(
        object,
        TweenInfo.new(
            duration or config.AnimationSpeed,
            config.AnimationEasingStyle,
            config.AnimationEasingDirection
        ),
        properties
    )
end

-- Create a new hub instance
function UILibrary.new(customConfig)
    local hub = {}
    local userConfig = customConfig or {}
    
    -- Apply custom config if provided
    for key, value in pairs(userConfig) do
        config[key] = value
    end
    
    -- Main GUI elements
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Shadow = Instance.new("ImageLabel")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local SubTitle = Instance.new("TextLabel")
    local CloseButton = Instance.new("ImageButton")
    local ContentContainer = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local GameList = Instance.new("ScrollingFrame")
    local GameListLayout = Instance.new("UIListLayout")
    
    -- Set up ScreenGui
    ScreenGui.Name = "LomuHubLibrary"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Check if game is running on mobile
    local isMobile = (game:GetService("UserInputService").TouchEnabled and 
                      not game:GetService("UserInputService").KeyboardEnabled and
                      not game:GetService("UserInputService").MouseEnabled)
    
    -- Setup MainFrame
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = config.OrangeDarker -- Dark orange background
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(-1, 0, 0.5, 0) -- Start off screen from left
    MainFrame.Size = UDim2.new(0, 480, 0, 380) -- More compact size
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.ClipsDescendants = true
    
    if isMobile and config.MobileScaling then
        MainFrame.Size = UDim2.new(0.85, 0, 0.65, 0) -- Slightly smaller on mobile
    end
    
    -- Add shadow with orange tint
    Shadow.Name = "Shadow"
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://5028857084" -- Drop shadow image
    Shadow.ImageColor3 = Color3.fromRGB(50, 25, 0) -- Orange-tinted shadow
    Shadow.ImageTransparency = config.ShadowTransparency
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.Size = UDim2.new(1, 50, 1, 50) -- Larger shadow
    Shadow.ZIndex = -1
    Shadow.Parent = MainFrame
    
    -- Add rounded corners
    UICorner.CornerRadius = config.CornerRadius
    UICorner.Parent = MainFrame
    
    -- Setup TopBar
    TopBar.Name = "TopBar"
    TopBar.BackgroundColor3 = Color3.fromRGB(25, 15, 5) -- Darker orange for top bar
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.Parent = MainFrame
    
    local TopBarCorner = UICorner:Clone()
    TopBarCorner.CornerRadius = UDim.new(0, 6)
    TopBarCorner.Parent = TopBar
    
    -- Create a frame to fix corner overlap
    local TopBarFixCorner = Instance.new("Frame")
    TopBarFixCorner.Name = "FixCorner"
    TopBarFixCorner.BackgroundColor3 = TopBar.BackgroundColor3
    TopBarFixCorner.BorderSizePixel = 0
    TopBarFixCorner.Position = UDim2.new(0, 0, 1, -10)
    TopBarFixCorner.Size = UDim2.new(1, 0, 0, 10)
    TopBarFixCorner.Parent = TopBar
    
    -- Create title
    Title.Name = "Title"
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 2)
    Title.Size = UDim2.new(0, 200, 0, 20)
    Title.Font = config.Font
    Title.Text = config.Title
    Title.TextColor3 = config.TextColor
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar
    
    -- Create subtitle
    SubTitle.Name = "SubTitle"
    SubTitle.BackgroundTransparency = 1
    SubTitle.Position = UDim2.new(0, 10, 0, 22)
    SubTitle.Size = UDim2.new(0, 200, 0, 15)
    SubTitle.Font = config.Font
    SubTitle.Text = config.SubTitle
    SubTitle.TextColor3 = config.AccentColor
    SubTitle.TextSize = 14
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.Parent = TopBar
    
    -- Create close button
    CloseButton.Name = "CloseButton"
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -30, 0, 5)
    CloseButton.Size = UDim2.new(0, 25, 0, 25)
    CloseButton.Image = "rbxassetid://3926305904"
    CloseButton.ImageRectOffset = Vector2.new(284, 4)
    CloseButton.ImageRectSize = Vector2.new(24, 24)
    CloseButton.ImageColor3 = config.TextColor
    CloseButton.Parent = TopBar
    
    -- Content Container
    ContentContainer.Name = "ContentContainer"
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0, 10, 0, 50)
    ContentContainer.Size = UDim2.new(1, -20, 1, -60)
    ContentContainer.Parent = MainFrame
    
    -- Game List
    GameList.Name = "GameList"
    GameList.BackgroundTransparency = 1
    GameList.BorderSizePixel = 0
    GameList.Size = UDim2.new(1, 0, 1, 0)
    GameList.CanvasSize = UDim2.new(0, 0, 0, 0)
    GameList.ScrollBarThickness = 3 -- Thinner scrollbar
    GameList.ScrollBarImageColor3 = config.AccentColor -- Orange scrollbar
    GameList.Parent = ContentContainer
    
    -- Game List Layout
    GameListLayout.Name = "GameListLayout"
    GameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    GameListLayout.Padding = UDim.new(0, config.Padding) -- Consistent padding
    GameListLayout.Parent = GameList
    
    -- Auto-adjust canvas size when game items are added
    GameListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        GameList.CanvasSize = UDim2.new(0, 0, 0, GameListLayout.AbsoluteContentSize.Y + 20)
    end)
    
    -- Add a description section at the beginning
    local function createDescription(text)
        local Description = Instance.new("TextLabel")
        local DescriptionPadding = Instance.new("UIPadding")
        
        Description.Name = "Description"
        Description.BackgroundTransparency = 1
        Description.Size = UDim2.new(1, 0, 0, 70)
        Description.Font = config.Font
        Description.Text = text
        Description.TextColor3 = config.SecondaryTextColor
        Description.TextSize = 14
        Description.TextWrapped = true
        Description.TextXAlignment = Enum.TextXAlignment.Left
        Description.TextYAlignment = Enum.TextYAlignment.Top
        Description.Parent = GameList
        
        DescriptionPadding.PaddingLeft = UDim.new(0, 5)
        DescriptionPadding.PaddingRight = UDim.new(0, 5)
        DescriptionPadding.PaddingTop = UDim.new(0, 5)
        DescriptionPadding.Parent = Description
        
        return Description
    end
    
    local defaultDescription = "Welcome to " .. config.Title .. "! Browse through the game collection and click the play button to start playing."
    local descriptionLabel = createDescription(defaultDescription)
    
    -- Add a game to the list
    function hub:AddGame(gameData)
        local game = gameData or {}
        local gameName = game.Name or "Unnamed Game"
        local gameLastUpdate = game.LastUpdate or "Unknown"
        local gameStatus = game.Status or "Unknown"
        local gameThumbnail = game.Thumbnail or config.DefaultThumbnail
        local gameCallback = game.Callback or function() end
        
        -- Game item height based on device
        local gameItemHeight = config.GameItemHeight
        if isMobile and config.MobileScaling then
            gameItemHeight = config.MobileGameItemHeight
        end
        
        -- Create game item container
        local GameItem = Instance.new("Frame")
        local GameItemCorner = Instance.new("UICorner")
        local ThumbnailFrame = Instance.new("Frame")
        local ThumbnailCorner = Instance.new("UICorner")
        local Thumbnail = Instance.new("ImageLabel")
        local GameInfo = Instance.new("Frame")
        local GameName = Instance.new("TextLabel")
        local GameLastUpdate = Instance.new("TextLabel")
        local GameStatus = Instance.new("TextLabel")
        local PlayButton = Instance.new("ImageButton")
        local PlayButtonCorner = Instance.new("UICorner")
        
        -- Set up game item
        GameItem.Name = "GameItem_" .. gameName
        GameItem.BackgroundColor3 = config.OrangeDark -- Dark orange for game items
        GameItem.Size = UDim2.new(1, 0, 0, gameItemHeight)
        GameItem.Parent = GameList
        
        GameItemCorner.CornerRadius = UDim.new(0, 6)
        GameItemCorner.Parent = GameItem
        
        -- Add orange-tinted shadow for each game item
        local itemShadow = Shadow:Clone()
        itemShadow.Size = UDim2.new(1, 16, 1, 16)
        itemShadow.ZIndex = 0
        itemShadow.ImageTransparency = 0.8
        itemShadow.Parent = GameItem
        
        -- Thumbnail container
        ThumbnailFrame.Name = "ThumbnailFrame"
        ThumbnailFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        ThumbnailFrame.Position = UDim2.new(0, 10, 0.5, 0)
        ThumbnailFrame.AnchorPoint = Vector2.new(0, 0.5)
        ThumbnailFrame.Size = UDim2.new(0, gameItemHeight - 20, 0, gameItemHeight - 20)
        ThumbnailFrame.Parent = GameItem
        
        ThumbnailCorner.CornerRadius = UDim.new(0, 4)
        ThumbnailCorner.Parent = ThumbnailFrame
        
        -- Game thumbnail
        Thumbnail.Name = "Thumbnail"
        Thumbnail.BackgroundTransparency = 1
        Thumbnail.Size = UDim2.new(1, 0, 1, 0)
        Thumbnail.Image = gameThumbnail
        Thumbnail.ScaleType = Enum.ScaleType.Fit
        Thumbnail.Parent = ThumbnailFrame
        
        -- Game info container
        GameInfo.Name = "GameInfo"
        GameInfo.BackgroundTransparency = 1
        GameInfo.Position = UDim2.new(0, gameItemHeight, 0, 0)
        GameInfo.Size = UDim2.new(1, -gameItemHeight - 60, 1, 0)
        GameInfo.Parent = GameItem
        
        -- Game name
        GameName.Name = "GameName"
        GameName.BackgroundTransparency = 1
        GameName.Position = UDim2.new(0, 10, 0, 10)
        GameName.Size = UDim2.new(1, -10, 0, 20)
        GameName.Font = config.Font
        GameName.Text = gameName
        GameName.TextColor3 = config.TextColor
        GameName.TextSize = 16
        GameName.TextXAlignment = Enum.TextXAlignment.Left
        GameName.Parent = GameInfo
        
        -- Last update info
        GameLastUpdate.Name = "GameLastUpdate"
        GameLastUpdate.BackgroundTransparency = 1
        GameLastUpdate.Position = UDim2.new(0, 10, 0, 35)
        GameLastUpdate.Size = UDim2.new(1, -10, 0, 15)
        GameLastUpdate.Font = config.ButtonFont
        GameLastUpdate.Text = "Last Update: " .. gameLastUpdate
        GameLastUpdate.TextColor3 = config.SecondaryTextColor
        GameLastUpdate.TextSize = 14
        GameLastUpdate.TextXAlignment = Enum.TextXAlignment.Left
        GameLastUpdate.Parent = GameInfo
        
        -- Game status
        GameStatus.Name = "GameStatus"
        GameStatus.BackgroundTransparency = 1
        GameStatus.Position = UDim2.new(0, 10, 0, 55)
        GameStatus.Size = UDim2.new(1, -10, 0, 15)
        GameStatus.Font = config.ButtonFont
        GameStatus.Text = "Status: " .. gameStatus
        GameStatus.TextColor3 = config.SecondaryTextColor
        GameStatus.TextSize = 14
        GameStatus.TextXAlignment = Enum.TextXAlignment.Left
        GameStatus.Parent = GameInfo
        
        -- Adjust layouts for mobile
        if isMobile and config.MobileScaling then
            GameLastUpdate.Position = UDim2.new(0, 10, 0, 30)
            GameStatus.Position = UDim2.new(0, 10, 0, 45)
        end
        
        -- Play button with orange accent
        PlayButton.Name = "PlayButton"
        PlayButton.BackgroundColor3 = config.AccentColor -- Orange accent
        PlayButton.Position = UDim2.new(1, -45, 0.5, 0)
        PlayButton.AnchorPoint = Vector2.new(0, 0.5)
        PlayButton.Size = UDim2.new(0, 35, 0, 35) -- Slightly smaller
        PlayButton.Image = "rbxassetid://3926307971"
        PlayButton.ImageRectOffset = Vector2.new(764, 244)
        PlayButton.ImageRectSize = Vector2.new(36, 36)
        PlayButton.ImageColor3 = config.TextColor
        PlayButton.Parent = GameItem
        
        PlayButtonCorner.CornerRadius = UDim.new(0, 6)
        PlayButtonCorner.Parent = PlayButton
        
        -- Add a subtle glow effect to the play button
        local PlayButtonGlow = Instance.new("ImageLabel")
        PlayButtonGlow.Name = "Glow"
        PlayButtonGlow.BackgroundTransparency = 1
        PlayButtonGlow.Image = "rbxassetid://5028857084"
        PlayButtonGlow.ImageColor3 = Color3.fromRGB(255, 150, 50)
        PlayButtonGlow.ImageTransparency = 0.7
        PlayButtonGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
        PlayButtonGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
        PlayButtonGlow.AnchorPoint = Vector2.new(0.5, 0.5)
        PlayButtonGlow.ZIndex = -1
        PlayButtonGlow.Parent = PlayButton
        
        -- Play button hover effects with orange highlight
        local hoverEnter = function()
            smoothTween(GameItem, config.AnimationSpeedFast, {
                BackgroundColor3 = Color3.fromRGB(
                    math.clamp(config.OrangeDark.R * 255 + 15, 0, 255)/255,
                    math.clamp(config.OrangeDark.G * 255 + 10, 0, 255)/255,
                    math.clamp(config.OrangeDark.B * 255 + 5, 0, 255)/255
                )
            }):Play()
        end
        
        local hoverLeave = function()
            smoothTween(GameItem, config.AnimationSpeedFast, {
                BackgroundColor3 = config.OrangeDark
            }):Play()
        end
        
        GameItem.MouseEnter:Connect(hoverEnter)
        GameItem.MouseLeave:Connect(hoverLeave)
        Thumbnail.MouseEnter:Connect(hoverEnter)
        Thumbnail.MouseLeave:Connect(hoverLeave)
        
        -- Play button click functionality
        PlayButton.MouseButton1Click:Connect(function()
            gameCallback()
        end)
        
        return GameItem
    end
    
    -- Update the description
    function hub:SetDescription(text)
        descriptionLabel.Text = text
    end
    
    -- Clear all games from the list
    function hub:ClearGames()
        for _, child in pairs(GameList:GetChildren()) do
            if child:IsA("Frame") and child.Name:sub(1, 9) == "GameItem_" then
                child:Destroy()
            end
        end
    end
    
    -- Close button functionality
    CloseButton.MouseButton1Click:Connect(function()
        smoothTween(MainFrame, config.AnimationSpeed, {
            Position = UDim2.new(-1, 0, 0.5, 0),
            BackgroundTransparency = 0.1
        }):Play()
        
        task.wait(config.AnimationSpeed + 0.1)
        ScreenGui:Destroy()
    end)
    
    -- Make the TopBar draggable
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    TopBar.InputBegan:Connect(function(input)
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
    
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Animation for opening the UI (slide from left to right with improved smoothness)
    MainFrame.Parent = ScreenGui
    ScreenGui.Parent = game:GetService("CoreGui")
    
    MainFrame.BackgroundTransparency = 0.1
    
    local positionTween = smoothTween(MainFrame, config.AnimationSpeed, {
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundTransparency = 0
    })
    
    positionTween:Play()
    
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
