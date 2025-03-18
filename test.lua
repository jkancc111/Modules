local UILibrary = {}

-- Enhanced Theme Configuration - Updated with blue-black acrylic theme
local config = {
    -- Core colors for blue-black acrylic theme
    MainColor = Color3.fromRGB(15, 17, 26),          -- Dark blue-black for main background
    SecondaryColor = Color3.fromRGB(25, 30, 40),     -- Slightly lighter for secondary elements
    AccentColor = Color3.fromRGB(61, 133, 224),      -- Blue accent color (#3D85E0)
    AccentColorHover = Color3.fromRGB(90, 160, 240), -- Lighter blue for hover
    AccentColorActive = Color3.fromRGB(45, 110, 200), -- Darker blue for active/click
    BorderColor = Color3.fromRGB(40, 45, 60),        -- Border color for frames
    
    -- Text colors for better readability on dark theme
    HeadingColor = Color3.fromRGB(230, 230, 240),    -- Almost white for headings
    TextColor = Color3.fromRGB(210, 210, 220),       -- Slightly dimmer for normal text
    SecondaryTextColor = Color3.fromRGB(150, 155, 170), -- Muted for secondary text
    DisabledTextColor = Color3.fromRGB(100, 105, 120), -- Very muted for disabled text
    
    -- Adjusted transparency for acrylic effect
    ElementTransparency = 0.92,    -- More transparent for acrylic look
    HoverTransparency = 0.85,      -- Less transparent on hover
    
    -- More minimal dimensions
    Width = 520,                   -- Reduced width for more compact design
    Height = 340,                  -- Reduced height
    GameItemHeight = 60,           -- Smaller game items
    CornerRadius = UDim.new(0, 5), -- Slightly rounded corners
    ButtonCornerRadius = UDim.new(0, 4),
    
    -- Other settings remain the same
    HeadingFont = Enum.Font.GothamBold,
    Font = Enum.Font.GothamSemibold,
    BodyFont = Enum.Font.Gotham,
    ButtonFont = Enum.Font.GothamSemibold,
    
    HeadingSize = 16,              -- Smaller text size for more minimalism
    SubheadingSize = 14,
    BodyTextSize = 13,
    SmallTextSize = 12,
    
    -- Spacing system for more compact layout
    SpacingXS = 3,
    SpacingS = 6,
    SpacingM = 12,
    SpacingL = 18,
    SpacingXL = 24,
    
    -- Animation speeds
    AnimationSpeed = 0.3,
    AnimationSpeedFast = 0.15,
    AnimationSpeedSlow = 0.5,
    EasingStyle = Enum.EasingStyle.Quint,
    EasingDirection = Enum.EasingDirection.Out,
    
    -- Status colors
    StatusColors = {
        ["Working"] = Color3.fromRGB(80, 170, 120),   -- Green
        ["Updated"] = Color3.fromRGB(61, 133, 224),   -- Blue (same as accent)
        ["Testing"] = Color3.fromRGB(220, 170, 60),   -- Yellow
        ["Patched"] = Color3.fromRGB(200, 80, 80)     -- Red
    },
    
    -- Shadow settings for depth
    ShadowTransparency = 0.82,
    ShadowSize = UDim2.new(1, 8, 1, 8),
    
    -- Interaction effects
    HoverScale = 1.02,
    ClickScale = 0.98,
}

-- Enhanced helper function for smooth animations
local function smoothTween(object, duration, properties, callback)
    local tween = game:GetService("TweenService"):Create(
        object,
        TweenInfo.new(
            duration or config.AnimationSpeed,
            config.EasingStyle,
            config.EasingDirection
        ),
        properties
    )
    
    if callback then
        tween.Completed:Connect(callback)
    end
    
    tween:Play()
    return tween
end

-- Helper function to create shadows
local function createShadow(parent, transparency)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://6014261993" -- Drop shadow image
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = transparency or config.ShadowTransparency
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.Size = config.ShadowSize
    shadow.ZIndex = parent.ZIndex - 1
    shadow.Parent = parent
    return shadow
end

-- Create a new hub instance with minimalist acrylic design
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
    local MainCorner = Instance.new("UICorner")
    local MainBorder = Instance.new("UIStroke")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local SearchContainer = Instance.new("Frame")
    local SearchBar = Instance.new("Frame")
    local SearchBorder = Instance.new("UIStroke")
    local SearchIcon = Instance.new("ImageLabel")
    local SearchInput = Instance.new("TextBox")
    local CategoryContainer = Instance.new("Frame")
    local CategoryLayout = Instance.new("UIListLayout")
    local GameList = Instance.new("ScrollingFrame")
    local GameListLayout = Instance.new("UIListLayout")
    local GameListPadding = Instance.new("UIPadding")
    local EmptyStateLabel = Instance.new("TextLabel")
    local LoadingIndicator = Instance.new("Frame")
    
    -- Set up ScreenGui with better properties for performance
    ScreenGui.Name = "LomuHubLibrary"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 100
    
    -- Main frame with clean modern acrylic design
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = config.MainColor
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Size = UDim2.new(0, config.Width, 0, config.Height)
    MainFrame.Visible = false -- Hide initially
    MainFrame.Parent = ScreenGui
    
    -- Add shadow for elevation
    createShadow(MainFrame)
    
    MainCorner.CornerRadius = config.CornerRadius
    MainCorner.Parent = MainFrame
    
    MainBorder.Color = config.BorderColor
    MainBorder.Thickness = 1
    MainBorder.Parent = MainFrame
    
    -- Top bar with minimalist design
    TopBar.Name = "TopBar"
    TopBar.BackgroundTransparency = 1
    TopBar.Size = UDim2.new(1, 0, 0, config.SpacingXL)
    TopBar.Parent = MainFrame
    
    -- Simplified top without divider line for cleaner design
    
    Title.Name = "Title"
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, config.SpacingM, 0, 0)
    Title.Size = UDim2.new(1, -70, 1, 0)
    Title.Font = config.HeadingFont
    Title.Text = "Lomu Hub"
    Title.TextColor3 = config.HeadingColor
    Title.TextSize = config.HeadingSize
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar
    
    -- Close button with improved visuals
    CloseButton.Name = "CloseButton"
    CloseButton.BackgroundColor3 = Color3.fromRGB(192, 57, 57)
    CloseButton.Position = UDim2.new(1, -config.SpacingM - 16, 0.5, 0)
    CloseButton.AnchorPoint = Vector2.new(0, 0.5)
    CloseButton.Size = UDim2.new(0, 16, 0, 16)
    CloseButton.Font = config.HeadingFont
    CloseButton.Text = "×" -- Using a proper multiplication sign
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 16
    CloseButton.AutoButtonColor = false
    CloseButton.Parent = TopBar
    
    local CloseButtonCorner = Instance.new("UICorner")
    CloseButtonCorner.CornerRadius = UDim.new(0, 3)
    CloseButtonCorner.Parent = CloseButton
    
    -- Compact search container
    SearchContainer.Name = "SearchContainer"
    SearchContainer.BackgroundTransparency = 1
    SearchContainer.Position = UDim2.new(0, config.SpacingM, 0, TopBar.Size.Y.Offset + config.SpacingXS)
    SearchContainer.Size = UDim2.new(1, -config.SpacingM*2, 0, config.SpacingL)
    SearchContainer.Parent = MainFrame
    
    -- Search bar with clean acrylic look
    SearchBar.Name = "SearchBar"
    SearchBar.BackgroundColor3 = config.SecondaryColor
    SearchBar.BackgroundTransparency = config.ElementTransparency
    SearchBar.Size = UDim2.new(1, 0, 1, 0)
    SearchBar.Parent = SearchContainer
    
    SearchBorder.Color = config.BorderColor
    SearchBorder.Thickness = 1
    SearchBorder.Parent = SearchBar
    
    local SearchBarCorner = Instance.new("UICorner")
    SearchBarCorner.CornerRadius = UDim.new(0, 4)
    SearchBarCorner.Parent = SearchBar
    
    SearchIcon.Name = "SearchIcon"
    SearchIcon.BackgroundTransparency = 1
    SearchIcon.Position = UDim2.new(0, config.SpacingS, 0.5, 0)
    SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
    SearchIcon.Size = UDim2.new(0, 12, 0, 12)
    SearchIcon.Image = "rbxassetid://3926305904"
    SearchIcon.ImageRectOffset = Vector2.new(964, 324)
    SearchIcon.ImageRectSize = Vector2.new(36, 36)
    SearchIcon.ImageColor3 = config.SecondaryTextColor
    SearchIcon.Parent = SearchBar
    
    SearchInput.Name = "SearchInput"
    SearchInput.BackgroundTransparency = 1
    SearchInput.Position = UDim2.new(0, config.SpacingL + 4, 0, 0)
    SearchInput.Size = UDim2.new(1, -(config.SpacingL + 4 + config.SpacingS), 1, 0)
    SearchInput.Font = config.BodyFont
    SearchInput.PlaceholderText = "Search games..."
    SearchInput.Text = ""
    SearchInput.TextColor3 = config.TextColor
    SearchInput.PlaceholderColor3 = Color3.fromRGB(100, 110, 130)
    SearchInput.TextSize = config.BodyTextSize
    SearchInput.TextXAlignment = Enum.TextXAlignment.Left
    SearchInput.ClearTextOnFocus = false
    SearchInput.Parent = SearchBar
    
    -- Compact category container
    CategoryContainer.Name = "CategoryContainer"
    CategoryContainer.BackgroundTransparency = 1
    CategoryContainer.Position = UDim2.new(0, config.SpacingM, 0, SearchContainer.Position.Y.Offset + SearchContainer.Size.Y.Offset + config.SpacingXS)
    CategoryContainer.Size = UDim2.new(1, -config.SpacingM*2, 0, config.SpacingL)
    CategoryContainer.Parent = MainFrame
    
    CategoryLayout.Name = "CategoryLayout"
    CategoryLayout.FillDirection = Enum.FillDirection.Horizontal
    CategoryLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    CategoryLayout.SortOrder = Enum.SortOrder.LayoutOrder
    CategoryLayout.Padding = UDim.new(0, config.SpacingS)
    CategoryLayout.Parent = CategoryContainer
    
    -- Game list with optimized spacing
    GameList.Name = "GameList"
    GameList.BackgroundTransparency = 1
    GameList.Position = UDim2.new(0, config.SpacingM, 0, CategoryContainer.Position.Y.Offset + CategoryContainer.Size.Y.Offset + config.SpacingS)
    GameList.Size = UDim2.new(1, -config.SpacingM*2, 1, -(CategoryContainer.Position.Y.Offset + CategoryContainer.Size.Y.Offset + config.SpacingS + config.SpacingM))
    GameList.CanvasSize = UDim2.new(0, 0, 0, 0)
    GameList.ScrollBarThickness = 3 -- Thinner scrollbar
    GameList.ScrollBarImageColor3 = config.AccentColor
    GameList.ScrollingDirection = Enum.ScrollingDirection.Y
    GameList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    GameList.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    GameList.Parent = MainFrame
    
    GameListLayout.Name = "GameListLayout"
    GameListLayout.Padding = UDim.new(0, config.SpacingXS)
    GameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    GameListLayout.Parent = GameList
    
    GameListPadding.PaddingTop = UDim.new(0, config.SpacingXS)
    GameListPadding.PaddingBottom = UDim.new(0, config.SpacingS)
    GameListPadding.Parent = GameList
    
    -- Empty state message
    EmptyStateLabel.Name = "EmptyState"
    EmptyStateLabel.BackgroundTransparency = 1
    EmptyStateLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    EmptyStateLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    EmptyStateLabel.Size = UDim2.new(0, 260, 0, 50)
    EmptyStateLabel.Font = config.Font
    EmptyStateLabel.Text = "No games found. Try adjusting your search or category."
    EmptyStateLabel.TextColor3 = config.SecondaryTextColor
    EmptyStateLabel.TextSize = config.BodyTextSize
    EmptyStateLabel.TextWrapped = true
    EmptyStateLabel.Visible = false
    EmptyStateLabel.Parent = GameList
    
    -- Loading Indicator - minimalist design
    LoadingIndicator.Name = "LoadingIndicator"
    LoadingIndicator.BackgroundTransparency = 1
    LoadingIndicator.Position = UDim2.new(0.5, 0, 0.5, 0)
    LoadingIndicator.AnchorPoint = Vector2.new(0.5, 0.5)
    LoadingIndicator.Size = UDim2.new(0, 36, 0, 36)
    LoadingIndicator.Visible = false
    LoadingIndicator.Parent = MainFrame
    
    -- Create loading spinner elements
    for i = 1, 3 do -- Reduced to 3 dots for minimalism
        local dot = Instance.new("Frame")
        dot.Name = "LoadingDot" .. i
        dot.BackgroundColor3 = config.AccentColor
        dot.Position = UDim2.new(0.5, -3, 0.5, -3)
        dot.AnchorPoint = Vector2.new(0.5, 0.5)
        dot.Size = UDim2.new(0, 6, 0, 6)
        dot.Parent = LoadingIndicator
        
        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(1, 0)
        dotCorner.Parent = dot
    end
    
    -- Loading animation with simplified design
    local function animateLoading()
        local dots = {
            LoadingIndicator.LoadingDot1,
            LoadingIndicator.LoadingDot2,
            LoadingIndicator.LoadingDot3
        }
        
        local connection
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not LoadingIndicator.Parent then
                connection:Disconnect()
                return
            end
            
            for i, dot in ipairs(dots) do
                local angle = (os.clock() * 2 + (i-1) * (math.pi*2/3)) % (math.pi * 2)
                local radius = 12
                local x = math.cos(angle) * radius
                local y = math.sin(angle) * radius
                dot.Position = UDim2.new(0.5, x - 3, 0.5, y - 3)
                dot.BackgroundTransparency = 0.3 + 0.5 * ((math.sin(angle) + 1) / 2)
            end
        end)
    end
    
    -- Create initial categories with improved design
    local categories = {"All", "Popular", "Recent"}
    local selectedCategory = "All"
    local categoryButtons = {}
    
    for i, catName in ipairs(categories) do
        local CategoryButton = Instance.new("TextButton")
        local CategoryButtonCorner = Instance.new("UICorner")
        
        CategoryButton.Name = "Category_" .. catName
        CategoryButton.BackgroundColor3 = (catName == selectedCategory) and config.AccentColor or config.SecondaryColor
        CategoryButton.BackgroundTransparency = (catName == selectedCategory) and 0 or config.ElementTransparency
        CategoryButton.Size = UDim2.new(0, 0, 1, 0)
        CategoryButton.AutomaticSize = Enum.AutomaticSize.X
        CategoryButton.Font = config.BodyFont
        CategoryButton.Text = " " .. catName .. " "
        CategoryButton.TextColor3 = config.TextColor
        CategoryButton.TextSize = config.BodyTextSize
        CategoryButton.AutoButtonColor = false -- Custom hover effects
        CategoryButton.Parent = CategoryContainer
        
        CategoryButtonCorner.CornerRadius = config.ButtonCornerRadius
        CategoryButtonCorner.Parent = CategoryButton
        
        -- More advanced hover/click effects
        CategoryButton.MouseEnter:Connect(function()
            if catName ~= selectedCategory then
                smoothTween(CategoryButton, config.AnimationSpeedFast, {
                    BackgroundColor3 = Color3.fromRGB(45, 55, 75),
                    BackgroundTransparency = 0.75,
                    Size = UDim2.new(0, CategoryButton.AbsoluteSize.X * config.HoverScale, 1, 0)
                })
            end
        end)
        
        CategoryButton.MouseLeave:Connect(function()
            if catName ~= selectedCategory then
                smoothTween(CategoryButton, config.AnimationSpeedFast, {
                    BackgroundColor3 = config.SecondaryColor,
                    BackgroundTransparency = config.ElementTransparency,
                    Size = UDim2.new(0, 0, 1, 0)
                })
            end
        end)
        
        CategoryButton.MouseButton1Click:Connect(function()
            if catName ~= selectedCategory then
                -- Show loading indicator
                LoadingIndicator.Visible = true
                animateLoading()
                
                -- Update old selected button
                for _, btn in pairs(categoryButtons) do
                    if btn.Name == "Category_" .. selectedCategory then
                        smoothTween(btn, config.AnimationSpeedFast, {
                            BackgroundColor3 = config.SecondaryColor,
                            BackgroundTransparency = config.ElementTransparency
                        })
                    end
                end
                
                -- Update new selected button
                smoothTween(CategoryButton, config.AnimationSpeedFast, {
                    BackgroundColor3 = config.AccentColor,
                    BackgroundTransparency = 0,
                    Size = UDim2.new(0, 0, 1, 0)
                })
                
                selectedCategory = catName
                
                -- Filter games based on category with animation
                local visibleCount = 0
                
                for _, child in pairs(GameList:GetChildren()) do
                    if child:IsA("Frame") and child.Name:sub(1, 9) == "GameItem_" then
                        local gameCategory = child:GetAttribute("Category") or "All"
                        local shouldBeVisible = (selectedCategory == "All" or gameCategory == selectedCategory)
                        
                        -- Apply search filter if exists
                        local searchText = string.lower(SearchInput.Text)
                        if searchText ~= "" then
                            local gameName = child.Name:sub(10)
                            shouldBeVisible = shouldBeVisible and string.find(string.lower(gameName), searchText)
                        end
                        
                        -- Animate visibility change
                        if shouldBeVisible then
                            visibleCount = visibleCount + 1
                            if not child.Visible then
                                child.Visible = true
                                child.BackgroundTransparency = 1
                                smoothTween(child, config.AnimationSpeedFast, {
                                    BackgroundTransparency = config.ElementTransparency
                                })
                            end
                        else
                            if child.Visible then
                                smoothTween(child, config.AnimationSpeedFast, {
                                    BackgroundTransparency = 1
                                }, function()
                                    child.Visible = false
                                end)
                            end
                        end
                    end
                end
                
                -- Update empty state
                EmptyStateLabel.Visible = (visibleCount == 0)
                
                -- Hide loading indicator after filtering
                task.delay(0.3, function()
                    LoadingIndicator.Visible = false
                end)
            end
        end)
        
        table.insert(categoryButtons, CategoryButton)
    end
    
    -- Close button functionality with improved animation
    CloseButton.MouseEnter:Connect(function()
        smoothTween(CloseButton, config.AnimationSpeedFast, {
            BackgroundColor3 = Color3.fromRGB(222, 87, 87),
            Size = UDim2.new(0, 18, 0, 18)
        })
    end)
    
    CloseButton.MouseLeave:Connect(function()
        smoothTween(CloseButton, config.AnimationSpeedFast, {
            BackgroundColor3 = Color3.fromRGB(192, 57, 57),
            Size = UDim2.new(0, 16, 0, 16)
        })
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        -- Fade out content
        for _, child in pairs(MainFrame:GetChildren()) do
            if child:IsA("GuiObject") and child ~= MainFrame and child.Name ~= "Shadow" then
                if child.ClassName == "TextLabel" or child.ClassName == "TextButton" or child.ClassName == "TextBox" then
                    smoothTween(child, config.AnimationSpeedFast, {
                        TextTransparency = 1
                    })
                end
                
                if child.BackgroundTransparency < 1 then
                    smoothTween(child, config.AnimationSpeedFast, {
                        BackgroundTransparency = 1
                    })
                end
            end
        end
        
        -- Then shrink frame
        task.delay(config.AnimationSpeedFast, function()
            local closeTween = smoothTween(MainFrame, config.AnimationSpeed, {
                Size = UDim2.new(0, MainFrame.Size.X.Offset, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            })
            
            closeTween.Completed:Connect(function()
                ScreenGui:Destroy()
            end)
        end)
    end)
    
    -- Add game function - Redesigned for minimalist acrylic theme
    function hub:AddGame(gameData)
        local game = gameData or {}
        local gameName = game.Name or "Unnamed Game"
        local gameLastUpdate = game.LastUpdate or "Unknown"
        local gameStatus = game.Status or "Unknown"
        local gameThumbnail = game.Thumbnail or config.DefaultThumbnail
        local gameCallback = game.Callback or function() end
        local gameCategory = game.Category or "All"
        
        -- Create modern minimalist game item
        local GameItem = Instance.new("Frame")
        local GameItemInner = Instance.new("Frame")
        local GameCorner = Instance.new("UICorner")
        local GameBorder = Instance.new("UIStroke")
        local Thumbnail = Instance.new("ImageLabel")
        local ThumbnailCorner = Instance.new("UICorner")
        local GameName = Instance.new("TextLabel")
        local StatusLabel = Instance.new("TextLabel")
        local StatusIndicator = Instance.new("Frame")
        local PlayButton = Instance.new("TextButton")
        local PlayButtonCorner = Instance.new("UICorner")
        
        GameItem.Name = "GameItem_" .. gameName
        GameItem.BackgroundColor3 = config.SecondaryColor
        GameItem.BackgroundTransparency = config.ElementTransparency
        GameItem.Size = UDim2.new(1, 0, 0, config.GameItemHeight)
        GameItem.ClipsDescendants = true
        GameItem.Parent = GameList
        GameItem:SetAttribute("Category", gameCategory)
        
        GameCorner.CornerRadius = config.CornerRadius
        GameCorner.Parent = GameItem
        
        GameBorder.Color = config.BorderColor
        GameBorder.Thickness = 1
        GameBorder.Parent = GameItem
        
        -- Inner container for animation effects
        GameItemInner.Name = "Inner"
        GameItemInner.BackgroundTransparency = 1
        GameItemInner.Size = UDim2.new(1, 0, 1, 0)
        GameItemInner.Position = UDim2.new(0, 0, 0, 0)
        GameItemInner.Parent = GameItem
        
        -- Thumbnail with improved spacing
        Thumbnail.Name = "Thumbnail"
        Thumbnail.BackgroundColor3 = Color3.fromRGB(15, 18, 25)
        Thumbnail.Position = UDim2.new(0, 12, 0.5, 0) -- Increased spacing
        Thumbnail.AnchorPoint = Vector2.new(0, 0.5)
        Thumbnail.Size = UDim2.new(0, 45, 0, 45)
        Thumbnail.Image = gameThumbnail
        Thumbnail.Parent = GameItemInner
        
        ThumbnailCorner.CornerRadius = UDim.new(0, 4)
        ThumbnailCorner.Parent = Thumbnail
        
        -- Game name - improved spacing
        GameName.Name = "GameName"
        GameName.BackgroundTransparency = 1
        GameName.Position = UDim2.new(0, 68, 0, 11) -- Increased spacing
        GameName.Size = UDim2.new(1, -155, 0, 18)
        GameName.Font = config.Font
        GameName.Text = gameName
        GameName.TextColor3 = config.TextColor
        GameName.TextSize = config.SubheadingSize
        GameName.TextXAlignment = Enum.TextXAlignment.Left
        GameName.Parent = GameItemInner
        
        -- Status indicator - better spacing
        local statusColor = config.StatusColors[gameStatus] or Color3.fromRGB(150, 150, 150)
        
        StatusIndicator.Name = "StatusIndicator"
        StatusIndicator.BackgroundColor3 = statusColor
        StatusIndicator.Position = UDim2.new(0, 68, 0, GameName.Position.Y.Offset + GameName.Size.Y.Offset + 7)
        StatusIndicator.Size = UDim2.new(0, 6, 0, 6)
        StatusIndicator.Parent = GameItemInner
        
        local StatusIndicatorCorner = Instance.new("UICorner")
        StatusIndicatorCorner.CornerRadius = UDim.new(1, 0)
        StatusIndicatorCorner.Parent = StatusIndicator
        
        StatusLabel.Name = "StatusLabel"
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Position = UDim2.new(0, 80, 0, StatusIndicator.Position.Y.Offset - 3)
        StatusLabel.Size = UDim2.new(0, 150, 0, 12)
        StatusLabel.Font = config.BodyFont
        StatusLabel.Text = gameStatus .. " • " .. gameLastUpdate
        StatusLabel.TextColor3 = config.SecondaryTextColor
        StatusLabel.TextSize = config.SmallTextSize
        StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
        StatusLabel.Parent = GameItemInner
        
        -- Play button - better spacing
        PlayButton.Name = "PlayButton"
        PlayButton.BackgroundColor3 = config.AccentColor
        PlayButton.Position = UDim2.new(1, -70, 0.5, 0) -- Increased spacing
        PlayButton.AnchorPoint = Vector2.new(0, 0.5)
        PlayButton.Size = UDim2.new(0, 58, 0, 30)
        PlayButton.AutoButtonColor = false
        PlayButton.Font = config.ButtonFont
        PlayButton.Text = "PLAY"
        PlayButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        PlayButton.TextSize = 13
        PlayButton.Parent = GameItemInner
        
        PlayButtonCorner.CornerRadius = UDim.new(0, 5)
        PlayButtonCorner.Parent = PlayButton
        
        -- Add shadow
        createShadow(PlayButton, 0.8)
        
        -- Game item hover effect
        GameItem.MouseEnter:Connect(function()
            smoothTween(GameItem, config.AnimationSpeedFast, {
                BackgroundTransparency = config.HoverTransparency
            })
            
            smoothTween(GameBorder, config.AnimationSpeedFast, {
                Color = config.AccentColor,
                Transparency = 0.7
            })
        end)
        
        GameItem.MouseLeave:Connect(function()
            smoothTween(GameItem, config.AnimationSpeedFast, {
                BackgroundTransparency = config.ElementTransparency
            })
            
            smoothTween(GameBorder, config.AnimationSpeedFast, {
                Color = config.BorderColor,
                Transparency = 0
            })
        end)
        
        -- Play button hover effects
        PlayButton.MouseEnter:Connect(function()
            smoothTween(PlayButton, config.AnimationSpeedFast, {
                BackgroundColor3 = config.AccentColorHover,
                Size = UDim2.new(0, 60, 0, 32)
            })
        end)
        
        PlayButton.MouseLeave:Connect(function()
            smoothTween(PlayButton, config.AnimationSpeedFast, {
                BackgroundColor3 = config.AccentColor,
                Size = UDim2.new(0, 58, 0, 30)
            })
        end)
        
        -- Play button click feedback
        PlayButton.MouseButton1Down:Connect(function()
            smoothTween(PlayButton, 0.1, {
                Size = UDim2.new(0, 56, 0, 28),
                BackgroundColor3 = config.AccentColorActive
            })
        end)
        
        PlayButton.MouseButton1Up:Connect(function()
            smoothTween(PlayButton, 0.1, {
                Size = UDim2.new(0, 58, 0, 30),
                BackgroundColor3 = config.AccentColorHover
            })
        end)
        
        -- Play button functionality with improved loading animation
        PlayButton.MouseButton1Click:Connect(function()
            -- Visual feedback
            PlayButton.Text = ""
            
            -- Create loading container with better animation
            local loadingContainer = Instance.new("Frame")
            loadingContainer.Name = "LoadingContainer"
            loadingContainer.BackgroundTransparency = 1
            loadingContainer.Size = UDim2.new(1, 0, 1, 0)
            loadingContainer.ZIndex = 10
            loadingContainer.Parent = PlayButton
            
            -- Create loading dots with pulsing animation
            local dots = {}
            for i = 1, 3 do
                local dot = Instance.new("Frame")
                dot.Name = "LoadingDot" .. i
                dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dot.Position = UDim2.new(0.5, -10 + (i-1)*10, 0.5, 0)
                dot.AnchorPoint = Vector2.new(0.5, 0.5)
                dot.Size = UDim2.new(0, 5, 0, 5)
                dot.ZIndex = 11
                
                local dotCorner = Instance.new("UICorner")
                dotCorner.CornerRadius = UDim.new(1, 0)
                dotCorner.Parent = dot
                
                dot.Parent = loadingContainer
                table.insert(dots, dot)
            end
            
            -- Animate the dots with wave pattern
            task.spawn(function()
                local startTime = tick()
                while loadingContainer.Parent do
                    for i, dot in ipairs(dots) do
                        local offset = (i - 1) * 0.33
                        local scaleWave = 0.7 + 0.6 * math.abs(math.sin((tick() - startTime) * 3 + offset * math.pi * 2))
                        
                        -- Smooth size animation
                        smoothTween(dot, 0.1, {
                            Size = UDim2.new(0, 5 * scaleWave, 0, 5 * scaleWave),
                            BackgroundTransparency = 0.2 * (1 - scaleWave)
                        })
                    end
                    task.wait(0.05)
                end
            end)
            
            -- Execute callback with timeout handling
            local callbackSuccess = false
            local callbackThread = task.spawn(function()
                gameCallback()
                callbackSuccess = true
            end)
            
            -- Show loading for at least 0.8 seconds for better feedback
            task.delay(0.8, function()
                -- Reset button state
                if loadingContainer.Parent then
                    loadingContainer:Destroy()
                end
                PlayButton.Text = "PLAY"
                
                -- Provide feedback if script is taking long
                if not callbackSuccess then
                    task.delay(5, function()
                        if not callbackSuccess then
                            hub:ShowNotification("Script execution in progress...", 3, "Info")
                        end
                    end)
                    
                    task.delay(15, function()
                        if not callbackSuccess then
                            hub:ShowNotification("Script execution taking longer than expected", 3, "Warning")
                        end
                    end)
                end
            end)
        end)
        
        -- Connect to search filter
        local function updateVisibility()
            local searchText = string.lower(SearchInput.Text)
            local shouldBeVisible = (selectedCategory == "All" or gameCategory == selectedCategory)
            
            if searchText ~= "" then
                shouldBeVisible = shouldBeVisible and string.find(string.lower(gameName), searchText)
            end
            
            GameItem.Visible = shouldBeVisible
        end
        
        -- Initial visibility check
        updateVisibility()
        
        return GameItem
    end
    
    -- Add category function with improved design
    function hub:AddCategory(categoryName)
        -- Check if category already exists
        for _, btn in pairs(categoryButtons) do
            if btn.Name == "Category_" .. categoryName then
                return
            end
        end
        
        local CategoryButton = Instance.new("TextButton")
        local CategoryButtonCorner = Instance.new("UICorner")
        
        CategoryButton.Name = "Category_" .. categoryName
        CategoryButton.BackgroundColor3 = config.SecondaryColor
        CategoryButton.BackgroundTransparency = config.ElementTransparency
        CategoryButton.Size = UDim2.new(0, 0, 1, 0)
        CategoryButton.AutomaticSize = Enum.AutomaticSize.X
        CategoryButton.Font = config.BodyFont
        CategoryButton.Text = " " .. categoryName .. " "
        CategoryButton.TextColor3 = config.TextColor
        CategoryButton.TextSize = config.BodyTextSize
        CategoryButton.AutoButtonColor = false -- Custom hover effects
        CategoryButton.Parent = CategoryContainer
        
        CategoryButtonCorner.CornerRadius = config.ButtonCornerRadius
        CategoryButtonCorner.Parent = CategoryButton
        
        -- Enhanced hover effects
        CategoryButton.MouseEnter:Connect(function()
            if categoryName ~= selectedCategory then
                smoothTween(CategoryButton, config.AnimationSpeedFast, {
                    BackgroundColor3 = Color3.fromRGB(45, 55, 75),
                    BackgroundTransparency = 0.75,
                    Size = UDim2.new(0, CategoryButton.AbsoluteSize.X * config.HoverScale, 1, 0)
                })
            end
        end)
        
        CategoryButton.MouseLeave:Connect(function()
            if categoryName ~= selectedCategory then
                smoothTween(CategoryButton, config.AnimationSpeedFast, {
                    BackgroundColor3 = config.SecondaryColor,
                    BackgroundTransparency = config.ElementTransparency,
                    Size = UDim2.new(0, 0, 1, 0)
                })
            end
        end)
        
        CategoryButton.MouseButton1Click:Connect(function()
            if categoryName ~= selectedCategory then
                -- Show loading indicator
                LoadingIndicator.Visible = true
                animateLoading()
                
                -- Update old selected button
                for _, btn in pairs(categoryButtons) do
                    if btn.Name == "Category_" .. selectedCategory then
                        smoothTween(btn, config.AnimationSpeedFast, {
                            BackgroundColor3 = config.SecondaryColor,
                            BackgroundTransparency = config.ElementTransparency
                        })
                    end
                end
                
                -- Update new selected button
                smoothTween(CategoryButton, config.AnimationSpeedFast, {
                    BackgroundColor3 = config.AccentColor,
                    BackgroundTransparency = 0,
                    Size = UDim2.new(0, 0, 1, 0)
                })
                
                selectedCategory = categoryName
                
                -- Filter games with subtle animation
                local visibleCount = 0
                
                for _, child in pairs(GameList:GetChildren()) do
                    if child:IsA("Frame") and child.Name:sub(1, 9) == "GameItem_" then
                        local gameCategory = child:GetAttribute("Category") or "All"
                        local shouldBeVisible = (selectedCategory == "All" or gameCategory == selectedCategory)
                        
                        -- Apply search filter if exists
                        local searchText = string.lower(SearchInput.Text)
                        if searchText ~= "" then
                            local gameName = child.Name:sub(10)
                            shouldBeVisible = shouldBeVisible and string.find(string.lower(gameName), searchText)
                        end
                        
                        -- Animate visibility with subtle slide
                        if shouldBeVisible then
                            visibleCount = visibleCount + 1
                            if not child.Visible then
                                task.delay(visibleCount * 0.02, function()
                                    child.Visible = true
                                    child.BackgroundTransparency = 1
                                    child.Position = UDim2.new(0.03, 0, 0, child.Position.Y.Offset)
                                    
                                    smoothTween(child, config.AnimationSpeedFast, {
                                        BackgroundTransparency = config.ElementTransparency,
                                        Position = UDim2.new(0, 0, 0, child.Position.Y.Offset)
                                    })
                                end)
                            end
                        else
                            if child.Visible then
                                smoothTween(child, config.AnimationSpeedFast, {
                                    BackgroundTransparency = 1,
                                    Position = UDim2.new(-0.03, 0, 0, child.Position.Y.Offset)
                                }, function()
                                    child.Visible = false
                                    child.Position = UDim2.new(0, 0, 0, child.Position.Y.Offset)
                                end)
                            end
                        end
                    end
                end
                
                -- Update empty state
                EmptyStateLabel.Visible = (visibleCount == 0)
                
                -- Hide loading after filtering
                task.delay(0.3, function()
                    LoadingIndicator.Visible = false
                end)
            end
        end)
        
        table.insert(categoryButtons, CategoryButton)
        return CategoryButton
    end
    
    -- Set title with animation
    function hub:SetTitle(titleText)
        Title.Text = titleText
    end
    
    -- Improved notification system - redesigned for minimalist acrylic theme
    function hub:ShowNotification(message, duration, notificationType)
        duration = duration or 3
        notificationType = notificationType or "Info" -- Info, Success, Warning, Error
        
        local notification = Instance.new("Frame")
        local notificationCorner = Instance.new("UICorner")
        local notificationBorder = Instance.new("UIStroke")
        local notificationIcon = Instance.new("ImageLabel")
        local notificationText = Instance.new("TextLabel")
        local closeButton = Instance.new("TextButton")
        
        notification.Name = "Notification"
        notification.BackgroundColor3 = config.MainColor
        notification.BackgroundTransparency = 0.1
        notification.Position = UDim2.new(0.5, 0, 0, -40)
        notification.AnchorPoint = Vector2.new(0.5, 0)
        notification.Size = UDim2.new(0, 0, 0, 36) -- More compact
        notification.AutomaticSize = Enum.AutomaticSize.X
        notification.ZIndex = 1000
        notification.Parent = ScreenGui
        
        -- Add shadow for depth
        createShadow(notification, 0.8)
        
        notificationCorner.CornerRadius = UDim.new(0, 4)
        notificationCorner.Parent = notification
        
        -- Border color based on type
        local borderColor = config.AccentColor
        if notificationType == "Success" then
            borderColor = config.StatusColors.Working
        elseif notificationType == "Warning" then
            borderColor = config.StatusColors.Testing
        elseif notificationType == "Error" then
            borderColor = config.StatusColors.Patched
        end
        
        notificationBorder.Color = borderColor
        notificationBorder.Thickness = 1
        notificationBorder.Parent = notification
        
        -- Icon based on type
        notificationIcon.Name = "Icon"
        notificationIcon.BackgroundTransparency = 1
        notificationIcon.Position = UDim2.new(0, 10, 0.5, 0)
        notificationIcon.AnchorPoint = Vector2.new(0, 0.5)
        notificationIcon.Size = UDim2.new(0, 14, 0, 14)
        
        -- Set icon based on type
        if notificationType == "Success" then
            notificationIcon.Image = "rbxassetid://3926305904"
            notificationIcon.ImageRectOffset = Vector2.new(184, 484)
            notificationIcon.ImageRectSize = Vector2.new(36, 36)
            notificationIcon.ImageColor3 = config.StatusColors.Working
        elseif notificationType == "Warning" then
            notificationIcon.Image = "rbxassetid://3926305904"
            notificationIcon.ImageRectOffset = Vector2.new(364, 324)
            notificationIcon.ImageRectSize = Vector2.new(36, 36)
            notificationIcon.ImageColor3 = config.StatusColors.Testing
        elseif notificationType == "Error" then
            notificationIcon.Image = "rbxassetid://3926305904"
            notificationIcon.ImageRectOffset = Vector2.new(924, 724)
            notificationIcon.ImageRectSize = Vector2.new(36, 36)
            notificationIcon.ImageColor3 = config.StatusColors.Patched
        else -- Info
            notificationIcon.Image = "rbxassetid://3926305904"
            notificationIcon.ImageRectOffset = Vector2.new(124, 924)
            notificationIcon.ImageRectSize = Vector2.new(36, 36)
            notificationIcon.ImageColor3 = config.AccentColor
        end
        
        notificationIcon.Parent = notification
        
        notificationText.Name = "NotificationText"
        notificationText.BackgroundTransparency = 1
        notificationText.Position = UDim2.new(0, 30, 0, 0)
        notificationText.Size = UDim2.new(0, 0, 1, 0)
        notificationText.AutomaticSize = Enum.AutomaticSize.X
        notificationText.Font = config.BodyFont
        notificationText.Text = message
        notificationText.TextColor3 = config.TextColor
        notificationText.TextSize = 13
        notificationText.Parent = notification
        
        -- Close button for notifications
        closeButton.Name = "CloseButton"
        closeButton.BackgroundTransparency = 1
        closeButton.Position = UDim2.new(1, -16, 0.5, 0)
        closeButton.AnchorPoint = Vector2.new(0.5, 0.5)
        closeButton.Size = UDim2.new(0, 16, 0, 16)
        closeButton.Font = config.HeadingFont
        closeButton.Text = "×"
        closeButton.TextColor3 = config.SecondaryTextColor
        closeButton.TextSize = 18
        closeButton.ZIndex = 1001
        closeButton.Parent = notification
        
        -- Show notification with entrance animation
        local function showNotification()
            notification.Size = UDim2.new(0, notificationText.TextBounds.X + 60, 0, 36)
            
            smoothTween(notification, 0.3, {
                Position = UDim2.new(0.5, 0, 0, 15)
            })
        end
        
        -- Hide notification with exit animation
        function dismissNotification()
            smoothTween(notification, 0.3, {
                Position = UDim2.new(0.5, 0, 0, -40)
            }, function()
                notification:Destroy()
            end)
        end
        
        -- Close button click
        closeButton.MouseButton1Click:Connect(function()
            dismissNotification()
        end)
        
        -- Show notification
        showNotification()
        
        -- Auto dismiss after duration
        task.delay(duration, function()
            if notification.Parent then
                dismissNotification()
            end
        end)
        
        return notification
    end
    
    -- Parent to CoreGui or PlayerGui
    pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    
    if not ScreenGui.Parent then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Improved opening animation sequence
    -- First make the frame visible but with zero height
    MainFrame.Size = UDim2.new(0, config.Width, 0, 0)
    MainFrame.Visible = true
    
    -- Then animate to full size
    local openTween = smoothTween(MainFrame, config.AnimationSpeed, {
        Size = UDim2.new(0, config.Width, 0, config.Height)
    })
    
    openTween:Play()
    
    return hub
end

-- Create a hub directly (no start menu)
function UILibrary.CreateHub(customConfig)
    return UILibrary.new(customConfig)
end

-- Redesigned Start Menu - blue acrylic design matching the Game Hub
function UILibrary:CreateStartMenu(options)
    local startOptions = options or {}
    local logoText = startOptions.LogoText or "Lomu Hub"
    local description = startOptions.Description or "Premium script hub"
    local accentColor = startOptions.AccentColor or Color3.fromRGB(61, 133, 224) -- Blue accent
    local buttonCallback = startOptions.ButtonCallback or function() end
    local universalButtonCallback = startOptions.UniversalButtonCallback or function() end
    
    -- Create Start Menu container
    local StartMenu = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Corner = Instance.new("UICorner")
    local Shadow = Instance.new("ImageLabel")
    local LogoContainer = Instance.new("Frame")
    local Logo = Instance.new("TextLabel")
    local Description = Instance.new("TextLabel")
    local TitleDivider = Instance.new("Frame")
    local PlayerInfoContainer = Instance.new("Frame")
    local PlayerAvatar = Instance.new("ImageLabel")
    local PlayerAvatarCorner = Instance.new("UICorner")
    local PlayerName = Instance.new("TextLabel")
    local ButtonsContainer = Instance.new("Frame")
    local LoadHubButton = Instance.new("TextButton")
    local HubButtonCorner = Instance.new("UICorner")
    local LoadUniversalButton = Instance.new("TextButton")
    local UniversalButtonCorner = Instance.new("UICorner")
    
    -- Set up Start Menu
    StartMenu.Name = "StartMenu"
    StartMenu.ResetOnSpawn = false
    StartMenu.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Try to use CoreGui for better performance
    pcall(function()
        if not game:GetService("CoreGui"):FindFirstChild("StartMenu") then
            StartMenu.Parent = game:GetService("CoreGui")
        else
            StartMenu.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
        end
    end)
    
    if not StartMenu.Parent then
        StartMenu.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Main frame - redesigned for better alignment and spacing
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 17, 26) -- Dark blue-black background
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 1, 100) -- Start offscreen
    MainFrame.AnchorPoint = Vector2.new(0.5, 1)
    MainFrame.Size = UDim2.new(0, 300, 0, 165) -- Adjusted size for better proportions
    MainFrame.Parent = StartMenu
    
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = MainFrame
    
    -- Add shadow for depth
    Shadow.Name = "Shadow"
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, 24, 1, 24)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://6015897843"
    Shadow.ImageColor3 = Color3.new(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    Shadow.Parent = MainFrame
    
    -- Logo section - better alignment
    LogoContainer.Name = "LogoContainer"
    LogoContainer.BackgroundTransparency = 1
    LogoContainer.Position = UDim2.new(0, 0, 0, 0)
    LogoContainer.Size = UDim2.new(1, 0, 0, 55)
    LogoContainer.Parent = MainFrame
    
    Logo.Name = "Logo"
    Logo.BackgroundTransparency = 1
    Logo.Position = UDim2.new(0, 20, 0, 16)
    Logo.Size = UDim2.new(1, -40, 0, 20)
    Logo.Font = Enum.Font.GothamBold
    Logo.Text = logoText
    Logo.TextColor3 = accentColor
    Logo.TextSize = 18
    Logo.TextXAlignment = Enum.TextXAlignment.Left
    Logo.Parent = LogoContainer
    
    Description.Name = "Description"
    Description.BackgroundTransparency = 1
    Description.Position = UDim2.new(0, 20, 0, 36)
    Description.Size = UDim2.new(1, -40, 0, 16)
    Description.Font = Enum.Font.Gotham
    Description.Text = description
    Description.TextColor3 = Color3.fromRGB(150, 155, 170) -- Secondary text color
    Description.TextSize = 12
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.Parent = LogoContainer
    
    -- Subtle divider line
    TitleDivider.Name = "TitleDivider"
    TitleDivider.BackgroundColor3 = Color3.fromRGB(40, 45, 60) -- Border color
    TitleDivider.BorderSizePixel = 0
    TitleDivider.Position = UDim2.new(0, 20, 0, 57)
    TitleDivider.Size = UDim2.new(1, -40, 0, 1)
    TitleDivider.Parent = MainFrame
    
    -- Player info with avatar - better alignment
    PlayerInfoContainer.Name = "PlayerInfoContainer"
    PlayerInfoContainer.BackgroundTransparency = 1
    PlayerInfoContainer.Position = UDim2.new(0, 20, 0, 70)
    PlayerInfoContainer.Size = UDim2.new(1, -40, 0, 40)
    PlayerInfoContainer.Parent = MainFrame
    
    -- Try to get player avatar
    local player = game:GetService("Players").LocalPlayer
    local userId = player.UserId
    local thumbType = Enum.ThumbnailType.HeadShot
    local thumbSize = Enum.ThumbnailSize.Size150x150
    local avatarUrl = ""
    
    pcall(function()
        avatarUrl = game:GetService("Players"):GetUserThumbnailAsync(userId, thumbType, thumbSize)
    end)
    
    PlayerAvatar.Name = "PlayerAvatar"
    PlayerAvatar.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
    PlayerAvatar.Position = UDim2.new(0, 0, 0, 0)
    PlayerAvatar.Size = UDim2.new(0, 34, 0, 34)
    PlayerAvatar.Image = avatarUrl
    PlayerAvatar.Parent = PlayerInfoContainer
    
    PlayerAvatarCorner.CornerRadius = UDim.new(1, 0)
    PlayerAvatarCorner.Parent = PlayerAvatar
    
    PlayerName.Name = "PlayerName"
    PlayerName.BackgroundTransparency = 1
    PlayerName.Position = UDim2.new(0, 44, 0, 9)
    PlayerName.Size = UDim2.new(1, -44, 0, 16)
    PlayerName.Font = Enum.Font.Gotham
    PlayerName.Text = player.DisplayName or player.Name
    PlayerName.TextColor3 = Color3.fromRGB(210, 210, 220) -- Text color
    PlayerName.TextSize = 14
    PlayerName.TextXAlignment = Enum.TextXAlignment.Left
    PlayerName.Parent = PlayerInfoContainer
    
    -- Buttons container - fixed alignment
    ButtonsContainer.Name = "ButtonsContainer"
    ButtonsContainer.BackgroundTransparency = 1
    ButtonsContainer.Position = UDim2.new(0, 20, 0, 115)
    ButtonsContainer.Size = UDim2.new(1, -40, 0, 36)
    ButtonsContainer.Parent = MainFrame
    
    -- Load Hub button - better spacing and alignment
    LoadHubButton.Name = "LoadHubButton"
    LoadHubButton.BackgroundColor3 = accentColor
    LoadHubButton.Position = UDim2.new(0, 0, 0, 0)
    LoadHubButton.Size = UDim2.new(0.485, 0, 1, 0)
    LoadHubButton.Font = Enum.Font.GothamSemibold
    LoadHubButton.Text = "Load Lomu Hub"
    LoadHubButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadHubButton.TextSize = 13
    LoadHubButton.AutoButtonColor = false
    LoadHubButton.Parent = ButtonsContainer
    
    HubButtonCorner.CornerRadius = UDim.new(0, 5)
    HubButtonCorner.Parent = LoadHubButton
    
    -- Load Universal button - better spacing and alignment
    LoadUniversalButton.Name = "LoadUniversalButton"
    LoadUniversalButton.BackgroundColor3 = Color3.fromRGB(35, 40, 50)
    LoadUniversalButton.Position = UDim2.new(0.515, 0, 0, 0)
    LoadUniversalButton.Size = UDim2.new(0.485, 0, 1, 0)
    LoadUniversalButton.Font = Enum.Font.GothamSemibold
    LoadUniversalButton.Text = "Load Universal"
    LoadUniversalButton.TextColor3 = Color3.fromRGB(210, 210, 220)
    LoadUniversalButton.TextSize = 13
    LoadUniversalButton.AutoButtonColor = false
    LoadUniversalButton.Parent = ButtonsContainer
    
    UniversalButtonCorner.CornerRadius = UDim.new(0, 5)
    UniversalButtonCorner.Parent = LoadUniversalButton
    
    -- Button effects
    LoadHubButton.MouseEnter:Connect(function()
        smoothTween(LoadHubButton, 0.15, {
            BackgroundColor3 = Color3.fromRGB(90, 160, 240), -- Lighter blue
        })
    end)
    
    LoadHubButton.MouseLeave:Connect(function()
        smoothTween(LoadHubButton, 0.15, {
            BackgroundColor3 = accentColor,
        })
    end)
    
    LoadHubButton.MouseButton1Down:Connect(function()
        smoothTween(LoadHubButton, 0.1, {
            Size = UDim2.new(0.48, 0, 0.97, 0),
        })
    end)
    
    LoadHubButton.MouseButton1Up:Connect(function()
        smoothTween(LoadHubButton, 0.1, {
            Size = UDim2.new(0.485, 0, 1, 0),
        })
    end)
    
    LoadHubButton.MouseButton1Click:Connect(function()
        -- Show a loading indicator before closing
        local LoadingFrame = Instance.new("Frame")
        local LoadingCorner = Instance.new("UICorner")
        local LoadingIcon = Instance.new("Frame")
        local LoadingText = Instance.new("TextLabel")
        
        LoadingFrame.Name = "LoadingFrame"
        LoadingFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
        LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        LoadingFrame.Size = UDim2.new(0, 130, 0, 40)
        LoadingFrame.ZIndex = 10
        LoadingFrame.Parent = MainFrame
        
        LoadingCorner.CornerRadius = UDim.new(0, 5)
        LoadingCorner.Parent = LoadingFrame
        
        LoadingText.Name = "LoadingText"
        LoadingText.BackgroundTransparency = 1
        LoadingText.Position = UDim2.new(0, 40, 0, 0)
        LoadingText.Size = UDim2.new(1, -45, 1, 0)
        LoadingText.Font = Enum.Font.GothamSemibold
        LoadingText.Text = "Loading..."
        LoadingText.TextColor3 = Color3.fromRGB(210, 210, 220)
        LoadingText.TextSize = 14
        LoadingText.TextXAlignment = Enum.TextXAlignment.Left
        LoadingText.Parent = LoadingFrame
        
        -- Create loading spinner
        LoadingIcon.Name = "LoadingIcon"
        LoadingIcon.BackgroundTransparency = 1
        LoadingIcon.Position = UDim2.new(0, 18, 0.5, 0)
        LoadingIcon.AnchorPoint = Vector2.new(0.5, 0.5)
        LoadingIcon.Size = UDim2.new(0, 24, 0, 24)
        LoadingIcon.Parent = LoadingFrame
        
        -- Create dots for loading animation
        for i = 1, 3 do
            local dot = Instance.new("Frame")
            dot.Name = "Dot" .. i
            dot.BackgroundColor3 = accentColor
            dot.Size = UDim2.new(0, 5, 0, 5)
            dot.Position = UDim2.new(0.5, -8 + (i-1)*8, 0.5, 0)
            dot.AnchorPoint = Vector2.new(0.5, 0.5)
            dot.Parent = LoadingIcon
            
            local dotCorner = Instance.new("UICorner")
            dotCorner.CornerRadius = UDim.new(1, 0)
            dotCorner.Parent = dot
        end
        
        -- Animate loading dots
        task.spawn(function()
            local dots = {
                LoadingIcon.Dot1,
                LoadingIcon.Dot2,
                LoadingIcon.Dot3
            }
            
            local startTime = tick()
            while LoadingFrame.Parent do
                for i, dot in ipairs(dots) do
                    local offset = (i - 1) * 0.33
                    local scale = 0.7 + 0.6 * math.abs(math.sin((tick() - startTime) * 3 + offset * math.pi * 2))
                    local transparency = 0.3 - 0.3 * math.abs(math.sin((tick() - startTime) * 3 + offset * math.pi * 2))
                    
                    dot.Size = UDim2.new(0, 5 * scale, 0, 5 * scale)
                    dot.BackgroundTransparency = transparency
                end
                task.wait()
            end
        end)
        
        -- Fade in loading indicator
        LoadingFrame.BackgroundTransparency = 1
        LoadingText.TextTransparency = 1
        
        smoothTween(LoadingFrame, 0.2, {
            BackgroundTransparency = 0
        })
        
        smoothTween(LoadingText, 0.2, {
            TextTransparency = 0
        })
        
        -- Wait a moment for loading animation
        task.delay(0.5, function()
            -- Hide start menu with animation
            smoothTween(MainFrame, 0.3, {
                Position = UDim2.new(0.5, 0, 1, 100)
            }, function()
                StartMenu:Destroy()
                buttonCallback()
            end)
        end)
    end)
    
    LoadUniversalButton.MouseEnter:Connect(function()
        smoothTween(LoadUniversalButton, 0.15, {
            BackgroundColor3 = Color3.fromRGB(45, 50, 65),
        })
    end)
    
    LoadUniversalButton.MouseLeave:Connect(function()
        smoothTween(LoadUniversalButton, 0.15, {
            BackgroundColor3 = Color3.fromRGB(35, 40, 50),
        })
    end)
    
    LoadUniversalButton.MouseButton1Down:Connect(function()
        smoothTween(LoadUniversalButton, 0.1, {
            Size = UDim2.new(0.48, 0, 0.97, 0),
        })
    end)
    
    LoadUniversalButton.MouseButton1Up:Connect(function()
        smoothTween(LoadUniversalButton, 0.1, {
            Size = UDim2.new(0.485, 0, 1, 0),
        })
    end)
    
    LoadUniversalButton.MouseButton1Click:Connect(function()
        -- Similar loading indicator for universal
        local LoadingFrame = Instance.new("Frame")
        local LoadingCorner = Instance.new("UICorner")
        local LoadingIcon = Instance.new("Frame")
        local LoadingText = Instance.new("TextLabel")
        
        LoadingFrame.Name = "LoadingFrame"
        LoadingFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
        LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        LoadingFrame.Size = UDim2.new(0, 130, 0, 40)
        LoadingFrame.ZIndex = 10
        LoadingFrame.Parent = MainFrame
        
        LoadingCorner.CornerRadius = UDim.new(0, 5)
        LoadingCorner.Parent = LoadingFrame
        
        LoadingText.Name = "LoadingText"
        LoadingText.BackgroundTransparency = 1
        LoadingText.Position = UDim2.new(0, 40, 0, 0)
        LoadingText.Size = UDim2.new(1, -45, 1, 0)
        LoadingText.Font = Enum.Font.GothamSemibold
        LoadingText.Text = "Loading..."
        LoadingText.TextColor3 = Color3.fromRGB(210, 210, 220)
        LoadingText.TextSize = 14
        LoadingText.TextXAlignment = Enum.TextXAlignment.Left
        LoadingText.Parent = LoadingFrame
        
        -- Create loading spinner
        LoadingIcon.Name = "LoadingIcon"
        LoadingIcon.BackgroundTransparency = 1
        LoadingIcon.Position = UDim2.new(0, 18, 0.5, 0)
        LoadingIcon.AnchorPoint = Vector2.new(0.5, 0.5)
        LoadingIcon.Size = UDim2.new(0, 24, 0, 24)
        LoadingIcon.Parent = LoadingFrame
        
        -- Create dots for loading animation
        for i = 1, 3 do
            local dot = Instance.new("Frame")
            dot.Name = "Dot" .. i
            dot.BackgroundColor3 = accentColor
            dot.Size = UDim2.new(0, 5, 0, 5)
            dot.Position = UDim2.new(0.5, -8 + (i-1)*8, 0.5, 0)
            dot.AnchorPoint = Vector2.new(0.5, 0.5)
            dot.Parent = LoadingIcon
            
            local dotCorner = Instance.new("UICorner")
            dotCorner.CornerRadius = UDim.new(1, 0)
            dotCorner.Parent = dot
        end
        
        -- Animate loading dots
        task.spawn(function()
            local dots = {
                LoadingIcon.Dot1,
                LoadingIcon.Dot2,
                LoadingIcon.Dot3
            }
            
            local startTime = tick()
            while LoadingFrame.Parent do
                for i, dot in ipairs(dots) do
                    local offset = (i - 1) * 0.33
                    local scale = 0.7 + 0.6 * math.abs(math.sin((tick() - startTime) * 3 + offset * math.pi * 2))
                    local transparency = 0.3 - 0.3 * math.abs(math.sin((tick() - startTime) * 3 + offset * math.pi * 2))
                    
                    dot.Size = UDim2.new(0, 5 * scale, 0, 5 * scale)
                    dot.BackgroundTransparency = transparency
                end
                task.wait()
            end
        end)
        
        -- Fade in loading indicator
        LoadingFrame.BackgroundTransparency = 1
        LoadingText.TextTransparency = 1
        
        smoothTween(LoadingFrame, 0.2, {
            BackgroundTransparency = 0
        })
        
        smoothTween(LoadingText, 0.2, {
            TextTransparency = 0
        })
        
        -- Wait a moment for loading animation
        task.delay(0.5, function()
            -- Hide start menu with animation
            smoothTween(MainFrame, 0.3, {
                Position = UDim2.new(0.5, 0, 1, 100)
            }, function()
                StartMenu:Destroy()
                universalButtonCallback()
            end)
        end)
    end)
    
    -- Show with slide-up animation
    smoothTween(MainFrame, 0.3, {
        Position = UDim2.new(0.5, 0, 1, -20)
    })
    
    -- Return the start menu
    return {
        ScreenGui = StartMenu,
        MainFrame = MainFrame,
        ShowNotification = UILibrary.ShowNotification
    }
end

-- Show notification globally
function UILibrary.ShowNotification(message, duration, notificationType)
    duration = duration or 3
    notificationType = notificationType or "Info" -- Info, Success, Warning, Error
    
    -- Create GUI elements
    local ScreenGui = Instance.new("ScreenGui")
    local Notification = Instance.new("Frame")
    local NotificationCorner = Instance.new("UICorner")
    local NotificationBorder = Instance.new("UIStroke")
    local NotificationIcon = Instance.new("Frame")
    local NotificationText = Instance.new("TextLabel")
    
    -- Set up ScreenGui
    ScreenGui.Name = "LomuNotification"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Parent to CoreGui or PlayerGui
    pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    
    if not ScreenGui.Parent then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Create minimalist notification design
    Notification.Name = "Notification"
    Notification.BackgroundColor3 = Color3.fromRGB(15, 17, 26) -- Dark blue-black
    Notification.BackgroundTransparency = 0.1
    Notification.Position = UDim2.new(0.5, 0, 0, -40)
    Notification.AnchorPoint = Vector2.new(0.5, 0)
    Notification.Size = UDim2.new(0, 0, 0, 36)
    Notification.AutomaticSize = Enum.AutomaticSize.X
    Notification.Parent = ScreenGui
    
    NotificationCorner.CornerRadius = UDim.new(0, 6)
    NotificationCorner.Parent = Notification
    
    -- Border color based on type
    local borderColor = Color3.fromRGB(61, 133, 224) -- Default blue
    
    if notificationType == "Success" then
        borderColor = Color3.fromRGB(80, 170, 120) -- Green
    elseif notificationType == "Warning" then
        borderColor = Color3.fromRGB(220, 170, 60) -- Yellow
    elseif notificationType == "Error" then
        borderColor = Color3.fromRGB(200, 80, 80) -- Red
    end
    
    NotificationBorder.Color = borderColor
    NotificationBorder.Thickness = 1
    NotificationBorder.Parent = Notification
    
    -- Loading animation container
    NotificationIcon.Name = "Icon"
    NotificationIcon.BackgroundTransparency = 1
    NotificationIcon.Position = UDim2.new(0, 10, 0.5, 0)
    NotificationIcon.AnchorPoint = Vector2.new(0, 0.5)
    NotificationIcon.Size = UDim2.new(0, 20, 0, 20)
    NotificationIcon.Parent = Notification
    
    -- Create loading dots
    for i = 1, 3 do
        local dot = Instance.new("Frame")
        dot.Name = "Dot" .. i
        dot.BackgroundColor3 = borderColor
        dot.Size = UDim2.new(0, 4, 0, 4)
        dot.Position = UDim2.new(0.5, -6 + (i-1)*6, 0.5, 0)
        dot.AnchorPoint = Vector2.new(0.5, 0.5)
        dot.Parent = NotificationIcon
        
        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(1, 0)
        dotCorner.Parent = dot
    end
    
    -- Animate dots
    task.spawn(function()
        local dots = {
            NotificationIcon.Dot1,
            NotificationIcon.Dot2,
            NotificationIcon.Dot3
        }
        
        local startTime = tick()
        while Notification.Parent do
            for i, dot in ipairs(dots) do
                local offset = (i - 1) * 0.33
                local scale = 0.8 + 0.5 * math.abs(math.sin((tick() - startTime) * 3 + offset * math.pi * 2))
                local transparency = 0.2 - 0.2 * math.abs(math.sin((tick() - startTime) * 3 + offset * math.pi * 2))
                
                dot.Size = UDim2.new(0, 4 * scale, 0, 4 * scale)
                dot.BackgroundTransparency = transparency
            end
            task.wait()
        end
    end)
    
    NotificationText.Name = "NotificationText"
    NotificationText.BackgroundTransparency = 1
    NotificationText.Position = UDim2.new(0, 38, 0, 0)
    NotificationText.Size = UDim2.new(0, 0, 1, 0)
    NotificationText.AutomaticSize = Enum.AutomaticSize.X
    NotificationText.Font = Enum.Font.Gotham
    NotificationText.Text = "  " .. message .. "  " -- Added spacing
    NotificationText.TextColor3 = Color3.fromRGB(210, 210, 220)
    NotificationText.TextSize = 14
    NotificationText.Parent = Notification
    
    -- Add shadow
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, 16, 1, 16)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://6015897843"
    Shadow.ImageColor3 = Color3.new(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    Shadow.Parent = Notification
    
    -- Smooth animation
    Notification.BackgroundTransparency = 1
    NotificationText.TextTransparency = 1
    Shadow.ImageTransparency = 1
    
    -- First make the notification visible
    task.wait(0.05)
    
    -- Then animate its appearance
    local showTween = smoothTween(Notification, 0.3, {
        Position = UDim2.new(0.5, 0, 0, 20),
        BackgroundTransparency = 0.1
    })
    
    smoothTween(NotificationText, 0.3, {
        TextTransparency = 0
    })
    
    smoothTween(Shadow, 0.3, {
        ImageTransparency = 0.5
    })
    
    showTween:Play()
    
    -- Hide after duration with clean animation
    task.delay(duration, function()
        local hideTween = smoothTween(Notification, 0.3, {
            Position = UDim2.new(0.5, 0, 0, -40),
            BackgroundTransparency = 1
        })
        
        smoothTween(NotificationText, 0.3, {
            TextTransparency = 1
        })
        
        smoothTween(Shadow, 0.3, {
            ImageTransparency = 1
        })
        
        hideTween:Play()
        
        -- Clean up after animation is complete
        hideTween.Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end)
end

return UILibrary
