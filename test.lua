local UILibrary = {}

-- Configuration
local config = {
    Title = "Lomu Hub",
    SubTitle = "Game Library",
    MainColor = Color3.fromRGB(20, 20, 22), -- Warna dasar lebih gelap & halus
    SecondaryColor = Color3.fromRGB(30, 30, 35), -- Item background lebih soft
    AccentColor = Color3.fromRGB(225, 125, 70), -- Orange lebih soft & elegan
    TextColor = Color3.fromRGB(240, 240, 240), -- Text putih dengan sedikit keabu-abuan
    SecondaryTextColor = Color3.fromRGB(170, 170, 175), -- Text sekunder lebih soft
    Font = Enum.Font.GothamSemibold,
    ButtonFont = Enum.Font.Gotham,
    CornerRadius = UDim.new(0, 5), -- Sudut lebih halus
    AnimationSpeed = 0.5,
    AnimationSpeedFast = 0.25,
    AnimationEasingStyle = Enum.EasingStyle.Quint,
    AnimationEasingDirection = Enum.EasingDirection.Out,
    ShadowTransparency = 0.7, -- Shadow lebih transparan
    MobileScaling = true,
    GameItemHeight = 75, -- Lebih compact
    MobileGameItemHeight = 65,
    DefaultThumbnail = "rbxassetid://6894586021",
    StartMenuHeight = 85, -- Lebih compact
    Padding = 10,
    ButtonHeight = 32,
    OrangeDark = Color3.fromRGB(25, 23, 25), -- Background game item lebih soft
    OrangeDarker = Color3.fromRGB(18, 18, 20), -- Background utama lebih soft
    IconSize = 18, -- Ukuran icon lebih kecil
    ItemSpacing = 8,
    BorderRadius = 4,
    SearchBarHeight = 28,
    AccentTransparency = 0.1, -- Transparansi untuk aksen
    GlowTransparency = 0.85 -- Glow lebih halus
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
    local SearchBar = Instance.new("Frame") -- Tambahkan search bar
    local SearchInput = Instance.new("TextBox")
    local SearchIcon = Instance.new("ImageLabel")
    local ContentContainer = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local GameList = Instance.new("ScrollingFrame")
    local GameListLayout = Instance.new("UIListLayout")
    local CategoryButtons = Instance.new("Frame") -- Tambah kategori
    
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
    MainFrame.BackgroundColor3 = config.OrangeDarker -- Dark background
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(-1, 0, 0.5, 0) -- Start off screen from left
    MainFrame.Size = UDim2.new(0, 450, 0, 360) -- Lebih compact
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.ClipsDescendants = true
    
    if isMobile and config.MobileScaling then
        MainFrame.Size = UDim2.new(0.85, 0, 0.65, 0)
    end
    
    -- Add shadow with orange tint
    Shadow.Name = "Shadow"
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://5028857084"
    Shadow.ImageColor3 = Color3.fromRGB(50, 25, 0)
    Shadow.ImageTransparency = config.ShadowTransparency
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.Size = UDim2.new(1, 40, 1, 40)
    Shadow.ZIndex = -1
    Shadow.Parent = MainFrame
    
    -- Add rounded corners
    UICorner.CornerRadius = config.CornerRadius
    UICorner.Parent = MainFrame
    
    -- Setup TopBar
    TopBar.Name = "TopBar"
    TopBar.BackgroundColor3 = config.MainColor -- Matching main color for consistency
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 36) -- Lebih compact
    TopBar.Parent = MainFrame
    
    local TopBarCorner = UICorner:Clone()
    TopBarCorner.CornerRadius = UDim.new(0, config.BorderRadius)
    TopBarCorner.Parent = TopBar
    
    -- Create a frame to fix corner overlap
    local TopBarFixCorner = Instance.new("Frame")
    TopBarFixCorner.Name = "FixCorner"
    TopBarFixCorner.BackgroundColor3 = TopBar.BackgroundColor3
    TopBarFixCorner.BorderSizePixel = 0
    TopBarFixCorner.Position = UDim2.new(0, 0, 1, -8)
    TopBarFixCorner.Size = UDim2.new(1, 0, 0, 8)
    TopBarFixCorner.Parent = TopBar
    
    -- Create title
    Title.Name = "Title"
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 12, 0, 2)
    Title.Size = UDim2.new(0, 180, 0, 18)
    Title.Font = config.Font
    Title.Text = config.Title
    Title.TextColor3 = config.TextColor
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar
    
    -- Create subtitle
    SubTitle.Name = "SubTitle"
    SubTitle.BackgroundTransparency = 1
    SubTitle.Position = UDim2.new(0, 12, 0, 20)
    SubTitle.Size = UDim2.new(0, 180, 0, 14)
    SubTitle.Font = config.Font
    SubTitle.Text = config.SubTitle
    SubTitle.TextColor3 = config.AccentColor
    SubTitle.TextSize = 12
    SubTitle.TextXAlignment = Enum.TextXAlignment.Left
    SubTitle.Parent = TopBar
    
    -- Create close button
    CloseButton.Name = "CloseButton"
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -28, 0, 8)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Image = "rbxassetid://3926305904"
    CloseButton.ImageRectOffset = Vector2.new(284, 4)
    CloseButton.ImageRectSize = Vector2.new(24, 24)
    CloseButton.ImageColor3 = config.TextColor
    CloseButton.Parent = TopBar
    
    -- Add animated hover effect to close button
    CloseButton.MouseEnter:Connect(function()
        smoothTween(CloseButton, config.AnimationSpeedFast, {
            ImageColor3 = config.AccentColor
        }):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        smoothTween(CloseButton, config.AnimationSpeedFast, {
            ImageColor3 = config.TextColor
        }):Play()
    end)
    
    -- Add Search Bar
    SearchBar.Name = "SearchBar"
    SearchBar.BackgroundColor3 = config.SecondaryColor
    SearchBar.Position = UDim2.new(0, 12, 0, 46)
    SearchBar.Size = UDim2.new(1, -24, 0, config.SearchBarHeight)
    SearchBar.Parent = MainFrame
    
    local SearchBarCorner = Instance.new("UICorner")
    SearchBarCorner.CornerRadius = UDim.new(0, config.BorderRadius)
    SearchBarCorner.Parent = SearchBar
    
    -- Search Icon
    SearchIcon.Name = "SearchIcon"
    SearchIcon.BackgroundTransparency = 1
    SearchIcon.Position = UDim2.new(0, 8, 0.5, 0)
    SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
    SearchIcon.Size = UDim2.new(0, 16, 0, 16)
    SearchIcon.Image = "rbxassetid://3926305904"
    SearchIcon.ImageRectOffset = Vector2.new(964, 324)
    SearchIcon.ImageRectSize = Vector2.new(36, 36)
    SearchIcon.ImageColor3 = config.SecondaryTextColor
    SearchIcon.Parent = SearchBar
    
    -- Search Input
    SearchInput.Name = "SearchInput"
    SearchInput.BackgroundTransparency = 1
    SearchInput.Position = UDim2.new(0, 32, 0, 0)
    SearchInput.Size = UDim2.new(1, -40, 1, 0)
    SearchInput.Font = config.ButtonFont
    SearchInput.PlaceholderText = "Search games..."
    SearchInput.Text = ""
    SearchInput.TextColor3 = config.TextColor
    SearchInput.PlaceholderColor3 = config.SecondaryTextColor
    SearchInput.TextSize = 14
    SearchInput.TextXAlignment = Enum.TextXAlignment.Left
    SearchInput.Parent = SearchBar
    
    -- Add Category Buttons
    CategoryButtons.Name = "CategoryButtons"
    CategoryButtons.BackgroundTransparency = 1
    CategoryButtons.Position = UDim2.new(0, 12, 0, 46 + config.SearchBarHeight + 8)
    CategoryButtons.Size = UDim2.new(1, -24, 0, 30)
    CategoryButtons.Parent = MainFrame
    
    -- Create category list layout
    local CategoryLayout = Instance.new("UIListLayout")
    CategoryLayout.FillDirection = Enum.FillDirection.Horizontal
    CategoryLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    CategoryLayout.SortOrder = Enum.SortOrder.LayoutOrder
    CategoryLayout.Padding = UDim.new(0, 8)
    CategoryLayout.Parent = CategoryButtons
    
    -- Create initial categories
    local categories = {"All", "Popular", "Recent"}
    local selectedCategory = "All"
    local categoryButtons = {}
    
    for i, catName in ipairs(categories) do
        local CategoryButton = Instance.new("TextButton")
        CategoryButton.Name = "Category_" .. catName
        CategoryButton.BackgroundColor3 = (catName == selectedCategory) and config.AccentColor or config.SecondaryColor
        CategoryButton.BackgroundTransparency = (catName == selectedCategory) and 0.1 or 0.8 -- Lebih transparan
        CategoryButton.Size = UDim2.new(0, 0, 1, 0)
        CategoryButton.AutomaticSize = Enum.AutomaticSize.X
        CategoryButton.Font = config.ButtonFont
        CategoryButton.Text = " " .. catName .. " "
        CategoryButton.TextColor3 = config.TextColor
        CategoryButton.TextSize = 13 -- Ukuran teks lebih kecil
        CategoryButton.Parent = CategoryButtons
        
        local CategoryButtonCorner = Instance.new("UICorner")
        CategoryButtonCorner.CornerRadius = UDim.new(0, config.BorderRadius)
        CategoryButtonCorner.Parent = CategoryButton
        
        CategoryButton.MouseEnter:Connect(function()
            if catName ~= selectedCategory then
                smoothTween(CategoryButton, config.AnimationSpeedFast, {
                    BackgroundTransparency = 0.5
                }):Play()
            end
        end)
        
        CategoryButton.MouseLeave:Connect(function()
            if catName ~= selectedCategory then
                smoothTween(CategoryButton, config.AnimationSpeedFast, {
                    BackgroundTransparency = 0.7
                }):Play()
            end
        end)
        
        CategoryButton.MouseButton1Click:Connect(function()
            if catName ~= selectedCategory then
                -- Update old selected button
                for _, btn in pairs(categoryButtons) do
                    if btn.Name == "Category_" .. selectedCategory then
                        smoothTween(btn, config.AnimationSpeedFast, {
                            BackgroundColor3 = config.SecondaryColor,
                            BackgroundTransparency = 0.7
                        }):Play()
                    end
                end
                
                -- Update new selected button
                smoothTween(CategoryButton, config.AnimationSpeedFast, {
                    BackgroundColor3 = config.AccentColor,
                    BackgroundTransparency = 0
                }):Play()
                
                selectedCategory = catName
                -- Filter games based on category
                for _, child in pairs(GameList:GetChildren()) do
                    if child:IsA("Frame") and child.Name:sub(1, 9) == "GameItem_" then
                        local gameCategory = child:GetAttribute("Category") or "All"
                        child.Visible = (selectedCategory == "All" or gameCategory == selectedCategory)
                        
                        -- Also apply search filter if exists
                        local searchText = string.lower(SearchInput.Text)
                        if searchText ~= "" then
                            local gameName = child.Name:sub(10)
                            child.Visible = child.Visible and string.find(string.lower(gameName), searchText)
                        end
                    end
                end
            end
        end)
        
        table.insert(categoryButtons, CategoryButton)
    end
    
    -- Content Container
    ContentContainer.Name = "ContentContainer"
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Position = UDim2.new(0, 12, 0, 46 + config.SearchBarHeight + 8 + 36)
    ContentContainer.Size = UDim2.new(1, -24, 1, -(46 + config.SearchBarHeight + 8 + 36 + 12))
    ContentContainer.Parent = MainFrame
    
    -- Game List
    GameList.Name = "GameList"
    GameList.BackgroundTransparency = 1
    GameList.BorderSizePixel = 0
    GameList.Size = UDim2.new(1, 0, 1, 0)
    GameList.CanvasSize = UDim2.new(0, 0, 0, 0)
    GameList.ScrollBarThickness = 3
    GameList.ScrollBarImageColor3 = config.AccentColor
    GameList.Parent = ContentContainer
    
    -- Game List Layout
    GameListLayout.Name = "GameListLayout"
    GameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    GameListLayout.Padding = UDim.new(0, config.ItemSpacing)
    GameListLayout.Parent = GameList
    
    -- Auto-adjust canvas size when game items are added
    GameListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        GameList.CanvasSize = UDim2.new(0, 0, 0, GameListLayout.AbsoluteContentSize.Y + 10)
    end)
    
    -- Add a description section at the beginning (more compact)
    local function createDescription(text)
        local Description = Instance.new("TextLabel")
        local DescriptionPadding = Instance.new("UIPadding")
        
        Description.Name = "Description"
        Description.BackgroundTransparency = 1
        Description.Size = UDim2.new(1, 0, 0, 50) -- Lebih compact
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
        local gameCategory = game.Category or "All" -- Tambah kategori
        
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
        GameItem.BackgroundColor3 = config.SecondaryColor -- Konsisten dengan search bar
        GameItem.Size = UDim2.new(1, 0, 0, gameItemHeight)
        GameItem.Parent = GameList
        GameItem.LayoutOrder = 10 -- Default sort order
        
        -- Add category attribute
        GameItem:SetAttribute("Category", gameCategory)
        
        GameItemCorner.CornerRadius = UDim.new(0, config.BorderRadius)
        GameItemCorner.Parent = GameItem
        
        -- Add shadow for game item
        local itemShadow = Instance.new("ImageLabel")
        itemShadow.Name = "Shadow"
        itemShadow.BackgroundTransparency = 1
        itemShadow.Image = "rbxassetid://5028857084"
        itemShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        itemShadow.ImageTransparency = 0.8
        itemShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
        itemShadow.AnchorPoint = Vector2.new(0.5, 0.5)
        itemShadow.Size = UDim2.new(1, 8, 1, 8)
        itemShadow.ZIndex = -1
        itemShadow.Parent = GameItem
        
        -- Thumbnail container
        ThumbnailFrame.Name = "ThumbnailFrame"
        ThumbnailFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
        ThumbnailFrame.Position = UDim2.new(0, 8, 0.5, 0)
        ThumbnailFrame.AnchorPoint = Vector2.new(0, 0.5)
        ThumbnailFrame.Size = UDim2.new(0, gameItemHeight - 16, 0, gameItemHeight - 16)
        ThumbnailFrame.Parent = GameItem
        
        ThumbnailCorner.CornerRadius = UDim.new(0, config.BorderRadius)
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
        GameInfo.Size = UDim2.new(1, -gameItemHeight - 50, 1, 0)
        GameInfo.Parent = GameItem
        
        -- Game name
        GameName.Name = "GameName"
        GameName.BackgroundTransparency = 1
        GameName.Position = UDim2.new(0, 8, 0, 8)
        GameName.Size = UDim2.new(1, -8, 0, 18)
        GameName.Font = config.Font
        GameName.Text = gameName
        GameName.TextColor3 = config.TextColor
        GameName.TextSize = 15
        GameName.TextXAlignment = Enum.TextXAlignment.Left
        GameName.Parent = GameInfo
        
        -- Last update info
        GameLastUpdate.Name = "GameLastUpdate"
        GameLastUpdate.BackgroundTransparency = 1
        GameLastUpdate.Position = UDim2.new(0, 8, 0, 30)
        GameLastUpdate.Size = UDim2.new(1, -8, 0, 14)
        GameLastUpdate.Font = config.ButtonFont
        GameLastUpdate.Text = "Last Update: " .. gameLastUpdate
        GameLastUpdate.TextColor3 = config.SecondaryTextColor
        GameLastUpdate.TextSize = 12
        GameLastUpdate.TextXAlignment = Enum.TextXAlignment.Left
        GameLastUpdate.Parent = GameInfo
        
        -- Game status with status badge
        GameStatus.Name = "GameStatus"
        GameStatus.BackgroundTransparency = 1
        GameStatus.Position = UDim2.new(0, 8, 0, 48)
        GameStatus.Size = UDim2.new(1, -8, 0, 14)
        GameStatus.Font = config.ButtonFont
        GameStatus.Text = "Status: " .. gameStatus
        GameStatus.TextColor3 = config.SecondaryTextColor
        GameStatus.TextSize = 12
        GameStatus.TextXAlignment = Enum.TextXAlignment.Left
        GameStatus.Parent = GameInfo
        
        -- Status indicator based on status text
        local statusColors = {
            ["Working"] = Color3.fromRGB(80, 180, 120), -- Warna hijau lebih soft
            ["Updated"] = Color3.fromRGB(90, 140, 210), -- Biru lebih soft
            ["Testing"] = Color3.fromRGB(220, 180, 80), -- Kuning lebih soft
            ["Patched"] = Color3.fromRGB(200, 90, 80)  -- Merah lebih soft
        }
        
        local StatusIndicator = Instance.new("Frame")
        StatusIndicator.Name = "StatusIndicator"
        StatusIndicator.BackgroundColor3 = statusColors[gameStatus] or Color3.fromRGB(150, 150, 150)
        StatusIndicator.Position = UDim2.new(0, -4, 0.5, 0)
        StatusIndicator.AnchorPoint = Vector2.new(0, 0.5)
        StatusIndicator.Size = UDim2.new(0, 3, 0, 12)
        StatusIndicator.Parent = GameStatus
        
        local StatusCorner = Instance.new("UICorner")
        StatusCorner.CornerRadius = UDim.new(0, 2)
        StatusCorner.Parent = StatusIndicator
        
        -- Adjust layouts for mobile
        if isMobile and config.MobileScaling then
            GameLastUpdate.Position = UDim2.new(0, 8, 0, 26)
            GameStatus.Position = UDim2.new(0, 8, 0, 42)
        end
        
        -- Play button with orange accent
        PlayButton.Name = "PlayButton"
        PlayButton.BackgroundColor3 = config.AccentColor
        PlayButton.BackgroundTransparency = config.AccentTransparency
        PlayButton.Position = UDim2.new(1, -40, 0.5, 0)
        PlayButton.AnchorPoint = Vector2.new(0, 0.5)
        PlayButton.Size = UDim2.new(0, 32, 0, 32)
        PlayButton.Image = "rbxassetid://3926307971"
        PlayButton.ImageRectOffset = Vector2.new(764, 244)
        PlayButton.ImageRectSize = Vector2.new(36, 36)
        PlayButton.ImageColor3 = config.TextColor
        PlayButton.ImageTransparency = 0.1
        PlayButton.Parent = GameItem
        
        PlayButtonCorner.CornerRadius = UDim.new(0, config.BorderRadius)
        PlayButtonCorner.Parent = PlayButton
        
        -- Add a subtle glow effect to the play button
        local PlayButtonGlow = Instance.new("ImageLabel")
        PlayButtonGlow.Name = "Glow"
        PlayButtonGlow.BackgroundTransparency = 1
        PlayButtonGlow.Image = "rbxassetid://5028857084"
        PlayButtonGlow.ImageColor3 = Color3.fromRGB(255, 150, 50)
        PlayButtonGlow.ImageTransparency = config.GlowTransparency
        PlayButtonGlow.Size = UDim2.new(1.3, 0, 1.3, 0)
        PlayButtonGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
        PlayButtonGlow.AnchorPoint = Vector2.new(0.5, 0.5)
        PlayButtonGlow.ZIndex = -1
        PlayButtonGlow.Parent = PlayButton
        
        -- Play button hover effects
        PlayButton.MouseEnter:Connect(function()
            smoothTween(PlayButton, config.AnimationSpeedFast, {
                Size = UDim2.new(0, 34, 0, 34),
                BackgroundTransparency = 0
            }):Play()
            
            smoothTween(PlayButtonGlow, config.AnimationSpeedFast, {
                ImageTransparency = 0.7
            }):Play()
        end)
        
        PlayButton.MouseLeave:Connect(function()
            smoothTween(PlayButton, config.AnimationSpeedFast, {
                Size = UDim2.new(0, 32, 0, 32),
                BackgroundTransparency = 0
            }):Play()
            
            smoothTween(PlayButtonGlow, config.AnimationSpeedFast, {
                ImageTransparency = 0.8
            }):Play()
        end)
        
        -- Game item hover effects
        local hoverEnter = function()
            smoothTween(GameItem, config.AnimationSpeedFast, {
                BackgroundColor3 = Color3.fromRGB(
                    math.clamp(config.SecondaryColor.R * 255 + 10, 0, 255)/255,
                    math.clamp(config.SecondaryColor.G * 255 + 10, 0, 255)/255,
                    math.clamp(config.SecondaryColor.B * 255 + 10, 0, 255)/255
                )
            }):Play()
        end
        
        local hoverLeave = function()
            smoothTween(GameItem, config.AnimationSpeedFast, {
                BackgroundColor3 = config.SecondaryColor
            }):Play()
        end
        
        GameItem.MouseEnter:Connect(hoverEnter)
        GameItem.MouseLeave:Connect(hoverLeave)
        
        -- Play button click functionality
        PlayButton.MouseButton1Click:Connect(function()
            -- Visual feedback
            smoothTween(PlayButton, 0.1, {
                Size = UDim2.new(0, 28, 0, 28)
            }):Play()
            
            task.wait(0.1)
            
            smoothTween(PlayButton, 0.1, {
                Size = UDim2.new(0, 32, 0, 32)
            }):Play()
            
            -- Callback
            gameCallback()
        end)
        
        -- Add search functionality
        SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
            local searchText = string.lower(SearchInput.Text)
            
            if searchText == "" then
                GameItem.Visible = (selectedCategory == "All" or gameCategory == selectedCategory)
            else
                GameItem.Visible = string.find(string.lower(gameName), searchText) and 
                                 (selectedCategory == "All" or gameCategory == selectedCategory)
            end
        end)
        
        return GameItem
    end
    
    -- Update the description
    function hub:SetDescription(text)
        descriptionLabel.Text = text
    end
    
    -- Add category function
    function hub:AddCategory(categoryName)
        if categoryName and not table.find(categories, categoryName) then
            table.insert(categories, categoryName)
            
            local CategoryButton = Instance.new("TextButton")
            CategoryButton.Name = "Category_" .. categoryName
            CategoryButton.BackgroundColor3 = config.SecondaryColor
            CategoryButton.Size = UDim2.new(0, 0, 1, 0)
            CategoryButton.AutomaticSize = Enum.AutomaticSize.X
            CategoryButton.Font = config.ButtonFont
            CategoryButton.Text = " " .. categoryName .. " "
            CategoryButton.TextColor3 = config.TextColor
            CategoryButton.TextSize = 14
            CategoryButton.BackgroundTransparency = 0.7
            CategoryButton.Parent = CategoryButtons
            
            local CategoryButtonCorner = Instance.new("UICorner")
            CategoryButtonCorner.CornerRadius = UDim.new(0, config.BorderRadius)
            CategoryButtonCorner.Parent = CategoryButton
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
    local MenuContainer = Instance.new("Frame")
    local HorizontalLayout = Instance.new("UIListLayout")
    local FramePadding = Instance.new("UIPadding")
    local AvatarSection = Instance.new("Frame")
    local AvatarImage = Instance.new("ImageLabel")
    local UsernameLabel = Instance.new("TextLabel")
    local ButtonSection = Instance.new("Frame")
    local ButtonHub = Instance.new("TextButton")
    local ButtonUniversal = Instance.new("TextButton")
    
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
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12) -- Pure black for minimalist look
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 1, -config.StartMenuHeight - 15) -- Slightly higher from bottom
    MainFrame.AnchorPoint = Vector2.new(0.5, 0) -- Anchor at center top
    MainFrame.Size = UDim2.new(0, 650, 0, config.StartMenuHeight) -- Smaller but proportional
    
    -- Ensure visibility
    MainFrame.BackgroundTransparency = 0
    MainFrame.ZIndex = 10000
    
    -- Mobile and small screen adjustments
    if isMobile then
        MainFrame.Size = UDim2.new(0.95, 0, 0, config.StartMenuHeight)
    elseif MainFrame.AbsoluteSize.X > 800 then
        MainFrame.Size = UDim2.new(0.6, 0, 0, config.StartMenuHeight)
    end
    
    -- Add rounded corners
    UICorner.CornerRadius = UDim.new(0, 8) -- Subtle rounded corners
    UICorner.Parent = MainFrame
    
    -- Add shadow
    Shadow.Name = "Shadow"
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://5028857084" -- Drop shadow image
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.Size = UDim2.new(1, 40, 1, 40)
    Shadow.ZIndex = -1
    Shadow.Parent = MainFrame
    
    -- Menu Container
    MenuContainer = Instance.new("Frame")
    MenuContainer.Name = "MenuContainer"
    MenuContainer.BackgroundTransparency = 1
    MenuContainer.Size = UDim2.new(1, 0, 1, 0)
    MenuContainer.Parent = MainFrame
    
    -- Create horizontal layout
    HorizontalLayout.FillDirection = Enum.FillDirection.Horizontal
    HorizontalLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    HorizontalLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    HorizontalLayout.Padding = UDim.new(0, 20)
    HorizontalLayout.SortOrder = Enum.SortOrder.LayoutOrder
    HorizontalLayout.Parent = MenuContainer
    
    -- Create padding
    FramePadding.PaddingLeft = UDim.new(0, 20)
    FramePadding.PaddingRight = UDim.new(0, 20)
    FramePadding.Parent = MenuContainer
    
    -- Avatar Section
    AvatarSection = Instance.new("Frame")
    AvatarSection.Name = "AvatarSection"
    AvatarSection.BackgroundTransparency = 1
    AvatarSection.Size = UDim2.new(0, 70, 0, config.StartMenuHeight - 20)
    AvatarSection.LayoutOrder = 1
    AvatarSection.Parent = MenuContainer
    
    -- Avatar Image with circular design
    AvatarImage = Instance.new("ImageLabel")
    AvatarImage.Name = "AvatarImage"
    AvatarImage.BackgroundTransparency = 1
    AvatarImage.Position = UDim2.new(0.5, 0, 0, 5)
    AvatarImage.Size = UDim2.new(0, 50, 0, 50)
    AvatarImage.AnchorPoint = Vector2.new(0.5, 0)
    AvatarImage.Image = ""
    AvatarImage.Parent = AvatarSection
    
    -- Add orange border to avatar
    local AvatarBorder = Instance.new("UIStroke")
    AvatarBorder.Name = "AvatarBorder"
    AvatarBorder.Color = config.AccentColor
    AvatarBorder.Thickness = 2
    AvatarBorder.Parent = AvatarImage
    
    -- Add circular shape to avatar
    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.CornerRadius = UDim.new(1, 0) -- Perfectly round
    AvatarCorner.Parent = AvatarImage
    
    -- Username Label
    UsernameLabel = Instance.new("TextLabel")
    UsernameLabel.Name = "UsernameLabel"
    UsernameLabel.BackgroundTransparency = 1
    UsernameLabel.Position = UDim2.new(0, 0, 0, 60)
    UsernameLabel.Size = UDim2.new(1, 0, 0, 20)
    UsernameLabel.Font = config.Font
    UsernameLabel.Text = "Username"
    UsernameLabel.TextColor3 = config.TextColor
    UsernameLabel.TextSize = 14
    UsernameLabel.Parent = AvatarSection
    
    -- Button Section
    ButtonSection = Instance.new("Frame")
    ButtonSection.Name = "ButtonSection"
    ButtonSection.BackgroundTransparency = 1
    ButtonSection.Size = UDim2.new(0, 400, 0, config.StartMenuHeight - 20)
    ButtonSection.LayoutOrder = 2
    ButtonSection.Parent = MenuContainer
    
    -- Button Layout
    local ButtonLayout = Instance.new("UIListLayout")
    ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
    ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ButtonLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    ButtonLayout.Padding = UDim.new(0, 20)
    ButtonLayout.Parent = ButtonSection
    
    -- Hub Button (Minimalist)
    ButtonHub = Instance.new("TextButton")
    ButtonHub.Name = "HubButton"
    ButtonHub.BackgroundColor3 = config.AccentColor
    ButtonHub.Position = UDim2.new(0, 0, 0.5, 0)
    ButtonHub.AnchorPoint = Vector2.new(0, 0.5)
    ButtonHub.Size = UDim2.new(0, 180, 0, 40)
    ButtonHub.Font = config.ButtonFont
    ButtonHub.Text = "Load Lomu Hub"
    ButtonHub.TextColor3 = config.TextColor
    ButtonHub.TextSize = 15
    ButtonHub.AutoButtonColor = false
    ButtonHub.Parent = ButtonSection
    
    -- Hub Button Corner
    local ButtonHubCorner = Instance.new("UICorner")
    ButtonHubCorner.CornerRadius = UDim.new(0, 6)
    ButtonHubCorner.Parent = ButtonHub
    
    -- Hub Button Glow
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
    
    -- Universal Button (Minimalist)
    ButtonUniversal = Instance.new("TextButton")
    ButtonUniversal.Name = "UniversalButton"
    ButtonUniversal.BackgroundColor3 = config.AccentColor
    ButtonUniversal.Position = UDim2.new(0, 200, 0.5, 0)
    ButtonUniversal.AnchorPoint = Vector2.new(0, 0.5)
    ButtonUniversal.Size = UDim2.new(0, 180, 0, 40)
    ButtonUniversal.Font = config.ButtonFont
    ButtonUniversal.Text = "Load Universal Script"
    ButtonUniversal.TextColor3 = config.TextColor
    ButtonUniversal.TextSize = 15
    ButtonUniversal.AutoButtonColor = false
    ButtonUniversal.Parent = ButtonSection
    
    -- Universal Button Corner
    local ButtonUniversalCorner = Instance.new("UICorner")
    ButtonUniversalCorner.CornerRadius = UDim.new(0, 6)
    ButtonUniversalCorner.Parent = ButtonUniversal
    
    -- Universal Button Glow
    local ButtonUniversalGlow = ButtonHubGlow:Clone()
    ButtonUniversalGlow.Parent = ButtonUniversal
    
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
    
    -- Set avatar image and username
    AvatarImage.Image = avatarUrl
    UsernameLabel.Text = player.Name
    
    -- Button hover effects for Hub button
    ButtonHub.MouseEnter:Connect(function()
        smoothTween(ButtonHub, config.AnimationSpeedFast, {
            BackgroundColor3 = Color3.fromRGB(
                math.clamp(config.AccentColor.R * 255 + 30, 0, 255)/255,
                math.clamp(config.AccentColor.G * 255 + 20, 0, 255)/255,
                math.clamp(config.AccentColor.B * 255 + 5, 0, 255)/255
            ),
            Size = UDim2.new(0, 185, 0, 42)
        }):Play()
        
        smoothTween(ButtonHubGlow, config.AnimationSpeedFast, {
            ImageTransparency = 0.6
        }):Play()
    end)
    
    ButtonHub.MouseLeave:Connect(function()
        smoothTween(ButtonHub, config.AnimationSpeedFast, {
            BackgroundColor3 = config.AccentColor,
            Size = UDim2.new(0, 180, 0, 40)
        }):Play()
        
        smoothTween(ButtonHubGlow, config.AnimationSpeedFast, {
            ImageTransparency = 0.8
        }):Play()
    end)
    
    -- Button hover effects for Universal button
    ButtonUniversal.MouseEnter:Connect(function()
        smoothTween(ButtonUniversal, config.AnimationSpeedFast, {
            BackgroundColor3 = Color3.fromRGB(
                math.clamp(config.AccentColor.R * 255 + 30, 0, 255)/255,
                math.clamp(config.AccentColor.G * 255 + 20, 0, 255)/255,
                math.clamp(config.AccentColor.B * 255 + 5, 0, 255)/255
            ),
            Size = UDim2.new(0, 185, 0, 42)
        }):Play()
        
        smoothTween(ButtonUniversalGlow, config.AnimationSpeedFast, {
            ImageTransparency = 0.6
        }):Play()
    end)
    
    ButtonUniversal.MouseLeave:Connect(function()
        smoothTween(ButtonUniversal, config.AnimationSpeedFast, {
            BackgroundColor3 = config.AccentColor,
            Size = UDim2.new(0, 180, 0, 40)
        }):Play()
        
        smoothTween(ButtonUniversalGlow, config.AnimationSpeedFast, {
            ImageTransparency = 0.8
        }):Play()
    end)
    
    -- Button click functionality with improved animations
    ButtonHub.MouseButton1Click:Connect(function()
        -- Shrink animation
        smoothTween(ButtonHub, 0.1, {
            Size = UDim2.new(0, 175, 0, 38),
            BackgroundTransparency = 0.2
        }):Play()
        
        task.wait(0.1)
        
        -- Hide menu animation
        local hideTween = smoothTween(MainFrame, config.AnimationSpeed, {
            Position = UDim2.new(0.5, 0, 1.1, 0),
            BackgroundTransparency = 0.2
        })
        
        hideTween:Play()
        
        -- Execute callback after animation completes
        hideTween.Completed:Connect(function()
            if hubCallback then
                hubCallback()
            end
        end)
    end)
    
    ButtonUniversal.MouseButton1Click:Connect(function()
        -- Shrink animation
        smoothTween(ButtonUniversal, 0.1, {
            Size = UDim2.new(0, 175, 0, 38),
            BackgroundTransparency = 0.2
        }):Play()
        
        task.wait(0.1)
        
        -- Hide menu animation
        local hideTween = smoothTween(MainFrame, config.AnimationSpeed, {
            Position = UDim2.new(0.5, 0, 1.1, 0),
            BackgroundTransparency = 0.2
        })
        
        hideTween:Play()
        
        -- Execute callback after animation completes
        hideTween.Completed:Connect(function()
            if universalCallback then
                universalCallback()
            end
        end)
    end)
    
    -- Animation for opening the UI
    MainFrame.Parent = ScreenGui
    
    -- Try to parent to CoreGui, fallback to PlayerGui
    pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    
    if not ScreenGui.Parent then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Start with the menu slightly below final position with some transparency
    MainFrame.Position = UDim2.new(0.5, 0, 1.05, 0)
    MainFrame.BackgroundTransparency = 0.2
    
    -- Smooth animation to show menu
    smoothTween(MainFrame, config.AnimationSpeed, {
        Position = UDim2.new(0.5, 0, 1, -config.StartMenuHeight - 15),
        BackgroundTransparency = 0
    }):Play()
    
    -- Hide menu function
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
    
    -- Show menu function
    function startMenu:Show()
        MainFrame.BackgroundTransparency = 0.2
        MainFrame.Position = UDim2.new(0.5, 0, 1.05, 0)
        
        smoothTween(MainFrame, config.AnimationSpeed, {
            Position = UDim2.new(0.5, 0, 1, -config.StartMenuHeight - 15),
            BackgroundTransparency = 0
        }):Play()
    end
    
    return startMenu
end

-- Tambahkan fungsi tambahan untuk meningkatkan UX/UI
function UILibrary.ShowNotification(message, duration)
    duration = duration or 3
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LomuNotification"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 10000
    
    local notifFrame = Instance.new("Frame")
    notifFrame.Name = "NotificationFrame"
    notifFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    notifFrame.BorderSizePixel = 0
    notifFrame.Position = UDim2.new(0.5, 0, 0, -50)
    notifFrame.AnchorPoint = Vector2.new(0.5, 0)
    notifFrame.Size = UDim2.new(0, 300, 0, 40)
    notifFrame.Parent = screenGui
    
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 6)
    notifCorner.Parent = notifFrame
    
    local notifBorder = Instance.new("UIStroke")
    notifBorder.Color = Color3.fromRGB(255, 120, 20)
    notifBorder.Thickness = 1
    notifBorder.Parent = notifFrame
    
    local icon = Instance.new("ImageLabel")
    icon.Name = "Icon"
    icon.BackgroundTransparency = 1
    icon.Position = UDim2.new(0, 10, 0.5, 0)
    icon.AnchorPoint = Vector2.new(0, 0.5)
    icon.Size = UDim2.new(0, 20, 0, 20)
    icon.Image = "rbxassetid://3926305904"
    icon.ImageRectOffset = Vector2.new(4, 844)
    icon.ImageRectSize = Vector2.new(36, 36)
    icon.ImageColor3 = Color3.fromRGB(255, 120, 20)
    icon.Parent = notifFrame
    
    local text = Instance.new("TextLabel")
    text.Name = "Message"
    text.BackgroundTransparency = 1
    text.Position = UDim2.new(0, 40, 0, 0)
    text.Size = UDim2.new(1, -50, 1, 0)
    text.Font = Enum.Font.GothamSemibold
    text.Text = message
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.TextSize = 14
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.TextWrapped = true
    text.Parent = notifFrame
    
    -- Try to use CoreGui
    pcall(function()
        screenGui.Parent = game:GetService("CoreGui")
    end)
    
    -- Fallback to PlayerGui
    if not screenGui.Parent then
        screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Animations
    notifFrame.BackgroundTransparency = 0.2
    
    local showTween = game:GetService("TweenService"):Create(
        notifFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.5, 0, 0, 20), BackgroundTransparency = 0}
    )
    
    showTween:Play()
    
    task.delay(duration, function()
        local hideTween = game:GetService("TweenService"):Create(
            notifFrame,
            TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {Position = UDim2.new(0.5, 0, 0, -50), BackgroundTransparency = 1}
        )
        
        hideTween:Play()
        
        hideTween.Completed:Connect(function()
            screenGui:Destroy()
        end)
    end)
end

return UILibrary
