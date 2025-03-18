local UILibrary = {}

-- Configuration with GamerHub theme
local config = {
    -- Core colors - dark blue theme like in the screenshot
    MainColor = Color3.fromRGB(8, 12, 26),          -- Deep blue background (main area)
    SecondaryColor = Color3.fromRGB(16, 21, 39),    -- Sidebar background
    AccentColor = Color3.fromRGB(119, 86, 255),     -- Purple accent
    AccentColorLight = Color3.fromRGB(134, 106, 255),-- Lighter purple for hover
    
    -- Text colors
    TextColor = Color3.fromRGB(235, 235, 235),      -- White text
    SecondaryTextColor = Color3.fromRGB(165, 165, 170), -- Soft gray
    
    -- UI element styling
    Font = Enum.Font.GothamSemibold,
    ButtonFont = Enum.Font.Gotham,
    CornerRadius = UDim.new(0, 12),                -- More rounded corners
    ButtonCornerRadius = UDim.new(0, 10),          -- Button rounding
    SearchBarCornerRadius = UDim.new(0, 8),        -- Search bar rounding
    
    -- Animation and effects
    AnimationSpeed = 0.5,
    AnimationSpeedFast = 0.25,
    AnimationEasingStyle = Enum.EasingStyle.Quint,
    AnimationEasingDirection = Enum.EasingDirection.Out,
    ShadowTransparency = 0.8,                      -- Subtle shadows
    
    -- Layout and spacing
    GameItemHeight = 220,                          -- Taller game items for cards
    GameItemWidth = 170,                           -- Width for game cards
    SidebarWidth = 200,                            -- Sidebar width
    DefaultThumbnail = "rbxassetid://6894586021",
    Padding = 16,                                  -- Consistent padding
    ButtonHeight = 36,
    ItemSpacing = 16,                              -- Game card spacing
    CategorySpacing = 10,                          -- Space between categories
    
    -- Colors for specific elements
    CardBackground = Color3.fromRGB(20, 26, 46),   -- Game card background
    SidebarIconColor = Color3.fromRGB(120, 120, 125), -- Default sidebar icon color
    SidebarIconActiveColor = Color3.fromRGB(235, 235, 235), -- Active sidebar icon
    
    -- Element dimensions
    IconSize = 20,
    BorderRadius = 8,
    SearchBarHeight = 36,
    CategoryHeight = 40,
    
    -- Status colors
    StatusColors = {
        ["Working"] = Color3.fromRGB(86, 180, 116),   -- Green
        ["Updated"] = Color3.fromRGB(79, 140, 201),   -- Blue
        ["Testing"] = Color3.fromRGB(220, 170, 80),   -- Yellow
        ["Patched"] = Color3.fromRGB(192, 96, 86)     -- Red
    }
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
    local MainContainer = Instance.new("Frame")
    local Sidebar = Instance.new("Frame")
    local SidebarCorner = Instance.new("UICorner")
    local SidebarLayout = Instance.new("UIListLayout")
    local SidebarPadding = Instance.new("UIPadding")
    local Logo = Instance.new("ImageLabel")
    local ContentArea = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local SearchContainer = Instance.new("Frame")
    local SearchBar = Instance.new("Frame")
    local SearchInput = Instance.new("TextBox")
    local SearchIcon = Instance.new("ImageLabel")
    local UserInfo = Instance.new("Frame")
    local Currency = Instance.new("Frame")
    local CurrencyIcon = Instance.new("ImageLabel")
    local CurrencyText = Instance.new("TextLabel")
    local CurrencyAddButton = Instance.new("TextButton")
    local AvatarContainer = Instance.new("Frame")
    local AvatarImage = Instance.new("ImageLabel")
    local AvatarDropdownButton = Instance.new("ImageButton")
    local WalletDropdown = Instance.new("Frame")
    local MainContent = Instance.new("Frame")
    local WelcomeSection = Instance.new("Frame")
    local WelcomeTitle = Instance.new("TextLabel")
    local WelcomeDescription = Instance.new("TextLabel")
    local ExploreButton = Instance.new("TextButton")
    local GameSection = Instance.new("Frame")
    local GameSectionHeader = Instance.new("Frame")
    local GameSectionTitle = Instance.new("TextLabel")
    local ViewAllButton = Instance.new("TextButton")
    local GameGrid = Instance.new("Frame")
    local GameGridLayout = Instance.new("UIGridLayout")
    
    -- Set up ScreenGui
    ScreenGui.Name = "GamerHubLibrary"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main container
    MainContainer.Name = "MainContainer"
    MainContainer.BackgroundColor3 = config.MainColor
    MainContainer.BorderSizePixel = 0
    MainContainer.Size = UDim2.new(1, 0, 1, 0)
    MainContainer.Parent = ScreenGui
    
    -- Sidebar
    Sidebar.Name = "Sidebar"
    Sidebar.BackgroundColor3 = config.SecondaryColor
    Sidebar.BorderSizePixel = 0
    Sidebar.Size = UDim2.new(0, config.SidebarWidth, 1, 0)
    Sidebar.Parent = MainContainer
    
    SidebarCorner.CornerRadius = UDim.new(0, 0)
    SidebarCorner.Parent = Sidebar
    
    SidebarLayout.Name = "SidebarLayout"
    SidebarLayout.Padding = UDim.new(0, 8)
    SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SidebarLayout.Parent = Sidebar
    
    SidebarPadding.PaddingTop = UDim.new(0, 16)
    SidebarPadding.PaddingBottom = UDim.new(0, 16)
    SidebarPadding.Parent = Sidebar
    
    -- Logo (GamerHub)
    Logo.Name = "Logo"
    Logo.BackgroundTransparency = 1
    Logo.Size = UDim2.new(0, 160, 0, 50)
    Logo.Image = "rbxassetid://13799755218" -- Placeholder, replace with actual logo
    Logo.ScaleType = Enum.ScaleType.Fit
    Logo.LayoutOrder = 1
    Logo.Parent = Sidebar
    
    -- Create sidebar menu items
    local menuItems = {
        {name = "Home", icon = "rbxassetid://7733715400", active = true},
        {name = "Games", icon = "rbxassetid://7733774602"},
        {name = "Wallet", icon = "rbxassetid://7734053495"},
        {name = "GameFi", icon = "rbxassetid://7734110748"},
        {name = "NFTs", icon = "rbxassetid://7733945802"},
        {name = "Marketplace", icon = "rbxassetid://7733993211"},
        {name = "GamerStream", icon = "rbxassetid://7734180493"},
        {name = "GamerPlay", icon = "rbxassetid://7734212290"},
        {name = "GamerMerch", icon = "rbxassetid://7733896297"},
        {name = "Settings", icon = "rbxassetid://7734018729"}
    }
    
    local menuButtons = {}
    
    -- Function to create sidebar menu items
    local function createMenuItem(data)
        local MenuItem = Instance.new("TextButton")
        local MenuIcon = Instance.new("ImageLabel")
        local MenuText = Instance.new("TextLabel")
        local MenuItemPadding = Instance.new("UIPadding")
        
        MenuItem.Name = "MenuItem_" .. data.name
        MenuItem.BackgroundTransparency = 1
        MenuItem.Size = UDim2.new(1, -32, 0, 40)
        MenuItem.Text = ""
        MenuItem.LayoutOrder = #menuButtons + 2 -- Start after logo
        MenuItem.Parent = Sidebar
        
        MenuItemPadding.PaddingLeft = UDim.new(0, 16)
        MenuItemPadding.Parent = MenuItem
        
        MenuIcon.Name = "Icon"
        MenuIcon.BackgroundTransparency = 1
        MenuIcon.Size = UDim2.new(0, 20, 0, 20)
        MenuIcon.Position = UDim2.new(0, 0, 0.5, 0)
        MenuIcon.AnchorPoint = Vector2.new(0, 0.5)
        MenuIcon.Image = data.icon
        MenuIcon.ImageColor3 = data.active and config.SidebarIconActiveColor or config.SidebarIconColor
        MenuIcon.Parent = MenuItem
        
        MenuText.Name = "Text"
        MenuText.BackgroundTransparency = 1
        MenuText.Size = UDim2.new(1, -30, 1, 0)
        MenuText.Position = UDim2.new(0, 30, 0, 0)
        MenuText.Font = config.Font
        MenuText.Text = data.name
        MenuText.TextColor3 = data.active and config.SidebarIconActiveColor or config.SidebarIconColor
        MenuText.TextSize = 14
        MenuText.TextXAlignment = Enum.TextXAlignment.Left
        MenuText.Parent = MenuItem
        
        -- Hover effect
        MenuItem.MouseEnter:Connect(function()
            if not data.active then
                smoothTween(MenuIcon, config.AnimationSpeedFast, {
                    ImageColor3 = Color3.fromRGB(200, 200, 200)
                }):Play()
                
                smoothTween(MenuText, config.AnimationSpeedFast, {
                    TextColor3 = Color3.fromRGB(200, 200, 200)
                }):Play()
            end
        end)
        
        MenuItem.MouseLeave:Connect(function()
            if not data.active then
                smoothTween(MenuIcon, config.AnimationSpeedFast, {
                    ImageColor3 = config.SidebarIconColor
                }):Play()
                
                smoothTween(MenuText, config.AnimationSpeedFast, {
                    TextColor3 = config.SidebarIconColor
                }):Play()
            end
        end)
        
        -- Click effect
        MenuItem.MouseButton1Click:Connect(function()
            -- Deactivate all menu items
            for _, btn in ipairs(menuButtons) do
                local btnIcon = btn:FindFirstChild("Icon")
                local btnText = btn:FindFirstChild("Text")
                
                if btn ~= MenuItem then
                    btn.Data.active = false
                    
                    smoothTween(btnIcon, config.AnimationSpeedFast, {
                        ImageColor3 = config.SidebarIconColor
                    }):Play()
                    
                    smoothTween(btnText, config.AnimationSpeedFast, {
                        TextColor3 = config.SidebarIconColor
                    }):Play()
                end
            end
            
            -- Activate this menu item
            data.active = true
            
            smoothTween(MenuIcon, config.AnimationSpeedFast, {
                ImageColor3 = config.SidebarIconActiveColor
            }):Play()
            
            smoothTween(MenuText, config.AnimationSpeedFast, {
                TextColor3 = config.SidebarIconActiveColor
            }):Play()
        end)
        
        MenuItem.Data = data
        return MenuItem
    end
    
    -- Create all menu items
    for _, itemData in ipairs(menuItems) do
        local menuItem = createMenuItem(itemData)
        table.insert(menuButtons, menuItem)
    end
    
    -- Content area (main part)
    ContentArea.Name = "ContentArea"
    ContentArea.BackgroundColor3 = config.MainColor
    ContentArea.BorderSizePixel = 0
    ContentArea.Position = UDim2.new(0, config.SidebarWidth, 0, 0)
    ContentArea.Size = UDim2.new(1, -config.SidebarWidth, 1, 0)
    ContentArea.Parent = MainContainer
    
    -- Top bar with search and user info
    TopBar.Name = "TopBar"
    TopBar.BackgroundTransparency = 1
    TopBar.Size = UDim2.new(1, 0, 0, 60)
    TopBar.Parent = ContentArea
    
    -- Search container
    SearchContainer.Name = "SearchContainer"
    SearchContainer.BackgroundTransparency = 1
    SearchContainer.Position = UDim2.new(0, 20, 0, 0)
    SearchContainer.Size = UDim2.new(0, 280, 1, 0)
    SearchContainer.Parent = TopBar
    
    -- Search bar
    SearchBar.Name = "SearchBar"
    SearchBar.BackgroundColor3 = Color3.fromRGB(14, 18, 32)
    SearchBar.Position = UDim2.new(0, 0, 0.5, 0)
    SearchBar.AnchorPoint = Vector2.new(0, 0.5)
    SearchBar.Size = UDim2.new(1, 0, 0, 36)
    SearchBar.Parent = SearchContainer
    
    local SearchBarCorner = Instance.new("UICorner")
    SearchBarCorner.CornerRadius = UDim.new(0, 8)
    SearchBarCorner.Parent = SearchBar
    
    SearchIcon.Name = "SearchIcon"
    SearchIcon.BackgroundTransparency = 1
    SearchIcon.Position = UDim2.new(0, 12, 0.5, 0)
    SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
    SearchIcon.Size = UDim2.new(0, 16, 0, 16)
    SearchIcon.Image = "rbxassetid://3926305904"
    SearchIcon.ImageRectOffset = Vector2.new(964, 324)
    SearchIcon.ImageRectSize = Vector2.new(36, 36)
    SearchIcon.ImageColor3 = Color3.fromRGB(150, 150, 155)
    SearchIcon.Parent = SearchBar
    
    SearchInput.Name = "SearchInput"
    SearchInput.BackgroundTransparency = 1
    SearchInput.Position = UDim2.new(0, 36, 0, 0)
    SearchInput.Size = UDim2.new(1, -46, 1, 0)
    SearchInput.Font = Enum.Font.Gotham
    SearchInput.PlaceholderText = "Search"
    SearchInput.Text = ""
    SearchInput.TextColor3 = Color3.fromRGB(235, 235, 235)
    SearchInput.PlaceholderColor3 = Color3.fromRGB(130, 130, 135)
    SearchInput.TextSize = 14
    SearchInput.TextXAlignment = Enum.TextXAlignment.Left
    SearchInput.Parent = SearchBar
    
    -- User info area
    UserInfo.Name = "UserInfo"
    UserInfo.BackgroundTransparency = 1
    UserInfo.Position = UDim2.new(1, -20, 0, 0)
    UserInfo.AnchorPoint = Vector2.new(1, 0)
    UserInfo.Size = UDim2.new(0, 250, 1, 0)
    UserInfo.Parent = TopBar
    
    -- Currency display
    Currency.Name = "Currency"
    Currency.BackgroundTransparency = 1
    Currency.Position = UDim2.new(0, 0, 0.5, 0)
    Currency.AnchorPoint = Vector2.new(0, 0.5)
    Currency.Size = UDim2.new(0, 120, 0, 36)
    Currency.Parent = UserInfo
    
    local CurrencyBackground = Instance.new("Frame")
    CurrencyBackground.Name = "Background"
    CurrencyBackground.BackgroundColor3 = Color3.fromRGB(14, 18, 32)
    CurrencyBackground.Size = UDim2.new(1, 0, 1, 0)
    CurrencyBackground.Parent = Currency
    
    local CurrencyCorner = Instance.new("UICorner")
    CurrencyCorner.CornerRadius = UDim.new(0, 18)
    CurrencyCorner.Parent = CurrencyBackground
    
    CurrencyIcon.Name = "Icon"
    CurrencyIcon.BackgroundTransparency = 1
    CurrencyIcon.Position = UDim2.new(0, 10, 0.5, 0)
    CurrencyIcon.AnchorPoint = Vector2.new(0, 0.5)
    CurrencyIcon.Size = UDim2.new(0, 20, 0, 20)
    CurrencyIcon.Image = "rbxassetid://7734277555" -- Coin icon
    CurrencyIcon.ImageColor3 = Color3.fromRGB(255, 215, 0) -- Gold color
    CurrencyIcon.Parent = Currency
    
    CurrencyText.Name = "Text"
    CurrencyText.BackgroundTransparency = 1
    CurrencyText.Position = UDim2.new(0, 36, 0.5, 0)
    CurrencyText.AnchorPoint = Vector2.new(0, 0.5)
    CurrencyText.Size = UDim2.new(0, 50, 1, 0)
    CurrencyText.Font = Enum.Font.GothamBold
    CurrencyText.Text = "50K"
    CurrencyText.TextColor3 = Color3.fromRGB(255, 255, 255)
    CurrencyText.TextSize = 14
    CurrencyText.TextXAlignment = Enum.TextXAlignment.Left
    CurrencyText.Parent = Currency
    
    CurrencyAddButton.Name = "AddButton"
    CurrencyAddButton.BackgroundTransparency = 1
    CurrencyAddButton.Position = UDim2.new(1, -10, 0.5, 0)
    CurrencyAddButton.AnchorPoint = Vector2.new(1, 0.5)
    CurrencyAddButton.Size = UDim2.new(0, 24, 0, 24)
    CurrencyAddButton.Text = "+"
    CurrencyAddButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CurrencyAddButton.TextSize = 18
    CurrencyAddButton.Font = Enum.Font.GothamBold
    CurrencyAddButton.Parent = Currency
    
    -- Avatar and dropdown
    AvatarContainer.Name = "AvatarContainer"
    AvatarContainer.BackgroundTransparency = 1
    AvatarContainer.Position = UDim2.new(1, 0, 0.5, 0)
    AvatarContainer.AnchorPoint = Vector2.new(1, 0.5)
    AvatarContainer.Size = UDim2.new(0, 110, 0, 40)
    AvatarContainer.Parent = UserInfo
    
    AvatarImage.Name = "Avatar"
    AvatarImage.BackgroundColor3 = Color3.fromRGB(30, 34, 48)
    AvatarImage.Position = UDim2.new(1, -40, 0.5, 0)
    AvatarImage.AnchorPoint = Vector2.new(1, 0.5)
    AvatarImage.Size = UDim2.new(0, 36, 0, 36)
    AvatarImage.Image = "" -- Will be set to player avatar
    AvatarImage.Parent = AvatarContainer
    
    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.CornerRadius = UDim.new(1, 0) -- Circle
    AvatarCorner.Parent = AvatarImage
    
    AvatarDropdownButton.Name = "DropdownButton"
    AvatarDropdownButton.BackgroundTransparency = 1
    AvatarDropdownButton.Position = UDim2.new(1, -5, 0.5, 0)
    AvatarDropdownButton.AnchorPoint = Vector2.new(1, 0.5)
    AvatarDropdownButton.Size = UDim2.new(0, 24, 0, 24)
    AvatarDropdownButton.Image = "rbxassetid://7734110034" -- Dropdown arrow
    AvatarDropdownButton.ImageColor3 = Color3.fromRGB(200, 200, 200)
    AvatarDropdownButton.Parent = AvatarContainer
    
    -- Wallet dropdown (initially hidden)
    WalletDropdown = Instance.new("Frame")
    WalletDropdown.Name = "WalletDropdown"
    WalletDropdown.BackgroundColor3 = Color3.fromRGB(20, 24, 38)
    WalletDropdown.Position = UDim2.new(1, -5, 1, 5)
    WalletDropdown.AnchorPoint = Vector2.new(1, 0)
    WalletDropdown.Size = UDim2.new(0, 180, 0, 100)
    WalletDropdown.Visible = false
    WalletDropdown.Parent = AvatarContainer
    
    local WalletDropdownCorner = Instance.new("UICorner")
    WalletDropdownCorner.CornerRadius = UDim.new(0, 8)
    WalletDropdownCorner.Parent = WalletDropdown
    
    local WalletOptions = Instance.new("Frame")
    WalletOptions.Name = "Options"
    WalletOptions.BackgroundTransparency = 1
    WalletOptions.Size = UDim2.new(1, 0, 1, 0)
    WalletOptions.Parent = WalletDropdown
    
    local WalletOptionsLayout = Instance.new("UIListLayout")
    WalletOptionsLayout.Padding = UDim.new(0, 2)
    WalletOptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    WalletOptionsLayout.Parent = WalletOptions
    
    local WalletOptionsPadding = Instance.new("UIPadding")
    WalletOptionsPadding.PaddingTop = UDim.new(0, 10)
    WalletOptionsPadding.PaddingBottom = UDim.new(0, 10)
    WalletOptionsPadding.PaddingLeft = UDim.new(0, 10)
    WalletOptionsPadding.PaddingRight = UDim.new(0, 10)
    WalletOptionsPadding.Parent = WalletOptions
    
    -- Wallet dropdown options
    local function createWalletOption(text)
        local Option = Instance.new("TextButton")
        Option.Name = "Option_" .. text
        Option.BackgroundTransparency = 1
        Option.Size = UDim2.new(1, 0, 0, 36)
        Option.Font = Enum.Font.Gotham
        Option.Text = text
        Option.TextColor3 = Color3.fromRGB(220, 220, 220)
        Option.TextSize = 14
        Option.TextXAlignment = Enum.TextXAlignment.Left
        Option.Parent = WalletOptions
        
        Option.MouseEnter:Connect(function()
            Option.TextColor3 = config.AccentColor
        end)
        
        Option.MouseLeave:Connect(function()
            Option.TextColor3 = Color3.fromRGB(220, 220, 220)
        end)
        
        return Option
    end
    
    local exploreWalletOption = createWalletOption("Explore wallet")
    local disconnectWalletOption = createWalletOption("Disconnect wallet")
    
    -- Toggle wallet dropdown
    AvatarDropdownButton.MouseButton1Click:Connect(function()
        WalletDropdown.Visible = not WalletDropdown.Visible
    end)
    
    -- Main content area
    MainContent.Name = "MainContent"
    MainContent.BackgroundTransparency = 1
    MainContent.Position = UDim2.new(0, 0, 0, 60)
    MainContent.Size = UDim2.new(1, 0, 1, -60)
    MainContent.Parent = ContentArea
    
    -- Create a scrolling frame for main content
    local MainScroll = Instance.new("ScrollingFrame")
    MainScroll.Name = "MainScroll"
    MainScroll.BackgroundTransparency = 1
    MainScroll.Size = UDim2.new(1, 0, 1, 0)
    MainScroll.CanvasSize = UDim2.new(0, 0, 0, 1000) -- Will be adjusted
    MainScroll.ScrollBarThickness = 0
    MainScroll.ScrollingDirection = Enum.ScrollingDirection.Y
    MainScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    MainScroll.Parent = MainContent
    
    local MainScrollPadding = Instance.new("UIPadding")
    MainScrollPadding.PaddingLeft = UDim.new(0, 20)
    MainScrollPadding.PaddingRight = UDim.new(0, 20)
    MainScrollPadding.PaddingTop = UDim.new(0, 20)
    MainScrollPadding.PaddingBottom = UDim.new(0, 20)
    MainScrollPadding.Parent = MainScroll
    
    -- Welcome section with game promo
    WelcomeSection.Name = "WelcomeSection"
    WelcomeSection.BackgroundColor3 = Color3.fromRGB(22, 29, 52)
    WelcomeSection.Size = UDim2.new(1, 0, 0, 180)
    WelcomeSection.Parent = MainScroll
    
    local WelcomeSectionCorner = Instance.new("UICorner")
    WelcomeSectionCorner.CornerRadius = UDim.new(0, 12)
    WelcomeSectionCorner.Parent = WelcomeSection
    
    -- Add game promo image
    local WelcomeImage = Instance.new("ImageLabel")
    WelcomeImage.Name = "PromoImage"
    WelcomeImage.BackgroundTransparency = 1
    WelcomeImage.Position = UDim2.new(1, -320, 0, 0)
    WelcomeImage.Size = UDim2.new(0, 320, 1, 0)
    WelcomeImage.Image = "rbxassetid://13799862548" -- Placeholder game image
    WelcomeImage.Parent = WelcomeSection
    
    WelcomeTitle.Name = "Title"
    WelcomeTitle.BackgroundTransparency = 1
    WelcomeTitle.Position = UDim2.new(0, 24, 0, 40)
    WelcomeTitle.Size = UDim2.new(0, 300, 0, 30)
    WelcomeTitle.Font = Enum.Font.GothamBold
    WelcomeTitle.Text = "Welcome to GamerHub"
    WelcomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    WelcomeTitle.TextSize = 20
    WelcomeTitle.TextXAlignment = Enum.TextXAlignment.Left
    WelcomeTitle.Parent = WelcomeSection
    
    WelcomeDescription.Name = "Description"
    WelcomeDescription.BackgroundTransparency = 1
    WelcomeDescription.Position = UDim2.new(0, 24, 0, 80)
    WelcomeDescription.Size = UDim2.new(0, 300, 0, 40)
    WelcomeDescription.Font = Enum.Font.Gotham
    WelcomeDescription.Text = "Experience the future of gaming across multiple chains, all in one place."
    WelcomeDescription.TextColor3 = Color3.fromRGB(200, 200, 200)
    WelcomeDescription.TextSize = 14
    WelcomeDescription.TextWrapped = true
    WelcomeDescription.TextXAlignment = Enum.TextXAlignment.Left
    WelcomeDescription.Parent = WelcomeSection
    
    ExploreButton.Name = "ExploreButton"
    ExploreButton.BackgroundColor3 = config.AccentColor
    ExploreButton.Position = UDim2.new(0, 24, 0, 130)
    ExploreButton.Size = UDim2.new(0, 120, 0, 36)
    ExploreButton.Font = Enum.Font.GothamSemibold
    ExploreButton.Text = "Explore games"
    ExploreButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExploreButton.TextSize = 14
    ExploreButton.Parent = WelcomeSection
    
    local ExploreButtonCorner = Instance.new("UICorner")
    ExploreButtonCorner.CornerRadius = UDim.new(0, 8)
    ExploreButtonCorner.Parent = ExploreButton
    
    -- Game section
    GameSection.Name = "GameSection"
    GameSection.BackgroundTransparency = 1
    GameSection.Position = UDim2.new(0, 0, 0, 200)
    GameSection.Size = UDim2.new(1, 0, 0, 400)
    GameSection.Parent = MainScroll
    
    -- Game section header
    GameSectionHeader.Name = "Header"
    GameSectionHeader.BackgroundTransparency = 1
    GameSectionHeader.Size = UDim2.new(1, 0, 0, 40)
    GameSectionHeader.Parent = GameSection
    
    GameSectionTitle.Name = "Title"
    GameSectionTitle.BackgroundTransparency = 1
    GameSectionTitle.Size = UDim2.new(0, 150, 1, 0)
    GameSectionTitle.Font = Enum.Font.GothamBold
    GameSectionTitle.Text = "All games"
    GameSectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    GameSectionTitle.TextSize = 18
    GameSectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    GameSectionTitle.Parent = GameSectionHeader
    
    ViewAllButton.Name = "ViewAllButton"
    ViewAllButton.BackgroundTransparency = 1
    ViewAllButton.Position = UDim2.new(1, 0, 0, 0)
    ViewAllButton.AnchorPoint = Vector2.new(1, 0)
    ViewAllButton.Size = UDim2.new(0, 60, 1, 0)
    ViewAllButton.Font = Enum.Font.Gotham
    ViewAllButton.Text = "View all"
    ViewAllButton.TextColor3 = Color3.fromRGB(150, 150, 150)
    ViewAllButton.TextSize = 14
    ViewAllButton.Parent = GameSectionHeader
    
    -- Game grid for displaying game cards
    GameGrid.Name = "GameGrid"
    GameGrid.BackgroundTransparency = 1
    GameGrid.Position = UDim2.new(0, 0, 0, 50)
    GameGrid.Size = UDim2.new(1, 0, 0, 350)
    GameGrid.Parent = GameSection
    
    GameGridLayout.Name = "GridLayout"
    GameGridLayout.CellPadding = UDim2.new(0, 16, 0, 16)
    GameGridLayout.CellSize = UDim2.new(0, config.GameItemWidth, 0, config.GameItemHeight)
    GameGridLayout.FillDirection = Enum.FillDirection.Horizontal
    GameGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    GameGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    GameGridLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    GameGridLayout.Parent = GameGrid
    
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
    
    -- Set avatar image
    AvatarImage.Image = avatarUrl
    
    -- Add a game to the grid
    function hub:AddGame(gameData)
        local game = gameData or {}
        local gameName = game.Name or "Unnamed Game"
        local gameLastUpdate = game.LastUpdate or "Unknown"
        local gameStatus = game.Status or "Unknown"
        local gameThumbnail = game.Thumbnail or config.DefaultThumbnail
        local gameCallback = game.Callback or function() end
        local gameCategory = game.Category or "All"
        local gamePublisher = game.Publisher or "GamerHub"
        
        -- Create game card
        local GameCard = Instance.new("Frame")
        local GameCardCorner = Instance.new("UICorner")
        local GameThumbnail = Instance.new("ImageLabel")
        local GameThumbnailCorner = Instance.new("UICorner")
        local GameInfo = Instance.new("Frame")
        local GameTitle = Instance.new("TextLabel")
        local GamePublisher = Instance.new("TextLabel")
        local PlayButton = Instance.new("ImageButton")
        local PlayButtonCorner = Instance.new("UICorner")
        
        -- Set up game card
        GameCard.Name = "GameCard_" .. gameName
        GameCard.BackgroundColor3 = config.CardBackground
        GameCard.Size = UDim2.new(1, 0, 1, 0)
        GameCard.Parent = GameGrid
        GameCard:SetAttribute("Category", gameCategory)
        
        GameCardCorner.CornerRadius = UDim.new(0, 12)
        GameCardCorner.Parent = GameCard
        
        -- Game thumbnail
        GameThumbnail.Name = "Thumbnail"
        GameThumbnail.BackgroundColor3 = Color3.fromRGB(30, 35, 55)
        GameThumbnail.Position = UDim2.new(0, 0, 0, 0)
        GameThumbnail.Size = UDim2.new(1, 0, 0, 140)
        GameThumbnail.Image = gameThumbnail
        GameThumbnail.ScaleType = Enum.ScaleType.Crop
        GameThumbnail.Parent = GameCard
        
        GameThumbnailCorner.CornerRadius = UDim.new(0, 10)
        GameThumbnailCorner.Parent = GameThumbnail
        
        -- Publisher badge
        local PublisherBadge = Instance.new("Frame")
        PublisherBadge.Name = "PublisherBadge"
        PublisherBadge.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        PublisherBadge.BackgroundTransparency = 0.5
        PublisherBadge.Position = UDim2.new(0, 8, 0, 8)
        PublisherBadge.Size = UDim2.new(0, 80, 0, 24)
        PublisherBadge.Parent = GameThumbnail
        
        local PublisherBadgeCorner = Instance.new("UICorner")
        PublisherBadgeCorner.CornerRadius = UDim.new(0, 12)
        PublisherBadgeCorner.Parent = PublisherBadge
        
        local PublisherIcon = Instance.new("ImageLabel")
        PublisherIcon.Name = "Icon"
        PublisherIcon.BackgroundTransparency = 1
        PublisherIcon.Position = UDim2.new(0, 6, 0.5, 0)
        PublisherIcon.AnchorPoint = Vector2.new(0, 0.5)
        PublisherIcon.Size = UDim2.new(0, 16, 0, 16)
        PublisherIcon.Image = "rbxassetid://7734130503" -- Publisher icon
        PublisherIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
        PublisherIcon.Parent = PublisherBadge
        
        local PublisherText = Instance.new("TextLabel")
        PublisherText.Name = "Text"
        PublisherText.BackgroundTransparency = 1
        PublisherText.Position = UDim2.new(0, 28, 0, 0)
        PublisherText.Size = UDim2.new(1, -34, 1, 0)
        PublisherText.Font = Enum.Font.GothamBold
        PublisherText.Text = gamePublisher
        PublisherText.TextColor3 = Color3.fromRGB(255, 255, 255)
        PublisherText.TextSize = 10
        PublisherText.TextXAlignment = Enum.TextXAlignment.Left
        PublisherText.Parent = PublisherBadge
        
        -- Game info
        GameInfo.Name = "GameInfo"
        GameInfo.BackgroundTransparency = 1
        GameInfo.Position = UDim2.new(0, 0, 0, 140)
        GameInfo.Size = UDim2.new(1, 0, 1, -140)
        GameInfo.Parent = GameCard
        
        GameTitle.Name = "Title"
        GameTitle.BackgroundTransparency = 1
        GameTitle.Position = UDim2.new(0, 10, 0, 10)
        GameTitle.Size = UDim2.new(1, -20, 0, 20)
        GameTitle.Font = Enum.Font.GothamBold
        GameTitle.Text = gameName
        GameTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        GameTitle.TextSize = 14
        GameTitle.TextXAlignment = Enum.TextXAlignment.Left
        GameTitle.TextTruncate = Enum.TextTruncate.AtEnd
        GameTitle.Parent = GameInfo
        
        GamePublisher.Name = "UpdateInfo"
        GamePublisher.BackgroundTransparency = 1
        GamePublisher.Position = UDim2.new(0, 10, 0, 32)
        GamePublisher.Size = UDim2.new(1, -20, 0, 16)
        GamePublisher.Font = Enum.Font.Gotham
        GamePublisher.Text = "Last update: " .. gameLastUpdate
        GamePublisher.TextColor3 = Color3.fromRGB(150, 150, 150)
        GamePublisher.TextSize = 12
        GamePublisher.TextXAlignment = Enum.TextXAlignment.Left
        GamePublisher.Parent = GameInfo
        
        -- Status badge
        local StatusBadge = Instance.new("Frame")
        StatusBadge.Name = "StatusBadge"
        StatusBadge.BackgroundColor3 = config.StatusColors[gameStatus] or Color3.fromRGB(150, 150, 150)
        StatusBadge.Position = UDim2.new(0, 10, 0, 55)
        StatusBadge.Size = UDim2.new(0, 60, 0, 20)
        StatusBadge.Parent = GameInfo
        
        local StatusBadgeCorner = Instance.new("UICorner")
        StatusBadgeCorner.CornerRadius = UDim.new(0, 10)
        StatusBadgeCorner.Parent = StatusBadge
        
        local StatusText = Instance.new("TextLabel")
        StatusText.Name = "Text"
        StatusText.BackgroundTransparency = 1
        StatusText.Size = UDim2.new(1, 0, 1, 0)
        StatusText.Font = Enum.Font.GothamBold
        StatusText.Text = gameStatus
        StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
        StatusText.TextSize = 10
        StatusText.Parent = StatusBadge
        
        -- Play button
        PlayButton.Name = "PlayButton"
        PlayButton.BackgroundColor3 = config.AccentColor
        PlayButton.Position = UDim2.new(1, -10, 1, -10)
        PlayButton.AnchorPoint = Vector2.new(1, 1)
        PlayButton.Size = UDim2.new(0, 36, 0, 36)
        PlayButton.Image = "rbxassetid://3926307971"
        PlayButton.ImageRectOffset = Vector2.new(764, 244)
        PlayButton.ImageRectSize = Vector2.new(36, 36)
        PlayButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
        PlayButton.Parent = GameCard
        
        PlayButtonCorner.CornerRadius = UDim.new(1, 0) -- Circle
        PlayButtonCorner.Parent = PlayButton
        
        -- Hover effects for game card
        GameCard.MouseEnter:Connect(function()
            smoothTween(GameCard, config.AnimationSpeedFast, {
            BackgroundColor3 = Color3.fromRGB(
                    math.min(config.CardBackground.R * 255 + 10, 255)/255,
                    math.min(config.CardBackground.G * 255 + 10, 255)/255,
                    math.min(config.CardBackground.B * 255 + 10, 255)/255
                )
        }):Play()
        
            smoothTween(PlayButton, config.AnimationSpeedFast, {
                Size = UDim2.new(0, 40, 0, 40),
                BackgroundColor3 = config.AccentColorLight
        }):Play()
    end)
    
        GameCard.MouseLeave:Connect(function()
            smoothTween(GameCard, config.AnimationSpeedFast, {
                BackgroundColor3 = config.CardBackground
        }):Play()
        
            smoothTween(PlayButton, config.AnimationSpeedFast, {
                Size = UDim2.new(0, 36, 0, 36),
                BackgroundColor3 = config.AccentColor
        }):Play()
    end)
    
        -- Play button click handler
        PlayButton.MouseButton1Click:Connect(function()
            -- Visual feedback
            smoothTween(PlayButton, 0.1, {
                Size = UDim2.new(0, 32, 0, 32)
        }):Play()
        
        task.wait(0.1)
        
            smoothTween(PlayButton, 0.1, {
                Size = UDim2.new(0, 36, 0, 36)
        }):Play()
            
            -- Callback
            gameCallback()
        end)
        
        -- Search functionality
        SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
            local searchText = string.lower(SearchInput.Text)
            
            if searchText == "" then
                GameCard.Visible = true
            else
                GameCard.Visible = string.find(string.lower(gameName), searchText) ~= nil
            end
        end)
        
        return GameCard
    end
    
    -- Add category functionality
    function hub:AddCategory(categoryName)
        -- Check if category section already exists
        local existingCategory = GameSection:FindFirstChild("Category_" .. categoryName)
        if existingCategory then return existingCategory end
        
        -- Create new category section
        local CategorySection = Instance.new("Frame")
        CategorySection.Name = "Category_" .. categoryName
        CategorySection.BackgroundTransparency = 1
        CategorySection.Position = UDim2.new(0, 0, 0, 0) -- Will be positioned properly when added
        CategorySection.Size = UDim2.new(1, 0, 0, 400)
        CategorySection.Parent = MainScroll
        
        -- Category header
        local CategoryHeader = Instance.new("Frame")
        CategoryHeader.Name = "Header"
        CategoryHeader.BackgroundTransparency = 1
        CategoryHeader.Size = UDim2.new(1, 0, 0, 40)
        CategoryHeader.Parent = CategorySection
        
        local CategoryTitle = Instance.new("TextLabel")
        CategoryTitle.Name = "Title"
        CategoryTitle.BackgroundTransparency = 1
        CategoryTitle.Size = UDim2.new(0, 150, 1, 0)
        CategoryTitle.Font = Enum.Font.GothamBold
        CategoryTitle.Text = categoryName
        CategoryTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        CategoryTitle.TextSize = 18
        CategoryTitle.TextXAlignment = Enum.TextXAlignment.Left
        CategoryTitle.Parent = CategoryHeader
        
        local CategoryViewAll = Instance.new("TextButton")
        CategoryViewAll.Name = "ViewAllButton"
        CategoryViewAll.BackgroundTransparency = 1
        CategoryViewAll.Position = UDim2.new(1, 0, 0, 0)
        CategoryViewAll.AnchorPoint = Vector2.new(1, 0)
        CategoryViewAll.Size = UDim2.new(0, 60, 1, 0)
        CategoryViewAll.Font = Enum.Font.Gotham
        CategoryViewAll.Text = "View all"
        CategoryViewAll.TextColor3 = Color3.fromRGB(150, 150, 150)
        CategoryViewAll.TextSize = 14
        CategoryViewAll.Parent = CategoryHeader
        
        -- Category game grid
        local CategoryGrid = Instance.new("Frame")
        CategoryGrid.Name = "GameGrid"
        CategoryGrid.BackgroundTransparency = 1
        CategoryGrid.Position = UDim2.new(0, 0, 0, 50)
        CategoryGrid.Size = UDim2.new(1, 0, 0, 350)
        CategoryGrid.Parent = CategorySection
        
        local CategoryGridLayout = Instance.new("UIGridLayout")
        CategoryGridLayout.Name = "GridLayout"
        CategoryGridLayout.CellPadding = UDim2.new(0, 16, 0, 16)
        CategoryGridLayout.CellSize = UDim2.new(0, config.GameItemWidth, 0, config.GameItemHeight)
        CategoryGridLayout.FillDirection = Enum.FillDirection.Horizontal
        CategoryGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
        CategoryGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
        CategoryGridLayout.VerticalAlignment = Enum.VerticalAlignment.Top
        CategoryGridLayout.Parent = CategoryGrid
        
        return CategorySection
    end
    
    -- Add game to specific category
    function hub:AddGameToCategory(gameData, categoryName)
        local categorySection = hub:AddCategory(categoryName)
        local categoryGrid = categorySection:FindFirstChild("GameGrid")
        
        if categoryGrid then
            local gameCard = hub:AddGame(gameData)
            gameCard.Parent = categoryGrid
            return gameCard
        end
        
        return nil
    end
    
    -- Set welcome section text
    function hub:SetWelcomeText(title, description)
        WelcomeTitle.Text = title or "Welcome to GamerHub"
        WelcomeDescription.Text = description or "Experience the future of gaming across multiple chains, all in one place."
    end
    
    -- Set welcome section image
    function hub:SetWelcomeImage(imageId)
        if imageId then
            WelcomeImage.Image = imageId
        end
    end
    
    -- Show notification
    function hub:ShowNotification(message, duration)
        duration = duration or 3
        
        local NotificationContainer = ScreenGui:FindFirstChild("NotificationContainer")
        if not NotificationContainer then
            NotificationContainer = Instance.new("Frame")
            NotificationContainer.Name = "NotificationContainer"
            NotificationContainer.BackgroundTransparency = 1
            NotificationContainer.Position = UDim2.new(1, -20, 0, 20)
            NotificationContainer.AnchorPoint = Vector2.new(1, 0)
            NotificationContainer.Size = UDim2.new(0, 280, 1, -40)
            NotificationContainer.Parent = ScreenGui
            
            local NotificationLayout = Instance.new("UIListLayout")
            NotificationLayout.Padding = UDim.new(0, 10)
            NotificationLayout.SortOrder = Enum.SortOrder.LayoutOrder
            NotificationLayout.VerticalAlignment = Enum.VerticalAlignment.Top
            NotificationLayout.Parent = NotificationContainer
        end
        
        -- Create notification
        local Notification = Instance.new("Frame")
        Notification.Name = "Notification"
        Notification.BackgroundColor3 = Color3.fromRGB(30, 34, 48)
        Notification.BorderSizePixel = 0
        Notification.Size = UDim2.new(1, 0, 0, 0)
        Notification.AutomaticSize = Enum.AutomaticSize.Y
        Notification.Parent = NotificationContainer
        
        local NotificationCorner = Instance.new("UICorner")
        NotificationCorner.CornerRadius = UDim.new(0, 8)
        NotificationCorner.Parent = Notification
        
        local NotificationPadding = Instance.new("UIPadding")
        NotificationPadding.PaddingTop = UDim.new(0, 12)
        NotificationPadding.PaddingBottom = UDim.new(0, 12)
        NotificationPadding.PaddingLeft = UDim.new(0, 12)
        NotificationPadding.PaddingRight = UDim.new(0, 12)
        NotificationPadding.Parent = Notification
        
        local NotificationIcon = Instance.new("ImageLabel")
        NotificationIcon.Name = "Icon"
        NotificationIcon.BackgroundTransparency = 1
        NotificationIcon.Position = UDim2.new(0, 0, 0, 0)
        NotificationIcon.Size = UDim2.new(0, 20, 0, 20)
        NotificationIcon.Image = "rbxassetid://7734190672"
        NotificationIcon.ImageColor3 = config.AccentColor
        NotificationIcon.Parent = Notification
        
        local NotificationMessage = Instance.new("TextLabel")
        NotificationMessage.Name = "Message"
        NotificationMessage.BackgroundTransparency = 1
        NotificationMessage.Position = UDim2.new(0, 30, 0, 0)
        NotificationMessage.Size = UDim2.new(1, -30, 0, 0)
        NotificationMessage.AutomaticSize = Enum.AutomaticSize.Y
        NotificationMessage.Font = Enum.Font.Gotham
        NotificationMessage.Text = message
        NotificationMessage.TextColor3 = Color3.fromRGB(220, 220, 220)
        NotificationMessage.TextSize = 14
        NotificationMessage.TextWrapped = true
        NotificationMessage.TextXAlignment = Enum.TextXAlignment.Left
        NotificationMessage.Parent = Notification
        
        -- Animation
        Notification.BackgroundTransparency = 1
        
        smoothTween(Notification, 0.3, {
            BackgroundTransparency = 0
        }):Play()
    
        task.delay(duration, function()
            smoothTween(Notification, 0.3, {
                BackgroundTransparency = 1
            }):Play()
            
            task.delay(0.3, function()
                Notification:Destroy()
            end)
        end)
    end
    
    -- Set avatar information and other user data
    function hub:SetUserInfo(userData)
        local data = userData or {}
        
        if data.Currency then
            CurrencyText.Text = data.Currency
        end
        
        if data.WalletConnected ~= nil then
            -- Update wallet button state
            if data.WalletConnected then
                -- Show connected state
            else
                -- Show disconnected state
            end
        end
    end
    
    -- Parent to CoreGui
    pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    
    -- Fallback to PlayerGui
    if not ScreenGui.Parent then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    return hub
end

-- Show notification globally
function UILibrary.ShowNotification(message, duration)
    duration = duration or 3
    
    -- Create a simple notification that appears at the top of the screen
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GamerHubNotification"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.BackgroundColor3 = Color3.fromRGB(30, 34, 48)
    notification.Position = UDim2.new(0.5, 0, 0, -50)
    notification.AnchorPoint = Vector2.new(0.5, 0)
    notification.Size = UDim2.new(0, 0, 0, 40)
    notification.AutomaticSize = Enum.AutomaticSize.X
    notification.Parent = screenGui
    
    local notificationCorner = Instance.new("UICorner")
    notificationCorner.CornerRadius = UDim.new(0, 8)
    notificationCorner.Parent = notification
    
    local notificationPadding = Instance.new("UIPadding")
    notificationPadding.PaddingTop = UDim.new(0, 8)
    notificationPadding.PaddingBottom = UDim.new(0, 8)
    notificationPadding.PaddingLeft = UDim.new(0, 16)
    notificationPadding.PaddingRight = UDim.new(0, 16)
    notificationPadding.Parent = notification
    
    local notificationIcon = Instance.new("ImageLabel")
    notificationIcon.Name = "Icon"
    notificationIcon.BackgroundTransparency = 1
    notificationIcon.Position = UDim2.new(0, 0, 0.5, 0)
    notificationIcon.AnchorPoint = Vector2.new(0, 0.5)
    notificationIcon.Size = UDim2.new(0, 20, 0, 20)
    notificationIcon.Image = "rbxassetid://7734190672"
    notificationIcon.ImageColor3 = Color3.fromRGB(119, 86, 255)
    notificationIcon.Parent = notification
    
    local notificationText = Instance.new("TextLabel")
    notificationText.Name = "Text"
    notificationText.BackgroundTransparency = 1
    notificationText.Position = UDim2.new(0, 30, 0, 0)
    notificationText.Size = UDim2.new(0, 0, 1, 0)
    notificationText.AutomaticSize = Enum.AutomaticSize.X
    notificationText.Font = Enum.Font.Gotham
    notificationText.Text = message
    notificationText.TextColor3 = Color3.fromRGB(220, 220, 220)
    notificationText.TextSize = 14
    notificationText.Parent = notification
    
    -- Try to parent to CoreGui
    pcall(function()
    screenGui.Parent = game:GetService("CoreGui")
    end)
    
    -- Fallback to PlayerGui
    if not screenGui.Parent then
        screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Animation
    local tweenService = game:GetService("TweenService")
    local showTween = tweenService:Create(
        notification,
        TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.5, 0, 0, 20)}
    )
    
    showTween:Play()
    
    -- Hide after duration
    task.delay(duration, function()
        local hideTween = tweenService:Create(
            notification,
            TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {Position = UDim2.new(0.5, 0, 0, -50)}
        )
        
        hideTween:Play()
        
        hideTween.Completed:Connect(function()
            screenGui:Destroy()
        end)
    end)
end

-- Create a hub without start menu
function UILibrary.CreateHub(customConfig)
    return UILibrary.new(customConfig)
end

-- Detection for current game to show relevant scripts
function UILibrary.GetCurrentGame()
    local gameId = game.GameId
    local placeName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    return {
        Id = gameId,
        PlaceId = game.PlaceId,
        Name = placeName
    }
end

return UILibrary
