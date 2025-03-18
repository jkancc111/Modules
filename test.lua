local UILibrary = {}

-- Enhanced Theme Configuration based on Lomu Hub Theme with improved design principles
local config = {
    -- Core colors with variants for interactions
    MainColor = Color3.fromRGB(20, 20, 20),          -- AcrylicMain
    SecondaryColor = Color3.fromRGB(40, 40, 40),     -- Secondary elements
    AccentColor = Color3.fromRGB(251, 165, 24),      -- Accent (#FBA518)
    AccentColorHover = Color3.fromRGB(255, 180, 40), -- Accent hover state
    AccentColorActive = Color3.fromRGB(235, 150, 10), -- Accent active/click state
    BorderColor = Color3.fromRGB(13, 13, 13),        -- AcrylicBorder
    
    -- Text colors with consistent hierarchy
    HeadingColor = Color3.fromRGB(255, 236, 209),    -- Headings (white with orange hint)
    TextColor = Color3.fromRGB(235, 215, 190),       -- Normal text
    SecondaryTextColor = Color3.fromRGB(180, 170, 155), -- SubText (gray with orange hint)
    DisabledTextColor = Color3.fromRGB(120, 115, 105), -- Disabled text
    
    -- Systematic typography
    HeadingFont = Enum.Font.GothamBold,
    Font = Enum.Font.GothamSemibold,
    BodyFont = Enum.Font.Gotham,
    
    -- Heading sizes
    HeadingSize = 18,
    SubheadingSize = 16,
    BodyTextSize = 14,
    SmallTextSize = 13,
    
    -- UI element styling
    CornerRadius = UDim.new(0, 4),                 -- Small corner radius
    ButtonCornerRadius = UDim.new(0, 4),           -- Button corner radius
    SearchBarCornerRadius = UDim.new(0, 4),        -- Search bar corner radius
    
    -- Consistent spacing system (8px grid)
    SpacingXS = 4,
    SpacingS = 8,
    SpacingM = 16,
    SpacingL = 24,
    SpacingXL = 32,
    
    -- Animation and effects
    AnimationSpeed = 0.3,          -- Standard animation duration
    AnimationSpeedFast = 0.15,     -- Fast interactions
    AnimationSpeedSlow = 0.5,      -- Emphasized animations
    EasingStyle = Enum.EasingStyle.Quint,
    EasingDirection = Enum.EasingDirection.Out,
    
    -- Layout and sizing
    GameItemHeight = 76,           -- Game item height
    DefaultThumbnail = "rbxassetid://6894586021",
    Padding = 8,                   -- Base padding unit
    ItemSpacing = 8,               -- Space between items
    
    -- Status colors with improved contrast
    StatusColors = {
        ["Working"] = Color3.fromRGB(95, 190, 125),   -- Green
        ["Updated"] = Color3.fromRGB(85, 150, 215),   -- Blue
        ["Testing"] = Color3.fromRGB(230, 180, 80),   -- Yellow
        ["Patched"] = Color3.fromRGB(205, 95, 85)     -- Red
    },
    
    -- Element transparency
    ElementTransparency = 0.87,    -- From theme
    HoverTransparency = 0.82,      -- More visible on hover
    
    -- Improved elevation with subtle shadows
    ShadowTransparency = 0.85,
    ShadowSize = UDim2.new(1, 6, 1, 6),
    
    -- Interaction response
    HoverScale = 1.02,             -- Subtle scale on hover
    ClickScale = 0.98,             -- Subtle scale on click
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
    local MainCorner = Instance.new("UICorner")
    local MainBorder = Instance.new("UIStroke")
    local TopBar = Instance.new("Frame")
    local TopBarLine = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local SearchContainer = Instance.new("Frame")
    local SearchBar = Instance.new("Frame")
    local SearchBorder = Instance.new("UIStroke")
    local SearchIcon = Instance.new("ImageLabel")
    local SearchInput = Instance.new("TextBox")
    local Description = Instance.new("TextLabel")
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
    
    -- Main frame with clean modern design
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = config.MainColor
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.Visible = false -- Hide initially
    MainFrame.Parent = ScreenGui
    
    -- Add shadow for elevation
    createShadow(MainFrame)
    
    MainCorner.CornerRadius = config.CornerRadius
    MainCorner.Parent = MainFrame
    
    MainBorder.Color = config.BorderColor
    MainBorder.Thickness = 1.5
    MainBorder.Parent = MainFrame
    
    -- Top bar with minimalist design
    TopBar.Name = "TopBar"
    TopBar.BackgroundTransparency = 1
    TopBar.Size = UDim2.new(1, 0, 0, config.SpacingXL + config.SpacingXS)
    TopBar.Parent = MainFrame
    
    TopBarLine.Name = "TopBarLine"
    TopBarLine.BackgroundColor3 = config.BorderColor
    TopBarLine.BorderSizePixel = 0
    TopBarLine.Position = UDim2.new(0, 0, 1, 0)
    TopBarLine.Size = UDim2.new(1, 0, 0, 1)
    TopBarLine.Parent = TopBar
    
    Title.Name = "Title"
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, config.SpacingM, 0, 0)
    Title.Size = UDim2.new(1, -80, 1, 0)
    Title.Font = config.HeadingFont
    Title.Text = "Lomu Hub"
    Title.TextColor3 = config.HeadingColor
    Title.TextSize = config.HeadingSize
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar
    
    -- Close button with improved visuals
    CloseButton.Name = "CloseButton"
    CloseButton.BackgroundColor3 = Color3.fromRGB(192, 57, 57)
    CloseButton.Position = UDim2.new(1, -config.SpacingM - 20, 0.5, 0)
    CloseButton.AnchorPoint = Vector2.new(0, 0.5)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Font = config.HeadingFont
    CloseButton.Text = "×" -- Using a proper multiplication sign
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 18
    CloseButton.AutoButtonColor = false -- We'll handle hover effects manually
    CloseButton.Parent = TopBar
    
    local CloseButtonCorner = Instance.new("UICorner")
    CloseButtonCorner.CornerRadius = UDim.new(0, 3)
    CloseButtonCorner.Parent = CloseButton
    
    -- Description section - more modern spacing
    Description.Name = "Description"
    Description.BackgroundTransparency = 1
    Description.Position = UDim2.new(0, config.SpacingM, 0, config.SpacingXL + config.SpacingXS + config.SpacingXS)
    Description.Size = UDim2.new(1, -config.SpacingM*2, 0, config.SpacingL)
    Description.Font = config.BodyFont
    Description.Text = "Experience the future of gaming - All your favorite scripts in one place."
    Description.TextColor3 = config.SecondaryTextColor
    Description.TextSize = config.BodyTextSize
    Description.TextWrapped = true
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.Parent = MainFrame
    
    -- Search container - better spacing
    SearchContainer.Name = "SearchContainer"
    SearchContainer.BackgroundTransparency = 1
    SearchContainer.Position = UDim2.new(0, config.SpacingM, 0, Description.Position.Y.Offset + Description.Size.Y.Offset + config.SpacingS)
    SearchContainer.Size = UDim2.new(1, -config.SpacingM*2, 0, config.SpacingXL)
    SearchContainer.Parent = MainFrame
    
    -- Search bar with modern clean look
    SearchBar.Name = "SearchBar"
    SearchBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    SearchBar.BackgroundTransparency = config.ElementTransparency
    SearchBar.Size = UDim2.new(1, 0, 1, 0)
    SearchBar.Parent = SearchContainer
    
    SearchBorder.Color = config.BorderColor
    SearchBorder.Thickness = 1
    SearchBorder.Parent = SearchBar
    
    local SearchBarCorner = Instance.new("UICorner")
    SearchBarCorner.CornerRadius = config.SearchBarCornerRadius
    SearchBarCorner.Parent = SearchBar
    
    SearchIcon.Name = "SearchIcon"
    SearchIcon.BackgroundTransparency = 1
    SearchIcon.Position = UDim2.new(0, config.SpacingS, 0.5, 0)
    SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
    SearchIcon.Size = UDim2.new(0, 16, 0, 16)
    SearchIcon.Image = "rbxassetid://3926305904"
    SearchIcon.ImageRectOffset = Vector2.new(964, 324)
    SearchIcon.ImageRectSize = Vector2.new(36, 36)
    SearchIcon.ImageColor3 = config.SecondaryTextColor
    SearchIcon.Parent = SearchBar
    
    SearchInput.Name = "SearchInput"
    SearchInput.BackgroundTransparency = 1
    SearchInput.Position = UDim2.new(0, config.SpacingXL, 0, 0)
    SearchInput.Size = UDim2.new(1, -config.SpacingXL - config.SpacingS, 1, 0)
    SearchInput.Font = config.BodyFont
    SearchInput.PlaceholderText = "Search games..."
    SearchInput.Text = ""
    SearchInput.TextColor3 = config.TextColor
    SearchInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
    SearchInput.TextSize = config.BodyTextSize
    SearchInput.TextXAlignment = Enum.TextXAlignment.Left
    SearchInput.ClearTextOnFocus = false
    SearchInput.Parent = SearchBar
    
    -- Clear button for search
    local ClearButton = Instance.new("ImageButton")
    ClearButton.Name = "ClearButton"
    ClearButton.BackgroundTransparency = 1
    ClearButton.Position = UDim2.new(1, -config.SpacingM, 0.5, 0)
    ClearButton.AnchorPoint = Vector2.new(0.5, 0.5)
    ClearButton.Size = UDim2.new(0, 16, 0, 16)
    ClearButton.Image = "rbxassetid://3926305904"
    ClearButton.ImageRectOffset = Vector2.new(284, 4)
    ClearButton.ImageRectSize = Vector2.new(24, 24)
    ClearButton.ImageColor3 = config.SecondaryTextColor
    ClearButton.ImageTransparency = 1 -- Hidden by default
    ClearButton.Parent = SearchBar
    
    -- Category container - cleaner layout
    CategoryContainer.Name = "CategoryContainer"
    CategoryContainer.BackgroundTransparency = 1
    CategoryContainer.Position = UDim2.new(0, config.SpacingM, 0, SearchContainer.Position.Y.Offset + SearchContainer.Size.Y.Offset + config.SpacingS)
    CategoryContainer.Size = UDim2.new(1, -config.SpacingM*2, 0, config.SpacingL + config.SpacingXS)
    CategoryContainer.Parent = MainFrame
    
    CategoryLayout.Name = "CategoryLayout"
    CategoryLayout.FillDirection = Enum.FillDirection.Horizontal
    CategoryLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    CategoryLayout.SortOrder = Enum.SortOrder.LayoutOrder
    CategoryLayout.Padding = UDim.new(0, config.SpacingS)
    CategoryLayout.Parent = CategoryContainer
    
    -- Game list - better positioned
    GameList.Name = "GameList"
    GameList.BackgroundTransparency = 1
    GameList.Position = UDim2.new(0, config.SpacingM, 0, CategoryContainer.Position.Y.Offset + CategoryContainer.Size.Y.Offset + config.SpacingS)
    GameList.Size = UDim2.new(1, -config.SpacingM*2, 1, -(CategoryContainer.Position.Y.Offset + CategoryContainer.Size.Y.Offset + config.SpacingS + config.SpacingM))
    GameList.CanvasSize = UDim2.new(0, 0, 0, 0)
    GameList.ScrollBarThickness = 4
    GameList.ScrollBarImageColor3 = config.AccentColor
    GameList.ScrollingDirection = Enum.ScrollingDirection.Y
    GameList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    GameList.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    GameList.Parent = MainFrame
    
    GameListLayout.Name = "GameListLayout"
    GameListLayout.Padding = UDim.new(0, config.SpacingS)
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
    EmptyStateLabel.Size = UDim2.new(0, 300, 0, 60)
    EmptyStateLabel.Font = config.Font
    EmptyStateLabel.Text = "No games found. Try adjusting your search or category."
    EmptyStateLabel.TextColor3 = config.SecondaryTextColor
    EmptyStateLabel.TextSize = config.BodyTextSize
    EmptyStateLabel.TextWrapped = true
    EmptyStateLabel.Visible = false
    EmptyStateLabel.Parent = GameList
    
    -- Loading Indicator
    LoadingIndicator.Name = "LoadingIndicator"
    LoadingIndicator.BackgroundTransparency = 1
    LoadingIndicator.Position = UDim2.new(0.5, 0, 0.5, 0)
    LoadingIndicator.AnchorPoint = Vector2.new(0.5, 0.5)
    LoadingIndicator.Size = UDim2.new(0, 48, 0, 48)
    LoadingIndicator.Visible = false
    LoadingIndicator.Parent = MainFrame
    
    -- Create loading spinner elements
    for i = 1, 4 do
        local dot = Instance.new("Frame")
        dot.Name = "LoadingDot" .. i
        dot.BackgroundColor3 = config.AccentColor
        dot.Position = UDim2.new(0.5, -4, 0.5, -4)
        dot.AnchorPoint = Vector2.new(0.5, 0.5)
        dot.Size = UDim2.new(0, 8, 0, 8)
        dot.Parent = LoadingIndicator
        
        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(1, 0)
        dotCorner.Parent = dot
    end
    
    -- Loading animation
    local function animateLoading()
        local dots = {
            LoadingIndicator.LoadingDot1,
            LoadingIndicator.LoadingDot2,
            LoadingIndicator.LoadingDot3,
            LoadingIndicator.LoadingDot4
        }
        
        local positions = {
            UDim2.new(0, -16, 0, 0),
            UDim2.new(0, 0, 0, -16),
            UDim2.new(0, 16, 0, 0),
            UDim2.new(0, 0, 0, 16)
        }
        
        local connection
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not LoadingIndicator.Parent then
                connection:Disconnect()
                return
            end
            
            for i, dot in ipairs(dots) do
                local angle = (os.clock() * 2 + (i-1) * (math.pi/2)) % (math.pi * 2)
                local radius = 16
                local x = math.cos(angle) * radius
                local y = math.sin(angle) * radius
                dot.Position = UDim2.new(0.5, x - 4, 0.5, y - 4)
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
        CategoryButton.BackgroundColor3 = (catName == selectedCategory) and config.AccentColor or Color3.fromRGB(35, 35, 35)
        CategoryButton.BackgroundTransparency = (catName == selectedCategory) and 0 or 0.5
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
                    BackgroundColor3 = Color3.fromRGB(45, 45, 50),
                    BackgroundTransparency = 0.4,
                    Size = UDim2.new(0, CategoryButton.AbsoluteSize.X * config.HoverScale, 1, 0)
                })
            end
        end)
        
        CategoryButton.MouseLeave:Connect(function()
            if catName ~= selectedCategory then
                smoothTween(CategoryButton, config.AnimationSpeedFast, {
                    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                    BackgroundTransparency = 0.5,
                    Size = UDim2.new(0, 0, 1, 0)
                })
            end
        end)
        
        -- Select category on click with enhanced animation
        CategoryButton.MouseButton1Down:Connect(function()
            smoothTween(CategoryButton, config.AnimationSpeedFast, {
                Size = UDim2.new(0, CategoryButton.AbsoluteSize.X * config.ClickScale, 1, 0)
            })
        end)
        
        CategoryButton.MouseButton1Click:Connect(function()
            if catName ~= selectedCategory then
                -- Show loading indicator for better UX
                LoadingIndicator.Visible = true
                animateLoading()
                
                -- Update old selected button
                for _, btn in pairs(categoryButtons) do
                    if btn.Name == "Category_" .. selectedCategory then
                        smoothTween(btn, config.AnimationSpeedFast, {
                            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                            BackgroundTransparency = 0.5
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
            Size = UDim2.new(0, 22, 0, 22)
        })
    end)
    
    CloseButton.MouseLeave:Connect(function()
        smoothTween(CloseButton, config.AnimationSpeedFast, {
            BackgroundColor3 = Color3.fromRGB(192, 57, 57),
            Size = UDim2.new(0, 20, 0, 20)
        })
    end)
    
    CloseButton.MouseButton1Down:Connect(function()
        smoothTween(CloseButton, config.AnimationSpeedFast, {
            Size = UDim2.new(0, 18, 0, 18)
        })
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        -- Prep for clean closing animation
        smoothTween(CloseButton, config.AnimationSpeedFast, {
            Size = UDim2.new(0, 20, 0, 20)
        })
        
        -- First fade out content
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
    
    -- Search functionality with improved UX
    -- Show/hide clear button based on text content
    SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
        local searchText = SearchInput.Text
        
        -- Clear button visibility
        if searchText ~= "" then
            smoothTween(ClearButton, config.AnimationSpeedFast, {
                ImageTransparency = 0.2
            })
        else
            smoothTween(ClearButton, config.AnimationSpeedFast, {
                ImageTransparency = 1
            })
        end
        
        -- Debounced search function for better performance
        if hub._searchDebounce then
            task.cancel(hub._searchDebounce)
        end
        
        hub._searchDebounce = task.delay(0.3, function()
            LoadingIndicator.Visible = true
            animateLoading()
            
            local lowercaseSearch = string.lower(searchText)
            local visibleCount = 0
            
            -- Update game visibility
            for _, child in pairs(GameList:GetChildren()) do
                if child:IsA("Frame") and child.Name:sub(1, 9) == "GameItem_" then
                    local gameCategory = child:GetAttribute("Category") or "All"
                    local gameName = child.Name:sub(10)
                    local shouldBeVisible = (selectedCategory == "All" or gameCategory == selectedCategory)
                    
                    -- Apply search filter
                    if lowercaseSearch ~= "" then
                        shouldBeVisible = shouldBeVisible and string.find(string.lower(gameName), lowercaseSearch)
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
        end)
    end)
    
    -- Clear search button functionality
    ClearButton.MouseButton1Click:Connect(function()
        SearchInput.Text = ""
        SearchInput:CaptureFocus()
    end)
    
    -- Search bar focus/blur effects
    SearchInput.Focused:Connect(function()
        smoothTween(SearchBorder, config.AnimationSpeedFast, {
            Color = config.AccentColor,
            Transparency = 0.2
        })
        
        smoothTween(SearchIcon, config.AnimationSpeedFast, {
            ImageColor3 = config.AccentColor,
            ImageTransparency = 0
        })
    end)
    
    SearchInput.FocusLost:Connect(function()
        smoothTween(SearchBorder, config.AnimationSpeedFast, {
            Color = config.BorderColor,
            Transparency = 0
        })
        
        smoothTween(SearchIcon, config.AnimationSpeedFast, {
            ImageColor3 = config.SecondaryTextColor,
            ImageTransparency = 0.2
        })
    end)
    
    -- Make frame draggable with improved touch behavior
    local UserInputService = game:GetService("UserInputService")
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function updateDrag(input)
        local delta = input.Position - dragStart
        
        -- Smooth drag with slight elastic feel
        smoothTween(MainFrame, 0.1, {
            Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        })
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
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateDrag(input)
        end
    end)
    
    -- Add game function - Completely redesigned game item
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
        local ThumbnailOverlay = Instance.new("Frame")
        local ThumbnailOverlayCorner = Instance.new("UICorner")
        local GameName = Instance.new("TextLabel")
        local LastUpdate = Instance.new("TextLabel")
        local StatusLabel = Instance.new("TextLabel")
        local StatusIndicator = Instance.new("Frame")
        local PlayButton = Instance.new("TextButton")
        local PlayButtonCorner = Instance.new("UICorner")
        local PlayIcon = Instance.new("ImageLabel")
        local GameTooltip = Instance.new("Frame")
        
        GameItem.Name = "GameItem_" .. gameName
        GameItem.BackgroundColor3 = config.SecondaryColor
        GameItem.BackgroundTransparency = config.ElementTransparency
        GameItem.Size = UDim2.new(1, 0, 0, config.GameItemHeight)
        GameItem.ClipsDescendants = true -- For animation effects
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
        
        -- Thumbnail with overlay effect
        Thumbnail.Name = "Thumbnail"
        Thumbnail.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Thumbnail.Position = UDim2.new(0, config.SpacingS, 0.5, 0)
        Thumbnail.AnchorPoint = Vector2.new(0, 0.5)
        Thumbnail.Size = UDim2.new(0, 60, 0, 60)
        Thumbnail.Image = gameThumbnail
        Thumbnail.Parent = GameItemInner
        
        ThumbnailCorner.CornerRadius = UDim.new(0, 4)
        ThumbnailCorner.Parent = Thumbnail
        
        -- Overlay for thumbnail on hover
        ThumbnailOverlay.Name = "Overlay"
        ThumbnailOverlay.BackgroundColor3 = config.AccentColor
        ThumbnailOverlay.BackgroundTransparency = 1
        ThumbnailOverlay.Size = UDim2.new(1, 0, 1, 0)
        ThumbnailOverlay.ZIndex = 2
        ThumbnailOverlay.Parent = Thumbnail
        
        ThumbnailOverlayCorner.CornerRadius = UDim.new(0, 4)
        ThumbnailOverlayCorner.Parent = ThumbnailOverlay
        
        -- Game name - improved typography
        GameName.Name = "GameName"
        GameName.BackgroundTransparency = 1
        GameName.Position = UDim2.new(0, 76, 0, config.SpacingS)
        GameName.Size = UDim2.new(1, -180, 0, 20)
        GameName.Font = config.Font
        GameName.Text = gameName
        GameName.TextColor3 = config.TextColor
        GameName.TextSize = config.SubheadingSize
        GameName.TextXAlignment = Enum.TextXAlignment.Left
        GameName.Parent = GameItemInner
        
        -- Last update - subtle secondary text
        LastUpdate.Name = "LastUpdate"
        LastUpdate.BackgroundTransparency = 1
        LastUpdate.Position = UDim2.new(0, 76, 0, GameName.Position.Y.Offset + GameName.Size.Y.Offset + 2)
        LastUpdate.Size = UDim2.new(1, -180, 0, 14)
        LastUpdate.Font = config.BodyFont
        LastUpdate.Text = "Updated: " .. gameLastUpdate
        LastUpdate.TextColor3 = config.SecondaryTextColor
        LastUpdate.TextSize = config.SmallTextSize
        LastUpdate.TextXAlignment = Enum.TextXAlignment.Left
        LastUpdate.Parent = GameItemInner
        
        -- Status indicator - minimalist dot with better visual hierarchy
        local statusColor = config.StatusColors[gameStatus] or Color3.fromRGB(150, 150, 150)
        
        StatusIndicator.Name = "StatusIndicator"
        StatusIndicator.BackgroundColor3 = statusColor
        StatusIndicator.Position = UDim2.new(0, 76, 0, LastUpdate.Position.Y.Offset + LastUpdate.Size.Y.Offset + 8)
        StatusIndicator.Size = UDim2.new(0, 8, 0, 8)
        StatusIndicator.Parent = GameItemInner
        
        local StatusIndicatorCorner = Instance.new("UICorner")
        StatusIndicatorCorner.CornerRadius = UDim.new(1, 0)
        StatusIndicatorCorner.Parent = StatusIndicator
        
        StatusLabel.Name = "StatusLabel"
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Position = UDim2.new(0, 90, 0, StatusIndicator.Position.Y.Offset - 4)
        StatusLabel.Size = UDim2.new(0, 100, 0, 14)
        StatusLabel.Font = config.BodyFont
        StatusLabel.Text = gameStatus
        StatusLabel.TextColor3 = statusColor
        StatusLabel.TextSize = config.SmallTextSize
        StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
        StatusLabel.Parent = GameItemInner
        
        -- Play button - modernized with icon
        PlayButton.Name = "PlayButton"
        PlayButton.BackgroundColor3 = config.AccentColor
        PlayButton.Position = UDim2.new(1, -80, 0.5, 0)
        PlayButton.AnchorPoint = Vector2.new(0, 0.5)
        PlayButton.Size = UDim2.new(0, 70, 0, 34)
        PlayButton.AutoButtonColor = false
        PlayButton.Font = config.ButtonFont
        PlayButton.Text = "PLAY"
        PlayButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        PlayButton.TextSize = 14
        PlayButton.Parent = GameItemInner
        
        PlayButtonCorner.CornerRadius = config.ButtonCornerRadius
        PlayButtonCorner.Parent = PlayButton
        
        -- Create shadow for play button
        createShadow(PlayButton, 0.8)
        
        -- Tooltip for game info
        GameTooltip.Name = "Tooltip"
        GameTooltip.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        GameTooltip.BackgroundTransparency = 0.2
        GameTooltip.BorderSizePixel = 0
        GameTooltip.Position = UDim2.new(0, 76, 0, -40)
        GameTooltip.Size = UDim2.new(0, 200, 0, 0)
        GameTooltip.Visible = false
        GameTooltip.ZIndex = 10
        GameTooltip.Parent = GameItem
        
        local TooltipCorner = Instance.new("UICorner")
        TooltipCorner.CornerRadius = UDim.new(0, 4)
        TooltipCorner.Parent = GameTooltip
        
        -- Advanced hover effects with subtle animations
        -- Game item hover
        GameItem.MouseEnter:Connect(function()
            smoothTween(GameItem, config.AnimationSpeedFast, {
                BackgroundTransparency = config.HoverTransparency
            })
            
            smoothTween(GameBorder, config.AnimationSpeedFast, {
                Color = config.AccentColor,
                Transparency = 0.7
            })
            
            -- Subtle indicator animation
            smoothTween(StatusIndicator, config.AnimationSpeedFast, {
                Size = UDim2.new(0, 10, 0, 10),
                Position = UDim2.new(0, 75, 0, StatusIndicator.Position.Y.Offset - 1)
            })
            
            -- Thumbnail overlay 
            smoothTween(ThumbnailOverlay, config.AnimationSpeedFast, {
                BackgroundTransparency = 0.8
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
            
            -- Reset indicator
            smoothTween(StatusIndicator, config.AnimationSpeedFast, {
                Size = UDim2.new(0, 8, 0, 8),
                Position = UDim2.new(0, 76, 0, StatusIndicator.Position.Y.Offset + 1)
            })
            
            -- Hide thumbnail overlay
            smoothTween(ThumbnailOverlay, config.AnimationSpeedFast, {
                BackgroundTransparency = 1
            })
        end)
        
        -- Play button enhanced effects
        PlayButton.MouseEnter:Connect(function()
            smoothTween(PlayButton, config.AnimationSpeedFast, {
                BackgroundColor3 = config.AccentColorHover,
                Size = UDim2.new(0, 74, 0, 36)
            })
            
            -- Update shadow
            local shadow = PlayButton:FindFirstChild("Shadow")
            if shadow then
                smoothTween(shadow, config.AnimationSpeedFast, {
                    ImageTransparency = 0.7
                })
            end
        end)
        
        PlayButton.MouseLeave:Connect(function()
            smoothTween(PlayButton, config.AnimationSpeedFast, {
                BackgroundColor3 = config.AccentColor,
                Size = UDim2.new(0, 70, 0, 34)
            })
            
            -- Reset shadow
            local shadow = PlayButton:FindFirstChild("Shadow")
            if shadow then
                smoothTween(shadow, config.AnimationSpeedFast, {
                    ImageTransparency = 0.8
                })
            end
        end)
        
        -- Play button click with tactile feedback
        PlayButton.MouseButton1Down:Connect(function()
            smoothTween(PlayButton, 0.1, {
                Size = UDim2.new(0, 66, 0, 32),
                BackgroundColor3 = config.AccentColorActive
            })
        end)
        
        PlayButton.MouseButton1Up:Connect(function()
            smoothTween(PlayButton, 0.1, {
                Size = UDim2.new(0, 70, 0, 34),
                BackgroundColor3 = config.AccentColorHover
            })
        end)
        
        -- Play button functionality with loading feedback
        PlayButton.MouseButton1Click:Connect(function()
            -- Visual feedback
            PlayButton.Text = "..."
            
            -- Create loading animation
            local loadingDots = {}
            for i = 1, 3 do
                local dot = Instance.new("Frame")
                dot.Name = "LoadingDot" .. i
                dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                dot.Position = UDim2.new(0.5, -12 + (i-1)*10, 0.5, 0)
                dot.AnchorPoint = Vector2.new(0.5, 0.5)
                dot.Size = UDim2.new(0, 4, 0, 4)
                
                local dotCorner = Instance.new("UICorner")
                dotCorner.CornerRadius = UDim.new(1, 0)
                dotCorner.Parent = dot
                
                dot.Parent = PlayButton
                table.insert(loadingDots, dot)
                
                -- Animate the dot
                task.spawn(function()
                    while PlayButton:FindFirstChild("LoadingDot" .. i) do
                        smoothTween(dot, 0.5, {
                            Position = UDim2.new(0.5, -12 + (i-1)*10, 0.5, -4)
                        })
                        task.wait(0.15)
                        smoothTween(dot, 0.5, {
                            Position = UDim2.new(0.5, -12 + (i-1)*10, 0.5, 4)
                        })
                        task.wait(0.15)
                    end
                end)
            end
            
            -- Execute callback with timeout
            local callbackSuccess = false
            local callbackThread = task.spawn(function()
                gameCallback()
                callbackSuccess = true
            end)
            
            -- Show loading for at least 0.5 seconds for feedback
            task.delay(0.5, function()
                -- Reset button state
                PlayButton.Text = "PLAY"
                
                -- Remove loading dots
                for _, dot in ipairs(loadingDots) do
                    if dot.Parent then
                        dot:Destroy()
                    end
                end
                
                -- Handle callback timeout
                if not callbackSuccess then
                    task.delay(10, function()
                        if not callbackSuccess then
                            hub:ShowNotification("Script execution taking longer than expected...", 3)
                        end
                    end)
                end
            end)
        end)
        
        -- Keyboard support for accessibility
        GameItem.SelectionImageObject = Instance.new("ImageLabel")
        GameItem.SelectionImageObject.BackgroundTransparency = 1
        GameItem.SelectionImageObject.Image = ""
        GameItem.SelectionImageObject.Size = UDim2.new(1, 0, 1, 0)
        GameItem.SelectionGroup = true
        GameItem.Selectable = true
        GameItem.NextSelectionDown = nil -- Will be set dynamically
        
        PlayButton.NextSelectionLeft = GameItem
        PlayButton.Selectable = true
        
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
        CategoryButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        CategoryButton.BackgroundTransparency = 0.5
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
                    BackgroundColor3 = Color3.fromRGB(45, 45, 50),
                    BackgroundTransparency = 0.4,
                    Size = UDim2.new(0, CategoryButton.AbsoluteSize.X * config.HoverScale, 1, 0)
                })
            end
        end)
        
        CategoryButton.MouseLeave:Connect(function()
            if categoryName ~= selectedCategory then
                smoothTween(CategoryButton, config.AnimationSpeedFast, {
                    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                    BackgroundTransparency = 0.5,
                    Size = UDim2.new(0, 0, 1, 0)
                })
            end
        end)
        
        -- Click effects
        CategoryButton.MouseButton1Down:Connect(function()
            smoothTween(CategoryButton, config.AnimationSpeedFast, {
                Size = UDim2.new(0, CategoryButton.AbsoluteSize.X * config.ClickScale, 1, 0)
            })
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
                            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                            BackgroundTransparency = 0.5
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
                
                -- Filter games with improved animation
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
                        
                        -- Staggered animations for better UX
                        if shouldBeVisible then
                            visibleCount = visibleCount + 1
                            if not child.Visible then
                                task.delay(visibleCount * 0.02, function()
                                    child.Visible = true
                                    child.BackgroundTransparency = 1
                                    child.Position = UDim2.new(0.05, 0, 0, child.Position.Y.Offset)
                                    
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
                                    Position = UDim2.new(-0.05, 0, 0, child.Position.Y.Offset)
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
        
        -- Make selectable for keyboard navigation
        CategoryButton.Selectable = true
        CategoryButton.NextSelectionRight = categoryButtons[#categoryButtons] and categoryButtons[#categoryButtons] or nil
        
        if #categoryButtons > 0 then
            categoryButtons[#categoryButtons].NextSelectionRight = CategoryButton
        end
        
        table.insert(categoryButtons, CategoryButton)
        return CategoryButton
    end
    
    -- Set title with animation
    function hub:SetTitle(titleText)
        Title.Text = titleText
    end
    
    -- Set description with animation
    function hub:SetDescription(descText)
        Description.Text = descText
    end
    
    -- Improved notification system
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
        notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        notification.BackgroundTransparency = 0.1
        notification.Position = UDim2.new(0.5, 0, 0, -50)
        notification.AnchorPoint = Vector2.new(0.5, 0)
        notification.Size = UDim2.new(0, 0, 0, 40)
        notification.AutomaticSize = Enum.AutomaticSize.X
        notification.ZIndex = 1000
        notification.Parent = ScreenGui
        
        -- Add shadow for depth
        createShadow(notification)
        
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
        notificationBorder.Thickness = 1.5
        notificationBorder.Parent = notification
        
        -- Icon based on type
        notificationIcon.Name = "Icon"
        notificationIcon.BackgroundTransparency = 1
        notificationIcon.Position = UDim2.new(0, 12, 0.5, 0)
        notificationIcon.AnchorPoint = Vector2.new(0, 0.5)
        notificationIcon.Size = UDim2.new(0, 16, 0, 16)
        
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
        notificationText.Position = UDim2.new(0, 36, 0, 0)
        notificationText.Size = UDim2.new(0, 0, 1, 0)
        notificationText.AutomaticSize = Enum.AutomaticSize.X
        notificationText.Font = config.BodyFont
        notificationText.Text = message
        notificationText.TextColor3 = config.TextColor
        notificationText.TextSize = 14
        notificationText.Parent = notification
        
        -- Close button for notifications
        closeButton.Name = "CloseButton"
        closeButton.BackgroundTransparency = 1
        closeButton.Position = UDim2.new(1, -20, 0.5, 0)
        closeButton.AnchorPoint = Vector2.new(0.5, 0.5)
        closeButton.Size = UDim2.new(0, 20, 0, 20)
        closeButton.Font = config.HeadingFont
        closeButton.Text = "×"
        closeButton.TextColor3 = config.SecondaryTextColor
        closeButton.TextSize = 20
        closeButton.ZIndex = 1001
        closeButton.Parent = notification
        
        -- Close button hover effect
        closeButton.MouseEnter:Connect(function()
            smoothTween(closeButton, config.AnimationSpeedFast, {
                TextColor3 = config.TextColor
            })
        end)
        
        closeButton.MouseLeave:Connect(function()
            smoothTween(closeButton, config.AnimationSpeedFast, {
                TextColor3 = config.SecondaryTextColor
            })
        end)
        
        closeButton.MouseButton1Click:Connect(function()
            dismissNotification()
        end)
        
        -- Show notification with entrance animation
        local function showNotification()
            notification.Size = UDim2.new(0, notificationText.TextBounds.X + 70, 0, 40)
            
            smoothTween(notification, 0.3, {
                Position = UDim2.new(0.5, 0, 0, 20)
            })
        end
        
        -- Hide notification with exit animation
        function dismissNotification()
            smoothTween(notification, 0.3, {
                Position = UDim2.new(0.5, 0, 0, -50)
            }, function()
                notification:Destroy()
            end)
        end
        
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
    MainFrame.Size = UDim2.new(0, 600, 0, 0)
    MainFrame.Visible = true
    
    -- Then animate to full size
    local openTween = smoothTween(MainFrame, config.AnimationSpeed, {
        Size = UDim2.new(0, 600, 0, 400)
    })
    
    openTween:Play()
    
    return hub
end

-- Create a hub directly (no start menu)
function UILibrary.CreateHub(customConfig)
    return UILibrary.new(customConfig)
end

-- Redesigned Start Menu function - minimalist, positioned at bottom center, with bottom-up animation
function UILibrary.CreateStartMenu(hubCallback, universalCallback)
    local startMenu = {}
    
    -- Main GUI elements for start menu
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local MainBorder = Instance.new("UIStroke")
    local Title = Instance.new("TextLabel")
    local Subtitle = Instance.new("TextLabel") 
    local AvatarFrame = Instance.new("Frame")
    local AvatarImage = Instance.new("ImageLabel")
    local AvatarCorner = Instance.new("UICorner")
    local UsernameLabel = Instance.new("TextLabel")
    local ButtonContainer = Instance.new("Frame")
    local ButtonLayout = Instance.new("UIListLayout")
    local HubButton = Instance.new("TextButton")
    local HubButtonCorner = Instance.new("UICorner")
    local UniversalButton = Instance.new("TextButton")
    local UniversalButtonCorner = Instance.new("UICorner")
    
    -- Set up ScreenGui
    ScreenGui.Name = "LomuStartMenu"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main frame - clean modern design positioned at bottom center
    MainFrame.Name = "StartMenuFrame"
    MainFrame.BackgroundColor3 = config.MainColor
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 1, 100) -- Start from below the screen
    MainFrame.AnchorPoint = Vector2.new(0.5, 1) -- Anchor to bottom center
    MainFrame.Size = UDim2.new(0, 400, 0, 180) -- More compact, minimalist size
    MainFrame.Visible = false -- Hide initially
    MainFrame.Parent = ScreenGui
    
    MainCorner.CornerRadius = config.CornerRadius
    MainCorner.Parent = MainFrame
    
    MainBorder.Color = config.BorderColor
    MainBorder.Thickness = 1.5
    MainBorder.Parent = MainFrame
    
    -- Avatar and Username - more elegant layout
    AvatarFrame.Name = "AvatarFrame"
    AvatarFrame.BackgroundTransparency = 1
    AvatarFrame.Position = UDim2.new(0, 15, 0, 15)
    AvatarFrame.Size = UDim2.new(0, 60, 0, 80)
    AvatarFrame.Parent = MainFrame
    
    AvatarImage.Name = "AvatarImage"
    AvatarImage.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    AvatarImage.BackgroundTransparency = 0.5
    AvatarImage.Position = UDim2.new(0, 0, 0, 0)
    AvatarImage.Size = UDim2.new(0, 60, 0, 60)
    AvatarImage.Image = "" -- Will be set to player avatar
    AvatarImage.Parent = AvatarFrame
    
    AvatarCorner.CornerRadius = UDim.new(0, 8)
    AvatarCorner.Parent = AvatarImage
    
    UsernameLabel.Name = "Username"
    UsernameLabel.BackgroundTransparency = 1
    UsernameLabel.Position = UDim2.new(0, 0, 0, 65)
    UsernameLabel.Size = UDim2.new(0, 60, 0, 15)
    UsernameLabel.Font = config.ButtonFont
    UsernameLabel.Text = "Username"
    UsernameLabel.TextColor3 = config.TextColor
    UsernameLabel.TextSize = 13
    UsernameLabel.Parent = AvatarFrame
    
    -- Get player avatar and username
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    
    if player then
        -- Get player avatar
        local userId = player.UserId
        local thumbType = Enum.ThumbnailType.HeadShot
        local thumbSize = Enum.ThumbnailSize.Size420x420
        
        pcall(function()
            local content = Players:GetUserThumbnailAsync(userId, thumbType, thumbSize)
            AvatarImage.Image = content
        end)
        
        -- Set username
        UsernameLabel.Text = player.Name
    end
    
    -- Title and subtitle - clean minimalist design
    Title.Name = "Title"
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 85, 0, 20)
    Title.Size = UDim2.new(0, 200, 0, 25)
    Title.Font = config.Font
    Title.Text = "Lomu Hub"
    Title.TextColor3 = config.TextColor
    Title.TextSize = 20
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = MainFrame
    
    Subtitle.Name = "Subtitle"
    Subtitle.BackgroundTransparency = 1
    Subtitle.Position = UDim2.new(0, 85, 0, 45)
    Subtitle.Size = UDim2.new(0, 200, 0, 20)
    Subtitle.Font = config.ButtonFont
    Subtitle.Text = "Choose an option to continue"
    Subtitle.TextColor3 = config.SecondaryTextColor
    Subtitle.TextSize = 14
    Subtitle.TextXAlignment = Enum.TextXAlignment.Left
    Subtitle.Parent = MainFrame
    
    -- Button Container - right aligned for balance
    ButtonContainer.Name = "ButtonContainer"
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Position = UDim2.new(0, 85, 0, 80)
    ButtonContainer.Size = UDim2.new(0, 300, 0, 90)
    ButtonContainer.Parent = MainFrame
    
    ButtonLayout.Name = "ButtonLayout"
    ButtonLayout.FillDirection = Enum.FillDirection.Vertical
    ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ButtonLayout.Padding = UDim.new(0, 10)
    ButtonLayout.Parent = ButtonContainer
    
    -- Hub Button - clean modern design
    HubButton.Name = "HubButton"
    HubButton.BackgroundColor3 = config.AccentColor
    HubButton.Size = UDim2.new(1, -20, 0, 36)
    HubButton.Font = config.ButtonFont
    HubButton.Text = "Load Lomu Hub"
    HubButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    HubButton.TextSize = 14
    HubButton.AutoButtonColor = false
    HubButton.Parent = ButtonContainer
    
    HubButtonCorner.CornerRadius = config.ButtonCornerRadius
    HubButtonCorner.Parent = HubButton
    
    -- Load Universal button
    UniversalButton.Name = "LoadUniversalButton"
    UniversalButton.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    UniversalButton.Position = UDim2.new(0.5, 5, 0, 0)
    UniversalButton.Size = UDim2.new(0.5, -25, 1, -10)
    UniversalButton.Font = config.ButtonFont
    UniversalButton.Text = "Load Universal"
    UniversalButton.TextColor3 = config.TextColor
    UniversalButton.TextSize = 14
    UniversalButton.AutoButtonColor = false
    UniversalButton.Parent = ButtonContainer
    
    UniversalButtonCorner.CornerRadius = config.ButtonCornerRadius
    UniversalButtonCorner.Parent = UniversalButton
    
    -- Add shadows to buttons
    createShadow(HubButton)
    createShadow(UniversalButton)
    
    -- Button effects
    HubButton.MouseEnter:Connect(function()
        smoothTween(HubButton, config.AnimationSpeedFast, {
            BackgroundColor3 = config.AccentColorHover,
            Size = UDim2.new(0.5, -23, 1, -8)
        })
    end)
    
    HubButton.MouseLeave:Connect(function()
        smoothTween(HubButton, config.AnimationSpeedFast, {
            BackgroundColor3 = config.AccentColor,
            Size = UDim2.new(0.5, -25, 1, -10)
        })
    end)
    
    HubButton.MouseButton1Down:Connect(function()
        smoothTween(HubButton, 0.1, {
            BackgroundColor3 = config.AccentColorActive,
            Size = UDim2.new(0.5, -27, 1, -12)
        })
    end)
    
    HubButton.MouseButton1Up:Connect(function()
        smoothTween(HubButton, 0.1, {
            BackgroundColor3 = config.AccentColorHover,
            Size = UDim2.new(0.5, -23, 1, -8)
        })
    end)
    
    HubButton.MouseButton1Click:Connect(function()
        -- Hide start menu with animation
        smoothTween(MainFrame, 0.3, {
            Position = UDim2.new(0.5, 0, 1, 100)
        }, function()
            ScreenGui:Destroy()
            hubCallback()
        end)
    end)
    
    UniversalButton.MouseEnter:Connect(function()
        smoothTween(UniversalButton, config.AnimationSpeedFast, {
            BackgroundColor3 = Color3.fromRGB(45, 45, 50),
            Size = UDim2.new(0.5, -23, 1, -8)
        })
    end)
    
    UniversalButton.MouseLeave:Connect(function()
        smoothTween(UniversalButton, config.AnimationSpeedFast, {
            BackgroundColor3 = Color3.fromRGB(35, 35, 40),
            Size = UDim2.new(0.5, -25, 1, -10)
        })
    end)
    
    UniversalButton.MouseButton1Down:Connect(function()
        smoothTween(UniversalButton, 0.1, {
            BackgroundColor3 = Color3.fromRGB(40, 40, 45),
            Size = UDim2.new(0.5, -27, 1, -12)
        })
    end)
    
    UniversalButton.MouseButton1Up:Connect(function()
        smoothTween(UniversalButton, 0.1, {
            BackgroundColor3 = Color3.fromRGB(45, 45, 50),
            Size = UDim2.new(0.5, -23, 1, -8)
        })
    end)
    
    UniversalButton.MouseButton1Click:Connect(function()
        -- Hide start menu with animation
        smoothTween(MainFrame, 0.3, {
            Position = UDim2.new(0.5, 0, 1, 100)
        }, function()
            ScreenGui:Destroy()
            universalCallback()
        end)
    end)
    
    -- Parent to CoreGui or PlayerGui
    pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    
    if not ScreenGui.Parent then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Improved animation sequence
    -- First make the frame visible but positioned below screen
    MainFrame.Visible = true
    
    -- Then animate from bottom to desired position
    local openTween = smoothTween(MainFrame, config.AnimationSpeed, {
        Position = UDim2.new(0.5, 0, 1, -20)
    })
    
    openTween:Play()
    
    -- Functions
    function startMenu:Hide()
        local hideTween = smoothTween(MainFrame, config.AnimationSpeed, {
            Position = UDim2.new(0.5, 0, 1, 100)
        })
        
        hideTween:Play()
        
        hideTween.Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end
    
    function startMenu:SetTitle(text)
        Title.Text = text
    end
    
    function startMenu:SetSubtitle(text)
        Subtitle.Text = text
    end
    
    return startMenu
end

-- Show notification globally
function UILibrary.ShowNotification(message, duration)
    duration = duration or 3
    
    -- Create GUI elements
    local ScreenGui = Instance.new("ScreenGui")
    local Notification = Instance.new("Frame")
    local NotificationCorner = Instance.new("UICorner")
    local NotificationBorder = Instance.new("UIStroke")
    local NotificationText = Instance.new("TextLabel")
    
    -- Set up ScreenGui
    ScreenGui.Name = "LomuNotification"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Create minimalist notification design
    Notification.Name = "Notification"
    Notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Notification.BackgroundTransparency = 0.1
    Notification.Position = UDim2.new(0.5, 0, 0, -40)
    Notification.AnchorPoint = Vector2.new(0.5, 0)
    Notification.Size = UDim2.new(0, 0, 0, 36)
    Notification.AutomaticSize = Enum.AutomaticSize.X
    Notification.Parent = ScreenGui
    
    NotificationCorner.CornerRadius = UDim.new(0, 4)
    NotificationCorner.Parent = Notification
    
    NotificationBorder.Color = config.BorderColor
    NotificationBorder.Thickness = 1
    NotificationBorder.Parent = Notification
    
    NotificationText.Name = "NotificationText"
    NotificationText.BackgroundTransparency = 1
    NotificationText.Position = UDim2.new(0, 15, 0, 0)
    NotificationText.Size = UDim2.new(0, 0, 1, 0)
    NotificationText.AutomaticSize = Enum.AutomaticSize.X
    NotificationText.Font = config.BodyFont
    NotificationText.Text = message
    NotificationText.TextColor3 = config.TextColor
    NotificationText.TextSize = 14
    NotificationText.Parent = Notification
    
    -- Parent to CoreGui or PlayerGui
    pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    
    if not ScreenGui.Parent then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end
    
    -- Smooth animation
    local showTween = smoothTween(Notification, 0.5, {
        Position = UDim2.new(0.5, 0, 0, 20)
    })
    
    showTween:Play()
    
    -- Hide after duration with clean animation
    task.delay(duration, function()
        local hideTween = smoothTween(Notification, 0.5, {
            Position = UDim2.new(0.5, 0, 0, -40)
        })
        
        hideTween:Play()
        
        -- Clean up after animation is complete
        hideTween.Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end)
end

return UILibrary
