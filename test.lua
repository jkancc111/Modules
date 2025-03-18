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

-- Loading animation function with improved effects
function animateLoading()
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
            
            -- Pulsing effect
            local scale = 0.7 + 0.5 * ((math.sin(angle) + 1) / 2)
            local transparency = 0.3 - 0.3 * ((math.sin(angle) + 1) / 2)
            
            dot.Size = UDim2.new(0, 6 * scale, 0, 6 * scale)
            dot.BackgroundTransparency = transparency
        end
    end)
    
    return connection
end

-- Create a new hub instance with minimalist acrylic design
function UILibrary.new(customConfig)
    local hub = {}
    local userConfig = customConfig or {}
    
    -- Apply custom config if provided
    for key, value in pairs(userConfig) do
        config[key] = value
    end
    
    -- Membuat efek blur untuk background
    local BlurEffect = Instance.new("BlurEffect")
    BlurEffect.Size = 0
    BlurEffect.Parent = game:GetService("Lighting")
    
    -- Main GUI elements
    local ScreenGui = Instance.new("ScreenGui")
    local Background = Instance.new("Frame") -- Background overlay
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
    
    -- Set up ScreenGui
    ScreenGui.Name = "LomuHubLibrary"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 100
    
    -- Background overlay untuk efek blur
    Background.Name = "Background"
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.BackgroundTransparency = 1 -- Start transparent
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.ZIndex = 5
    Background.Parent = ScreenGui
    
    -- Main frame - improved spacing
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = config.MainColor
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Size = UDim2.new(0, 0, 0, 0) -- Start with size 0 for animation
    MainFrame.Visible = true -- Make visible for animation
    MainFrame.ZIndex = 10
    MainFrame.Parent = ScreenGui
    
    -- Add shadow
    local MainShadow = createShadow(MainFrame)
    MainShadow.ImageTransparency = 1 -- Start transparent
    
    MainCorner.CornerRadius = UDim.new(0, 6) -- Increased corner radius
    MainCorner.Parent = MainFrame
    
    MainBorder.Color = config.BorderColor
    MainBorder.Thickness = 1
    MainBorder.Transparency = 1 -- Start transparent
    MainBorder.Parent = MainFrame
    
    -- Top bar with better spacing
    TopBar.Name = "TopBar"
    TopBar.BackgroundTransparency = 1
    TopBar.Size = UDim2.new(1, 0, 0, 40) -- Increased height
    TopBar.ZIndex = 11
    TopBar.Parent = MainFrame
    
    Title.Name = "Title"
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 18, 0, 0) -- Increased left padding
    Title.Size = UDim2.new(1, -70, 1, 0)
    Title.Font = config.HeadingFont
    Title.Text = "Lomu Hub"
    Title.TextColor3 = config.HeadingColor
    Title.TextSize = config.HeadingSize
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextTransparency = 1 -- Start transparent
    Title.ZIndex = 12
    Title.Parent = TopBar
    
    -- Close button with improved visuals
    CloseButton.Name = "CloseButton"
    CloseButton.BackgroundColor3 = Color3.fromRGB(192, 57, 57)
    CloseButton.BackgroundTransparency = 1 -- Start transparent
    CloseButton.Position = UDim2.new(1, -18 - 18, 0.5, 0) -- Adjusted position
    CloseButton.AnchorPoint = Vector2.new(0, 0.5)
    CloseButton.Size = UDim2.new(0, 18, 0, 18)
    CloseButton.Font = config.HeadingFont
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextTransparency = 1 -- Start transparent
    CloseButton.TextSize = 16
    CloseButton.AutoButtonColor = false
    CloseButton.ZIndex = 12
    CloseButton.Parent = TopBar
    
    local CloseButtonCorner = Instance.new("UICorner")
    CloseButtonCorner.CornerRadius = UDim.new(0, 4)
    CloseButtonCorner.Parent = CloseButton
    
    -- Search container with better spacing
    SearchContainer.Name = "SearchContainer"
    SearchContainer.BackgroundTransparency = 1
    SearchContainer.Position = UDim2.new(0, 18, 0, TopBar.Size.Y.Offset + 5) -- Adjusted position
    SearchContainer.Size = UDim2.new(1, -36, 0, 34) -- Increased height
    SearchContainer.ZIndex = 11
    SearchContainer.Parent = MainFrame
    
    -- Search bar with improved design
    SearchBar.Name = "SearchBar"
    SearchBar.BackgroundColor3 = config.SecondaryColor
    SearchBar.BackgroundTransparency = 1 -- Start transparent
    SearchBar.Size = UDim2.new(1, 0, 1, 0)
    SearchBar.ZIndex = 11
    SearchBar.Parent = SearchContainer
    
    SearchBorder.Color = config.BorderColor
    SearchBorder.Thickness = 1
    SearchBorder.Transparency = 1 -- Start transparent
    SearchBorder.Parent = SearchBar
    
    local SearchBarCorner = Instance.new("UICorner")
    SearchBarCorner.CornerRadius = UDim.new(0, 5) -- Increased corner radius
    SearchBarCorner.Parent = SearchBar
    
    SearchIcon.Name = "SearchIcon"
    SearchIcon.BackgroundTransparency = 1
    SearchIcon.Position = UDim2.new(0, 12, 0.5, 0) -- Increased left padding
    SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
    SearchIcon.Size = UDim2.new(0, 14, 0, 14)
    SearchIcon.Image = "rbxassetid://3926305904"
    SearchIcon.ImageRectOffset = Vector2.new(964, 324)
    SearchIcon.ImageRectSize = Vector2.new(36, 36)
    SearchIcon.ImageColor3 = config.SecondaryTextColor
    SearchIcon.ImageTransparency = 1 -- Start transparent
    SearchIcon.ZIndex = 12
    SearchIcon.Parent = SearchBar
    
    SearchInput.Name = "SearchInput"
    SearchInput.BackgroundTransparency = 1
    SearchInput.Position = UDim2.new(0, 34, 0, 0) -- Increased left padding
    SearchInput.Size = UDim2.new(1, -40, 1, 0)
    SearchInput.Font = config.BodyFont
    SearchInput.PlaceholderText = "Search games..."
    SearchInput.Text = ""
    SearchInput.TextColor3 = config.TextColor
    SearchInput.PlaceholderColor3 = Color3.fromRGB(100, 110, 130)
    SearchInput.TextSize = 14 -- Increased text size
    SearchInput.TextXAlignment = Enum.TextXAlignment.Left
    SearchInput.ClearTextOnFocus = false
    SearchInput.TextTransparency = 1 -- Start transparent
    SearchInput.ZIndex = 12
    SearchInput.Parent = SearchBar
    
    -- Category container with better spacing
    CategoryContainer.Name = "CategoryContainer"
    CategoryContainer.BackgroundTransparency = 1
    CategoryContainer.Position = UDim2.new(0, 18, 0, SearchContainer.Position.Y.Offset + SearchContainer.Size.Y.Offset + 10) -- Increased spacing
    CategoryContainer.Size = UDim2.new(1, -36, 0, 30) -- Increased height
    CategoryContainer.ZIndex = 11
    CategoryContainer.Parent = MainFrame
    
    CategoryLayout.Name = "CategoryLayout"
    CategoryLayout.FillDirection = Enum.FillDirection.Horizontal
    CategoryLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    CategoryLayout.SortOrder = Enum.SortOrder.LayoutOrder
    CategoryLayout.Padding = UDim.new(0, 10) -- Increased padding
    CategoryLayout.Parent = CategoryContainer
    
    -- Game list with better spacing
    GameList.Name = "GameList"
    GameList.BackgroundTransparency = 1
    GameList.Position = UDim2.new(0, 18, 0, CategoryContainer.Position.Y.Offset + CategoryContainer.Size.Y.Offset + 10) -- Increased spacing
    GameList.Size = UDim2.new(1, -36, 1, -(CategoryContainer.Position.Y.Offset + CategoryContainer.Size.Y.Offset + 28)) -- Adjusted height
    GameList.CanvasSize = UDim2.new(0, 0, 0, 0)
    GameList.ScrollBarThickness = 4
    GameList.ScrollBarImageColor3 = config.AccentColor
    GameList.ScrollingDirection = Enum.ScrollingDirection.Y
    GameList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    GameList.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    GameList.ZIndex = 11
    GameList.Parent = MainFrame
    
    GameListLayout.Name = "GameListLayout"
    GameListLayout.Padding = UDim.new(0, 8) -- Increased spacing between games
    GameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    GameListLayout.Parent = GameList
    
    GameListPadding.PaddingTop = UDim.new(0, 4)
    GameListPadding.PaddingBottom = UDim.new(0, 10) -- Increased bottom padding
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
    EmptyStateLabel.TextSize = 14 -- Increased text size
    EmptyStateLabel.TextWrapped = true
    EmptyStateLabel.Visible = false
    EmptyStateLabel.TextTransparency = 1 -- Start transparent
    EmptyStateLabel.ZIndex = 12
    EmptyStateLabel.Parent = GameList
    
    -- Loading Indicator - improved design
    LoadingIndicator.Name = "LoadingIndicator"
    LoadingIndicator.BackgroundTransparency = 1
    LoadingIndicator.Position = UDim2.new(0.5, 0, 0.5, 0)
    LoadingIndicator.AnchorPoint = Vector2.new(0.5, 0.5)
    LoadingIndicator.Size = UDim2.new(0, 40, 0, 40)
    LoadingIndicator.Visible = false
    LoadingIndicator.ZIndex = 12
    LoadingIndicator.Parent = MainFrame
    
    -- Create loading dots
    for i = 1, 3 do
        local dot = Instance.new("Frame")
        dot.Name = "LoadingDot" .. i
        dot.BackgroundColor3 = config.AccentColor
        dot.Position = UDim2.new(0.5, 0, 0.5, 0)
        dot.AnchorPoint = Vector2.new(0.5, 0.5)
        dot.Size = UDim2.new(0, 6, 0, 6)
        dot.ZIndex = 13
        dot.Parent = LoadingIndicator
        
        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(1, 0)
        dotCorner.Parent = dot
    end
    
    -- Parent the ScreenGui
    pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    
    if not ScreenGui.Parent then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
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
        CategoryButton.BackgroundTransparency = 1 -- Start transparent
        CategoryButton.Size = UDim2.new(0, 0, 1, 0)
        CategoryButton.AutomaticSize = Enum.AutomaticSize.X
        CategoryButton.Font = config.BodyFont
        CategoryButton.Text = " " .. catName .. " "
        CategoryButton.TextColor3 = config.TextColor
        CategoryButton.TextSize = config.BodyTextSize
        CategoryButton.TextTransparency = 1 -- Start transparent
        CategoryButton.AutoButtonColor = false -- Custom hover effects
        CategoryButton.ZIndex = 12
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
        -- Animate the close process with fancy effect
        -- First fade the blur
        smoothTween(BlurEffect, 0.3, {
            Size = 0
        })
        
        -- Fade the background
        smoothTween(Background, 0.3, {
            BackgroundTransparency = 1
        })
        
        -- Fade out content first
        for _, child in pairs(MainFrame:GetChildren()) do
            if child:IsA("GuiObject") and child ~= MainFrame and child.Name ~= "Shadow" then
                if child.ClassName == "TextLabel" or child.ClassName == "TextButton" or child.ClassName == "TextBox" then
                    smoothTween(child, 0.2, {
                        TextTransparency = 1
                    })
                end
                
                if child.BackgroundTransparency < 1 then
                    smoothTween(child, 0.2, {
                        BackgroundTransparency = 1
                    })
                end
            end
        end
        
        -- Then collapse the frame with a cool effect
        task.delay(0.2, function()
            -- Create a tween with a bounce-in-reverse effect
            local closeTween = game:GetService("TweenService"):Create(
                MainFrame,
                TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {
                    Size = UDim2.new(0, 0, 0, 0),
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                }
            )
            
            smoothTween(MainShadow, 0.3, {
                ImageTransparency = 1
            })
            
            closeTween:Play()
            
            closeTween.Completed:Connect(function()
                -- Clean up
                if BlurEffect and BlurEffect.Parent then
                    BlurEffect:Destroy()
                end
                ScreenGui:Destroy()
            end)
        end)
    end)
    
    -- Add game function remains similar with adjusted CSS values
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
        GameItem.BackgroundTransparency = 1 -- Start transparent untuk animasi masuk
        GameItem.Size = UDim2.new(1, 0, 0, config.GameItemHeight)
        GameItem.ClipsDescendants = true
        GameItem.Parent = GameList
        GameItem:SetAttribute("Category", gameCategory)
        GameItem.ZIndex = 12
        
        GameCorner.CornerRadius = config.CornerRadius
        GameCorner.Parent = GameItem
        
        GameBorder.Color = config.BorderColor
        GameBorder.Thickness = 1
        GameBorder.Transparency = 1 -- Start transparent
        GameBorder.Parent = GameItem
        
        -- Inner container for animation effects
        GameItemInner.Name = "Inner"
        GameItemInner.BackgroundTransparency = 1
        GameItemInner.Size = UDim2.new(1, 0, 1, 0)
        GameItemInner.Position = UDim2.new(0, 0, 0, 0)
        GameItemInner.ZIndex = 13
        GameItemInner.Parent = GameItem
        
        -- Thumbnail with improved spacing
        Thumbnail.Name = "Thumbnail"
        Thumbnail.BackgroundColor3 = Color3.fromRGB(15, 18, 25)
        Thumbnail.Position = UDim2.new(0, 12, 0.5, 0) -- Increased spacing
        Thumbnail.AnchorPoint = Vector2.new(0, 0.5)
        Thumbnail.Size = UDim2.new(0, 45, 0, 45)
        Thumbnail.Image = gameThumbnail
        Thumbnail.ImageTransparency = 1 -- Start transparent
        Thumbnail.ZIndex = 14
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
        GameName.TextTransparency = 1 -- Start transparent
        GameName.ZIndex = 14
        GameName.Parent = GameItemInner
        
        -- Status indicator - better spacing
        local statusColor = config.StatusColors[gameStatus] or Color3.fromRGB(150, 150, 150)
        
        StatusIndicator.Name = "StatusIndicator"
        StatusIndicator.BackgroundColor3 = statusColor
        StatusIndicator.BackgroundTransparency = 1 -- Start transparent
        StatusIndicator.Position = UDim2.new(0, 68, 0, GameName.Position.Y.Offset + GameName.Size.Y.Offset + 7)
        StatusIndicator.Size = UDim2.new(0, 6, 0, 6)
        StatusIndicator.ZIndex = 14
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
        StatusLabel.TextTransparency = 1 -- Start transparent
        StatusLabel.ZIndex = 14
        StatusLabel.Parent = GameItemInner
        
        -- Play button - better spacing
        PlayButton.Name = "PlayButton"
        PlayButton.BackgroundColor3 = config.AccentColor
        PlayButton.BackgroundTransparency = 1 -- Start transparent
        PlayButton.Position = UDim2.new(1, -70, 0.5, 0) -- Increased spacing
        PlayButton.AnchorPoint = Vector2.new(0, 0.5)
        PlayButton.Size = UDim2.new(0, 58, 0, 30)
        PlayButton.AutoButtonColor = false
        PlayButton.Font = config.ButtonFont
        PlayButton.Text = "PLAY"
        PlayButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        PlayButton.TextSize = 13
        PlayButton.TextTransparency = 1 -- Start transparent
        PlayButton.ZIndex = 14
        PlayButton.Parent = GameItemInner
        
        PlayButtonCorner.CornerRadius = UDim.new(0, 5)
        PlayButtonCorner.Parent = PlayButton
        
        -- Add shadow
        local playShadow = createShadow(PlayButton, 0.8)
        playShadow.ImageTransparency = 1 -- Start transparent
        
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
            loadingContainer.ZIndex = 20
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
                dot.ZIndex = 21
                
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
        
        -- Delayed animation for game item appearance
        task.delay(0.1 + math.random() * 0.3, function() -- Random delay for staggered effect
            -- Fade in the item with slide effect
            GameItem.Position = UDim2.new(0.05, 0, 0, GameItem.Position.Y.Offset)
            
            -- Animate all elements
            smoothTween(GameItem, 0.4, {
                BackgroundTransparency = config.ElementTransparency,
                Position = UDim2.new(0, 0, 0, GameItem.Position.Y.Offset)
            })
            
            smoothTween(GameBorder, 0.4, {
                Transparency = 0
            })
            
            smoothTween(Thumbnail, 0.4, {
                ImageTransparency = 0
            })
            
            smoothTween(GameName, 0.4, {
                TextTransparency = 0
            })
            
            smoothTween(StatusIndicator, 0.4, {
                BackgroundTransparency = 0
            })
            
            smoothTween(StatusLabel, 0.4, {
                TextTransparency = 0
            })
            
            smoothTween(PlayButton, 0.4, {
                BackgroundTransparency = 0,
                TextTransparency = 0
            })
            
            smoothTween(playShadow, 0.5, {
                ImageTransparency = 0.2
            })
        end)
        
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
        CategoryButton.BackgroundTransparency = 1 -- Start transparent
        CategoryButton.Size = UDim2.new(0, 0, 1, 0)
        CategoryButton.AutomaticSize = Enum.AutomaticSize.X
        CategoryButton.Font = config.BodyFont
        CategoryButton.Text = " " .. categoryName .. " "
        CategoryButton.TextColor3 = config.TextColor
        CategoryButton.TextSize = config.BodyTextSize
        CategoryButton.TextTransparency = 1 -- Start transparent
        CategoryButton.AutoButtonColor = false -- Custom hover effects
        CategoryButton.ZIndex = 12
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
                                    
                                    -- Animate all child elements
                                    for _, element in pairs(child:GetDescendants()) do
                                        if element:IsA("TextLabel") or element:IsA("TextButton") then
                                            element.TextTransparency = 1
                                            smoothTween(element, 0.3, {
                                                TextTransparency = 0
                                            })
                                        elseif element:IsA("ImageLabel") then
                                            element.ImageTransparency = 1
                                            smoothTween(element, 0.3, {
                                                ImageTransparency = 0
                                            })
                                        elseif element:IsA("Frame") and element.Name ~= "Shadow" then
                                            if element.BackgroundTransparency < 1 then
                                                local originalTransparency = element.BackgroundTransparency
                                                element.BackgroundTransparency = 1
                                                smoothTween(element, 0.3, {
                                                    BackgroundTransparency = originalTransparency
                                                })
                                            end
                                        end
                                    end
                                    
                                    smoothTween(child, 0.3, {
                                        BackgroundTransparency = config.ElementTransparency,
                                        Position = UDim2.new(0, 0, 0, child.Position.Y.Offset)
                                    })
                                end)
                            end
                        else
                            if child.Visible then
                                -- Animate fade out
                                for _, element in pairs(child:GetDescendants()) do
                                    if element:IsA("TextLabel") or element:IsA("TextButton") then
                                        smoothTween(element, 0.2, {
                                            TextTransparency = 1
                                        })
                                    elseif element:IsA("ImageLabel") then
                                        smoothTween(element, 0.2, {
                                            ImageTransparency = 1
                                        })
                                    elseif element:IsA("Frame") and element.Name ~= "Shadow" then
                                        if element.BackgroundTransparency < 1 then
                                            smoothTween(element, 0.2, {
                                                BackgroundTransparency = 1
                                            })
                                        end
                                    end
                                end
                                
                                smoothTween(child, 0.2, {
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
                if EmptyStateLabel.Visible then
                    EmptyStateLabel.TextTransparency = 1
                    smoothTween(EmptyStateLabel, 0.3, {
                        TextTransparency = 0
                    })
                end
                
                -- Hide loading after filtering
                task.delay(0.3, function()
                    LoadingIndicator.Visible = false
                end)
            end
        end)
        
        -- Animate appearance
        task.delay(0.1, function()
            smoothTween(CategoryButton, 0.4, {
                BackgroundTransparency = (categoryName == selectedCategory) and 0 or config.ElementTransparency,
                TextTransparency = 0
            })
        end)
        
        table.insert(categoryButtons, CategoryButton)
        return CategoryButton
    end
    
    -- Set title with animation
    function hub:SetTitle(titleText)
        local oldText = Title.Text
        
        -- Animate fade out
        smoothTween(Title, 0.2, {
            TextTransparency = 1
        }, function()
            Title.Text = titleText
            
            -- Animate fade in
            smoothTween(Title, 0.2, {
                TextTransparency = 0
            })
        end)
    end
    
    -- Improved notification system with animations
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
        notification.ZIndex = 100
        notification.Parent = ScreenGui
        
        -- Add shadow for depth
        local notifShadow = createShadow(notification, 0.8)
        notifShadow.ImageTransparency = 1 -- Start transparent
        
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
        notificationIcon.ImageTransparency = 1 -- Start transparent
        notificationIcon.ZIndex = 101
        
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
        notificationText.TextTransparency = 1 -- Start transparent
        notificationText.ZIndex = 101
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
        closeButton.TextTransparency = 1 -- Start transparent
        closeButton.TextSize = 18
        closeButton.ZIndex = 101
        closeButton.Parent = notification
        
        -- Show notification with entrance animation
        local function showNotification()
            notification.Size = UDim2.new(0, notificationText.TextBounds.X + 60, 0, 36)
            notification.BackgroundTransparency = 1
            
            -- Scale up animation with bounce effect
            local sizeTween = game:GetService("TweenService"):Create(
                notification,
                TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {
                    Position = UDim2.new(0.5, 0, 0, 15),
                    BackgroundTransparency = 0.1
                }
            )
            sizeTween:Play()
            
            -- Fade in other elements
            smoothTween(notifShadow, 0.4, {
                ImageTransparency = 0.5
            })
            
            smoothTween(notificationIcon, 0.3, {
                ImageTransparency = 0
            })
            
            smoothTween(notificationText, 0.3, {
                TextTransparency = 0
            })
            
            smoothTween(closeButton, 0.3, {
                TextTransparency = 0
            })
        end
        
        -- Hide notification with exit animation
        function dismissNotification()
            -- Scale down animation with bounce effect
            local hideTween = game:GetService("TweenService"):Create(
                notification,
                TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {
                    Position = UDim2.new(0.5, 0, 0, -40),
                    BackgroundTransparency = 1
                }
            )
            hideTween:Play()
            
            -- Fade out other elements
            smoothTween(notifShadow, 0.3, {
                ImageTransparency = 1
            })
            
            smoothTween(notificationIcon, 0.2, {
                ImageTransparency = 1
            })
            
            smoothTween(notificationText, 0.2, {
                TextTransparency = 1
            })
            
            smoothTween(closeButton, 0.2, {
                TextTransparency = 1
            })
            
            -- Clean up after animation is complete
            hideTween.Completed:Connect(function()
                notification:Destroy()
            end)
        end
        
        -- Close button click
        closeButton.MouseButton1Click:Connect(function()
            dismissNotification()
        end)
        
        -- Close button hover effect
        closeButton.MouseEnter:Connect(function()
            smoothTween(closeButton, 0.1, {
                TextColor3 = Color3.fromRGB(255, 255, 255)
            })
        end)
        
        closeButton.MouseLeave:Connect(function()
            smoothTween(closeButton, 0.1, {
                TextColor3 = config.SecondaryTextColor
            })
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
    
    -- Perform the opening animation sequence
    -- First apply blur effect
    smoothTween(BlurEffect, 0.3, {
        Size = 10
    })
    
    -- Fade in the background
    smoothTween(Background, 0.3, {
        BackgroundTransparency = 0.4
    })
    
    -- Then expand the main frame with a bounce effect
    task.delay(0.1, function()
        local sizeTween = game:GetService("TweenService"):Create(
            MainFrame,
            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, config.Width, 0, config.Height)}
        )
        sizeTween:Play()
        
        -- Fade in border and shadow
        smoothTween(MainBorder, 0.5, {
            Transparency = 0
        })
        
        smoothTween(MainShadow, 0.5, {
            ImageTransparency = 0.5
        })
        
        -- Fade in UI elements with staggered delay
        task.delay(0.2, function()
            -- Title bar elements
            smoothTween(Title, 0.3, {
                TextTransparency = 0
            })
            
            smoothTween(CloseButton, 0.3, {
                TextTransparency = 0,
                BackgroundTransparency = 0
            })
            
            -- Search bar elements
            task.delay(0.05, function()
                smoothTween(SearchBar, 0.3, {
                    BackgroundTransparency = config.ElementTransparency
                })
                
                smoothTween(SearchBorder, 0.3, {
                    Transparency = 0
                })
                
                smoothTween(SearchIcon, 0.3, {
                    ImageTransparency = 0
                })
                
                smoothTween(SearchInput, 0.3, {
                    TextTransparency = 0
                })
            end)
            
            -- Category buttons
            task.delay(0.1, function()
                for i, button in ipairs(categoryButtons) do
                    task.delay((i-1) * 0.05, function()
                        smoothTween(button, 0.3, {
                            BackgroundTransparency = (button.Name == "Category_" .. selectedCategory) and 0 or config.ElementTransparency,
                            TextTransparency = 0
                        })
                    end)
                end
            end)
        end)
    end)
    
    -- Return the hub object with all our methods
    hub.AddGame = hub.AddGame
    hub.AddCategory = hub.AddCategory
    hub.SetTitle = hub.SetTitle
    hub.ShowNotification = hub.ShowNotification
    
    return hub
end

-- Implementation example to show how to use the library with animations
function UILibrary.ShowExample()
    -- Create a hub with default blue-black acrylic theme
    local myHub = UILibrary.CreateHub()
    
    -- Add some categories
    myHub:AddCategory("Combat")
    myHub:AddCategory("Movement")
    myHub:AddCategory("Visual")
    myHub:AddCategory("Utility")
    
    -- Add some example games
    myHub:AddGame({
        Name = "Aimbot",
        LastUpdate = "Today",
        Status = "Working",
        Category = "Combat",
        Callback = function()
            myHub:ShowNotification("Loading Aimbot script...", 2, "Info")
            task.wait(1)
            myHub:ShowNotification("Aimbot loaded successfully!", 3, "Success")
        end
    })
    
    myHub:AddGame({
        Name = "ESP",
        LastUpdate = "Yesterday",
        Status = "Updated",
        Category = "Visual",
        Callback = function()
            myHub:ShowNotification("Loading ESP script...", 2, "Info")
            task.wait(1.5)
            myHub:ShowNotification("ESP loaded successfully!", 3, "Success")
        end
    })
    
    myHub:AddGame({
        Name = "Speed Hack",
        LastUpdate = "2 days ago",
        Status = "Testing",
        Category = "Movement",
        Callback = function()
            myHub:ShowNotification("Loading Speed Hack script...", 2, "Info")
            task.wait(1)
            myHub:ShowNotification("Speed Hack is still being tested!", 3, "Warning")
        end
    })
    
    myHub:AddGame({
        Name = "Auto Farm",
        LastUpdate = "1 week ago",
        Status = "Patched",
        Category = "Utility",
        Callback = function()
            myHub:ShowNotification("This script has been patched!", 3, "Error")
        end
    })
    
    -- Show a welcome notification after everything is loaded
    task.delay(0.8, function()
        myHub:ShowNotification("Welcome to Lomu Hub!", 3, "Success")
    end)
    
    return myHub
end

-- Function to create Start Menu with Animation
function UILibrary:CreateStartMenu(options)
    local startMenu = {}
    options = options or {}
    
    -- Default options
    local logoText = options.LogoText or "Lomu Hub"
    local description = options.Description or "Powerful script hub for all your needs"
    local accentColor = options.AccentColor or config.AccentColor
    local buttonCallback = options.ButtonCallback or function() end
    local universalCallback = options.UniversalButtonCallback or function() end
    local customPlayerName = options.CustomPlayerName
    
    -- Efek blur untuk background
    local BlurEffect = Instance.new("BlurEffect")
    BlurEffect.Size = 0
    BlurEffect.Parent = game:GetService("Lighting")
    
    -- Create start menu GUI
    local ScreenGui = Instance.new("ScreenGui")
    local Background = Instance.new("Frame")
    local MainFrame = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local MainBorder = Instance.new("UIStroke")
    local Logo = Instance.new("TextLabel")
    local Description = Instance.new("TextLabel")
    local LoadButton = Instance.new("TextButton")
    local LoadButtonCorner = Instance.new("UICorner")
    local UniversalButton = Instance.new("TextButton")
    local UniversalButtonCorner = Instance.new("UICorner")
    local PlayerInfo = Instance.new("Frame")
    local PlayerAvatar = Instance.new("ImageLabel")
    local PlayerAvatarCorner = Instance.new("UICorner")
    local PlayerName = Instance.new("TextLabel")
    
    -- Set up ScreenGui
    ScreenGui.Name = "LomuStartMenu"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.DisplayOrder = 100
    
    -- Background overlay for blur effect
    Background.Name = "Background"
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.BackgroundTransparency = 1 -- Start transparent for animation
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.ZIndex = 5
    Background.Parent = ScreenGui
    
    -- Main frame
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = config.MainColor
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Size = UDim2.new(0, 0, 0, 0) -- Start with size 0 for animation
    MainFrame.ZIndex = 10
    MainFrame.Parent = ScreenGui
    
    -- Add shadow
    local MainShadow = createShadow(MainFrame)
    MainShadow.ImageTransparency = 1 -- Start transparent for animation
    
    MainCorner.CornerRadius = UDim.new(0, 6)
    MainCorner.Parent = MainFrame
    
    MainBorder.Color = config.BorderColor
    MainBorder.Thickness = 1
    MainBorder.Transparency = 1 -- Start transparent for animation
    MainBorder.Parent = MainFrame
    
    -- Logo text
    Logo.Name = "Logo"
    Logo.BackgroundTransparency = 1
    Logo.Position = UDim2.new(0, 0, 0.2, 0)
    Logo.Size = UDim2.new(1, 0, 0, 40)
    Logo.Font = config.HeadingFont
    Logo.Text = logoText
    Logo.TextColor3 = accentColor
    Logo.TextSize = 28
    Logo.TextTransparency = 1 -- Start transparent for animation
    Logo.ZIndex = 11
    Logo.Parent = MainFrame
    
    -- Description text
    Description.Name = "Description"
    Description.BackgroundTransparency = 1
    Description.Position = UDim2.new(0, 0, 0.2, 45)
    Description.Size = UDim2.new(1, 0, 0, 20)
    Description.Font = config.BodyFont
    Description.Text = description
    Description.TextColor3 = config.SecondaryTextColor
    Description.TextSize = 14
    Description.TextTransparency = 1 -- Start transparent for animation
    Description.ZIndex = 11
    Description.Parent = MainFrame
    
    -- Load Hub button
    LoadButton.Name = "LoadButton"
    LoadButton.BackgroundColor3 = accentColor
    LoadButton.Position = UDim2.new(0.5, -75, 0.65, 0)
    LoadButton.Size = UDim2.new(0, 150, 0, 36)
    LoadButton.Font = config.ButtonFont
    LoadButton.Text = "Load Hub"
    LoadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadButton.TextSize = 16
    LoadButton.AutoButtonColor = false
    LoadButton.BackgroundTransparency = 1 -- Start transparent for animation
    LoadButton.TextTransparency = 1 -- Start transparent for animation
    LoadButton.ZIndex = 11
    LoadButton.Parent = MainFrame
    
    LoadButtonCorner.CornerRadius = UDim.new(0, 5)
    LoadButtonCorner.Parent = LoadButton
    
    -- Universal script button
    UniversalButton.Name = "UniversalButton"
    UniversalButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    UniversalButton.Position = UDim2.new(0.5, -75, 0.65, 45)
    UniversalButton.Size = UDim2.new(0, 150, 0, 36)
    UniversalButton.Font = config.ButtonFont
    UniversalButton.Text = "Universal"
    UniversalButton.TextColor3 = Color3.fromRGB(220, 220, 230)
    UniversalButton.TextSize = 16
    UniversalButton.AutoButtonColor = false
    UniversalButton.BackgroundTransparency = 1 -- Start transparent for animation
    UniversalButton.TextTransparency = 1 -- Start transparent for animation
    UniversalButton.ZIndex = 11
    UniversalButton.Parent = MainFrame
    
    UniversalButtonCorner.CornerRadius = UDim.new(0, 5)
    UniversalButtonCorner.Parent = UniversalButton
    
    -- Player info section
    PlayerInfo.Name = "PlayerInfo"
    PlayerInfo.BackgroundTransparency = 1
    PlayerInfo.Position = UDim2.new(0, 0, 0.85, 10)
    PlayerInfo.Size = UDim2.new(1, 0, 0, 50)
    PlayerInfo.ZIndex = 11
    PlayerInfo.Parent = MainFrame
    
    PlayerAvatar.Name = "PlayerAvatar"
    PlayerAvatar.BackgroundTransparency = 0.5
    PlayerAvatar.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
    PlayerAvatar.Position = UDim2.new(0.5, -100, 0, 0)
    PlayerAvatar.Size = UDim2.new(0, 40, 0, 40)
    PlayerAvatar.ImageTransparency = 1 -- Start transparent for animation
    PlayerAvatar.ZIndex = 12
    PlayerAvatar.Parent = PlayerInfo
    
    PlayerAvatarCorner.CornerRadius = UDim.new(1, 0)
    PlayerAvatarCorner.Parent = PlayerAvatar
    
    PlayerName.Name = "PlayerName"
    PlayerName.BackgroundTransparency = 1
    PlayerName.Position = UDim2.new(0.5, -50, 0, 0)
    PlayerName.Size = UDim2.new(0, 200, 0, 40)
    PlayerName.Font = config.Font
    PlayerName.TextColor3 = config.TextColor
    PlayerName.TextSize = 14
    PlayerName.TextXAlignment = Enum.TextXAlignment.Left
    PlayerName.TextTransparency = 1 -- Start transparent for animation
    PlayerName.ZIndex = 12
    PlayerName.Parent = PlayerInfo
    
    -- Get player info
    local player = game:GetService("Players").LocalPlayer
    
    -- Try to get player's avatar
    pcall(function()
        local userId = player.UserId
        PlayerAvatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"
    end)
    
    -- Set player name (or custom name if provided)
    PlayerName.Text = customPlayerName or player.Name
    
    -- Parent the ScreenGui
    pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    
    if not ScreenGui.Parent then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Button hover/click effects
    LoadButton.MouseEnter:Connect(function()
        smoothTween(LoadButton, 0.3, {
            BackgroundColor3 = config.AccentColorHover,
            Size = UDim2.new(0, 155, 0, 38)
        })
    end)
    
    LoadButton.MouseLeave:Connect(function()
        smoothTween(LoadButton, 0.3, {
            BackgroundColor3 = accentColor,
            Size = UDim2.new(0, 150, 0, 36)
        })
    end)
    
    UniversalButton.MouseEnter:Connect(function()
        smoothTween(UniversalButton, 0.3, {
            BackgroundColor3 = Color3.fromRGB(70, 70, 85),
            Size = UDim2.new(0, 155, 0, 38)
        })
    end)
    
    UniversalButton.MouseLeave:Connect(function()
        smoothTween(UniversalButton, 0.3, {
            BackgroundColor3 = Color3.fromRGB(60, 60, 70),
            Size = UDim2.new(0, 150, 0, 36)
        })
    end)
    
    -- Button click effects and callbacks
    LoadButton.MouseButton1Click:Connect(function()
        -- Visual feedback
        smoothTween(LoadButton, 0.1, {
            Size = UDim2.new(0, 145, 0, 34),
            BackgroundColor3 = config.AccentColorActive
        })
        
        task.delay(0.1, function()
            smoothTween(LoadButton, 0.1, {
                Size = UDim2.new(0, 150, 0, 36),
                BackgroundColor3 = accentColor
            })
        end)
        
        -- Animate closing of start menu but keep blur
        -- Fade out content first
        for _, child in pairs(MainFrame:GetChildren()) do
            if child:IsA("GuiObject") and child ~= MainFrame and child.Name ~= "Shadow" then
                if child.ClassName == "TextLabel" or child.ClassName == "TextButton" or child.ClassName == "TextBox" then
                    smoothTween(child, 0.4, {
                        TextTransparency = 1
                    })
                elseif child.ClassName == "ImageLabel" then
                    smoothTween(child, 0.4, {
                        ImageTransparency = 1
                    })
                end
                
                if child.BackgroundTransparency < 1 then
                    smoothTween(child, 0.4, {
                        BackgroundTransparency = 1
                    })
                end
            end
        end
        
        -- Keep the blur effect for the game hub
        -- Don't fade the background yet either
        
        -- Then collapse the frame with a cool effect
        task.delay(0.4, function()
            -- Create a tween with a bounce-in-reverse effect
            local closeTween = game:GetService("TweenService"):Create(
                MainFrame,
                TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.In),
                {
                    Size = UDim2.new(0, 0, 0, 0),
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                }
            )
            
            smoothTween(MainShadow, 0.6, {
                ImageTransparency = 1
            })
            
            closeTween:Play()
            
            closeTween.Completed:Connect(function()
                -- Execute callback but keep blur and background
                buttonCallback(BlurEffect, Background)
                -- Don't destroy ScreenGui or background yet
                -- They'll be reused by the main hub
            end)
        end)
    end)
    
    UniversalButton.MouseButton1Click:Connect(function()
        -- Visual feedback
        smoothTween(UniversalButton, 0.1, {
            Size = UDim2.new(0, 145, 0, 34),
            BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        })
        
        task.delay(0.1, function()
            smoothTween(UniversalButton, 0.1, {
                Size = UDim2.new(0, 150, 0, 36),
                BackgroundColor3 = Color3.fromRGB(60, 60, 70)
            })
        end)
        
        -- Execute universal callback
        universalCallback()
    end)
    
    -- Perform the opening animation sequence
    -- First apply blur effect
    smoothTween(BlurEffect, 0.6, {
        Size = 10
    })
    
    -- Fade in the background
    smoothTween(Background, 0.6, {
        BackgroundTransparency = 0.4
    })
    
    -- Then expand the main frame with a bounce effect
    task.delay(0.2, function()
        -- Calculate final size based on contents
        MainFrame.Size = UDim2.new(0, 320, 0, 360)
        
        local sizeTween = game:GetService("TweenService"):Create(
            MainFrame,
            TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 320, 0, 360)}
        )
        sizeTween:Play()
        
        -- Fade in border and shadow
        smoothTween(MainBorder, 0.8, {
            Transparency = 0
        })
        
        smoothTween(MainShadow, 0.8, {
            ImageTransparency = 0.5
        })
        
        -- Fade in UI elements with staggered delay
        task.delay(0.3, function()
            -- Logo elements
            smoothTween(Logo, 0.5, {
                TextTransparency = 0
            })
            
            task.delay(0.1, function()
                smoothTween(Description, 0.5, {
                    TextTransparency = 0
                })
            end)
            
            -- Buttons
            task.delay(0.2, function()
                smoothTween(LoadButton, 0.5, {
                    BackgroundTransparency = 0,
                    TextTransparency = 0
                })
                
                task.delay(0.1, function()
                    smoothTween(UniversalButton, 0.5, {
                        BackgroundTransparency = 0.2,
                        TextTransparency = 0
                    })
                end)
            end)
            
            -- Player info
            task.delay(0.3, function()
                smoothTween(PlayerAvatar, 0.5, {
                    BackgroundTransparency = 0.2,
                    ImageTransparency = 0
                })
                
                smoothTween(PlayerName, 0.5, {
                    TextTransparency = 0
                })
            end)
        end)
    end)
    
    return startMenu
end

-- Function to create hub from start menu (compatible with both methods)
function UILibrary.CreateHub(customConfig)
    -- Just call UILibrary.new with the custom config
    return UILibrary.new(customConfig)
end

return UILibrary
