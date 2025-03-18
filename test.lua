local UILibrary = {}

-- Theme configuration based on Lomu Hub Theme
local config = {
    -- Core colors
    MainColor = Color3.fromRGB(20, 20, 20),          -- AcrylicMain
    SecondaryColor = Color3.fromRGB(40, 40, 40),     -- Dialog button
    AccentColor = Color3.fromRGB(251, 165, 24),      -- Accent (#FBA518)
    BorderColor = Color3.fromRGB(13, 13, 13),        -- AcrylicBorder
    
    -- Text colors
    TextColor = Color3.fromRGB(255, 236, 209),       -- Text (white with orange hint)
    SecondaryTextColor = Color3.fromRGB(180, 170, 155), -- SubText (gray with orange hint)
    
    -- UI element styling
    Font = Enum.Font.GothamSemibold,
    ButtonFont = Enum.Font.Gotham,
    CornerRadius = UDim.new(0, 4),                 -- Small corner radius
    ButtonCornerRadius = UDim.new(0, 4),           -- Button corner radius
    SearchBarCornerRadius = UDim.new(0, 4),        -- Search bar corner radius
    
    -- Animation and effects
    AnimationSpeed = 0.5,
    AnimationSpeedFast = 0.25,
    AnimationEasingStyle = Enum.EasingStyle.Quint,
    AnimationEasingDirection = Enum.EasingDirection.Out,
    
    -- Layout and spacing
    GameItemHeight = 75,                           -- Game item height
    DefaultThumbnail = "rbxassetid://6894586021",
    Padding = 10,                                  -- Consistent padding
    ItemSpacing = 6,                               -- Space between items
    
    -- Status colors
    StatusColors = {
        ["Working"] = Color3.fromRGB(86, 180, 116),   -- Green
        ["Updated"] = Color3.fromRGB(79, 140, 201),   -- Blue
        ["Testing"] = Color3.fromRGB(220, 170, 80),   -- Yellow
        ["Patched"] = Color3.fromRGB(192, 96, 86)     -- Red
    },
    
    -- Element transparency
    ElementTransparency = 0.87,                    -- From theme
    
    -- Slider
    SliderRail = Color3.fromRGB(201, 132, 19)      -- From theme
}

-- Helper function for smooth animations
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
    
    -- Set up ScreenGui
    ScreenGui.Name = "LomuHubLibrary"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main frame with clean modern design
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = config.MainColor
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.Visible = false -- Hide initially
    MainFrame.Parent = ScreenGui
    
    MainCorner.CornerRadius = config.CornerRadius
    MainCorner.Parent = MainFrame
    
    MainBorder.Color = config.BorderColor
    MainBorder.Thickness = 1.5
    MainBorder.Parent = MainFrame
    
    -- Top bar with minimalist design
    TopBar.Name = "TopBar"
    TopBar.BackgroundTransparency = 1
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.Parent = MainFrame
    
    TopBarLine.Name = "TopBarLine"
    TopBarLine.BackgroundColor3 = config.BorderColor
    TopBarLine.BorderSizePixel = 0
    TopBarLine.Position = UDim2.new(0, 0, 1, 0)
    TopBarLine.Size = UDim2.new(1, 0, 0, 1)
    TopBarLine.Parent = TopBar
    
    Title.Name = "Title"
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.Size = UDim2.new(1, -80, 1, 0)
    Title.Font = config.Font
    Title.Text = "Lomu Hub"
    Title.TextColor3 = config.TextColor
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar
    
    CloseButton.Name = "CloseButton"
    CloseButton.BackgroundColor3 = Color3.fromRGB(192, 57, 57)
    CloseButton.Position = UDim2.new(1, -30, 0.5, 0)
    CloseButton.AnchorPoint = Vector2.new(0, 0.5)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 12
    CloseButton.Parent = TopBar
    
    local CloseButtonCorner = Instance.new("UICorner")
    CloseButtonCorner.CornerRadius = UDim.new(0, 3)
    CloseButtonCorner.Parent = CloseButton
    
    -- Description section - more modern spacing
    Description.Name = "Description"
    Description.BackgroundTransparency = 1
    Description.Position = UDim2.new(0, 15, 0, 45)
    Description.Size = UDim2.new(1, -30, 0, 30)
    Description.Font = config.ButtonFont
    Description.Text = "Experience the future of gaming - All your favorite scripts in one place."
    Description.TextColor3 = config.SecondaryTextColor
    Description.TextSize = 14
    Description.TextWrapped = true
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.Parent = MainFrame
    
    -- Search container - better spacing
    SearchContainer.Name = "SearchContainer"
    SearchContainer.BackgroundTransparency = 1
    SearchContainer.Position = UDim2.new(0, 15, 0, 80)
    SearchContainer.Size = UDim2.new(1, -30, 0, 32)
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
    SearchIcon.Position = UDim2.new(0, 8, 0.5, 0)
    SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
    SearchIcon.Size = UDim2.new(0, 16, 0, 16)
    SearchIcon.Image = "rbxassetid://3926305904"
    SearchIcon.ImageRectOffset = Vector2.new(964, 324)
    SearchIcon.ImageRectSize = Vector2.new(36, 36)
    SearchIcon.ImageColor3 = config.SecondaryTextColor
    SearchIcon.Parent = SearchBar
    
    SearchInput.Name = "SearchInput"
    SearchInput.BackgroundTransparency = 1
    SearchInput.Position = UDim2.new(0, 32, 0, 0)
    SearchInput.Size = UDim2.new(1, -40, 1, 0)
    SearchInput.Font = Enum.Font.Gotham
    SearchInput.PlaceholderText = "Search games..."
    SearchInput.Text = ""
    SearchInput.TextColor3 = config.TextColor
    SearchInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
    SearchInput.TextSize = 14
    SearchInput.TextXAlignment = Enum.TextXAlignment.Left
    SearchInput.Parent = SearchBar
    
    -- Category container - cleaner layout
    CategoryContainer.Name = "CategoryContainer"
    CategoryContainer.BackgroundTransparency = 1
    CategoryContainer.Position = UDim2.new(0, 15, 0, 122)
    CategoryContainer.Size = UDim2.new(1, -30, 0, 25)
    CategoryContainer.Parent = MainFrame
    
    CategoryLayout.Name = "CategoryLayout"
    CategoryLayout.FillDirection = Enum.FillDirection.Horizontal
    CategoryLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    CategoryLayout.SortOrder = Enum.SortOrder.LayoutOrder
    CategoryLayout.Padding = UDim.new(0, 8)
    CategoryLayout.Parent = CategoryContainer
    
    -- Game list - better positioned
    GameList.Name = "GameList"
    GameList.BackgroundTransparency = 1
    GameList.Position = UDim2.new(0, 15, 0, 157)
    GameList.Size = UDim2.new(1, -30, 1, -172)
    GameList.CanvasSize = UDim2.new(0, 0, 0, 0)
    GameList.ScrollBarThickness = 3
    GameList.ScrollBarImageColor3 = config.AccentColor
    GameList.ScrollingDirection = Enum.ScrollingDirection.Y
    GameList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    GameList.Parent = MainFrame
    
    GameListLayout.Name = "GameListLayout"
    GameListLayout.Padding = UDim.new(0, config.ItemSpacing)
    GameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    GameListLayout.Parent = GameList
    
    -- Create initial categories
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
        CategoryButton.Font = config.ButtonFont
        CategoryButton.Text = " " .. catName .. " "
        CategoryButton.TextColor3 = config.TextColor
        CategoryButton.TextSize = 14
        CategoryButton.Parent = CategoryContainer
        
        CategoryButtonCorner.CornerRadius = config.ButtonCornerRadius
        CategoryButtonCorner.Parent = CategoryButton
        
        -- Select category on click
        CategoryButton.MouseButton1Click:Connect(function()
            if catName ~= selectedCategory then
                -- Update old selected button
                for _, btn in pairs(categoryButtons) do
                    if btn.Name == "Category_" .. selectedCategory then
                        smoothTween(btn, config.AnimationSpeedFast, {
                            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                            BackgroundTransparency = 0.5
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
                        local shouldBeVisible = (selectedCategory == "All" or gameCategory == selectedCategory)
                        
                        -- Apply search filter if exists
                        local searchText = string.lower(SearchInput.Text)
                        if searchText ~= "" then
                            local gameName = child.Name:sub(10)
                            shouldBeVisible = shouldBeVisible and string.find(string.lower(gameName), searchText)
                        end
                        
                        child.Visible = shouldBeVisible
                    end
                end
            end
        end)
        
        table.insert(categoryButtons, CategoryButton)
    end
    
    -- Close button functionality
    CloseButton.MouseButton1Click:Connect(function()
        -- Prep for clean closing animation
        local closeTween = smoothTween(MainFrame, config.AnimationSpeed, {
            Size = UDim2.new(0, MainFrame.Size.X.Offset, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        
        closeTween:Play()
        
        -- Wait for animation to complete before destroying
        closeTween.Completed:Connect(function()
            ScreenGui:Destroy()
        end)
    end)
    
    -- Hover effects for close button
    CloseButton.MouseEnter:Connect(function()
        smoothTween(CloseButton, config.AnimationSpeedFast, {
            BackgroundColor3 = Color3.fromRGB(222, 87, 87)
        }):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        smoothTween(CloseButton, config.AnimationSpeedFast, {
            BackgroundColor3 = Color3.fromRGB(192, 57, 57)
        }):Play()
    end)
    
    -- Make frame draggable
    local UserInputService = game:GetService("UserInputService")
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function updateDrag(input)
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
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateDrag(input)
        end
    end)
    
    -- Add game function
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
        local GameCorner = Instance.new("UICorner")
        local GameBorder = Instance.new("UIStroke")
        local Thumbnail = Instance.new("ImageLabel")
        local ThumbnailCorner = Instance.new("UICorner")
        local GameName = Instance.new("TextLabel")
        local LastUpdate = Instance.new("TextLabel")
        local StatusLabel = Instance.new("TextLabel")
        local StatusIndicator = Instance.new("Frame")
        local PlayButton = Instance.new("TextButton")
        local PlayButtonCorner = Instance.new("UICorner")
        
        GameItem.Name = "GameItem_" .. gameName
        GameItem.BackgroundColor3 = config.SecondaryColor
        GameItem.BackgroundTransparency = config.ElementTransparency
        GameItem.Size = UDim2.new(1, 0, 0, config.GameItemHeight)
        GameItem.Parent = GameList
        GameItem:SetAttribute("Category", gameCategory)
        
        GameCorner.CornerRadius = config.CornerRadius
        GameCorner.Parent = GameItem
        
        GameBorder.Color = config.BorderColor
        GameBorder.Thickness = 1
        GameBorder.Parent = GameItem
        
        -- Thumbnail
        Thumbnail.Name = "Thumbnail"
        Thumbnail.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Thumbnail.Position = UDim2.new(0, 8, 0.5, 0)
        Thumbnail.AnchorPoint = Vector2.new(0, 0.5)
        Thumbnail.Size = UDim2.new(0, 60, 0, 60)
        Thumbnail.Image = gameThumbnail
        Thumbnail.Parent = GameItem
        
        ThumbnailCorner.CornerRadius = UDim.new(0, 4)
        ThumbnailCorner.Parent = Thumbnail
        
        -- Game name - clean modern font
        GameName.Name = "GameName"
        GameName.BackgroundTransparency = 1
        GameName.Position = UDim2.new(0, 76, 0, 10)
        GameName.Size = UDim2.new(1, -180, 0, 18)
        GameName.Font = config.Font
        GameName.Text = gameName
        GameName.TextColor3 = config.TextColor
        GameName.TextSize = 16
        GameName.TextXAlignment = Enum.TextXAlignment.Left
        GameName.Parent = GameItem
        
        -- Last update - subtle secondary text
        LastUpdate.Name = "LastUpdate"
        LastUpdate.BackgroundTransparency = 1
        LastUpdate.Position = UDim2.new(0, 76, 0, 32)
        LastUpdate.Size = UDim2.new(1, -180, 0, 14)
        LastUpdate.Font = config.ButtonFont
        LastUpdate.Text = "Last update: " .. gameLastUpdate
        LastUpdate.TextColor3 = config.SecondaryTextColor
        LastUpdate.TextSize = 13
        LastUpdate.TextXAlignment = Enum.TextXAlignment.Left
        LastUpdate.Parent = GameItem
        
        -- Status indicator - minimalist dot
        local statusColor = config.StatusColors[gameStatus] or Color3.fromRGB(150, 150, 150)
        
        StatusIndicator.Name = "StatusIndicator"
        StatusIndicator.BackgroundColor3 = statusColor
        StatusIndicator.Position = UDim2.new(0, 76, 0, 53)
        StatusIndicator.Size = UDim2.new(0, 8, 0, 8)
        StatusIndicator.Parent = GameItem
        
        local StatusIndicatorCorner = Instance.new("UICorner")
        StatusIndicatorCorner.CornerRadius = UDim.new(1, 0)
        StatusIndicatorCorner.Parent = StatusIndicator
        
        StatusLabel.Name = "StatusLabel"
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Position = UDim2.new(0, 90, 0, 50)
        StatusLabel.Size = UDim2.new(0, 100, 0, 14)
        StatusLabel.Font = config.ButtonFont
        StatusLabel.Text = gameStatus
        StatusLabel.TextColor3 = statusColor
        StatusLabel.TextSize = 13
        StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
        StatusLabel.Parent = GameItem
        
        -- Play button - clean minimalist
        PlayButton.Name = "PlayButton"
        PlayButton.BackgroundColor3 = config.AccentColor
        PlayButton.Position = UDim2.new(1, -80, 0.5, 0)
        PlayButton.AnchorPoint = Vector2.new(0, 0.5)
        PlayButton.Size = UDim2.new(0, 70, 0, 30)
        PlayButton.Font = config.ButtonFont
        PlayButton.Text = "PLAY"
        PlayButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        PlayButton.TextSize = 14
        PlayButton.Parent = GameItem
        
        PlayButtonCorner.CornerRadius = config.ButtonCornerRadius
        PlayButtonCorner.Parent = PlayButton
        
        -- Hover effects - subtle
        PlayButton.MouseEnter:Connect(function()
            smoothTween(PlayButton, config.AnimationSpeedFast, {
                BackgroundColor3 = Color3.fromRGB(
                    math.min(config.AccentColor.R * 255 + 20, 255)/255,
                    math.min(config.AccentColor.G * 255 + 20, 255)/255,
                    math.min(config.AccentColor.B * 255 + 20, 255)/255
                ),
                Size = UDim2.new(0, 72, 0, 32)
            }):Play()
        end)
        
        PlayButton.MouseLeave:Connect(function()
            smoothTween(PlayButton, config.AnimationSpeedFast, {
                BackgroundColor3 = config.AccentColor,
                Size = UDim2.new(0, 70, 0, 30)
            }):Play()
        end)
        
        GameItem.MouseEnter:Connect(function()
            smoothTween(GameItem, config.AnimationSpeedFast, {
                BackgroundTransparency = config.ElementTransparency - 0.1
            }):Play()
        end)
        
        GameItem.MouseLeave:Connect(function()
            smoothTween(GameItem, config.AnimationSpeedFast, {
                BackgroundTransparency = config.ElementTransparency
            }):Play()
        end)
        
        -- Play button functionality
        PlayButton.MouseButton1Click:Connect(function()
            -- Visual feedback
            smoothTween(PlayButton, 0.1, {
                Size = UDim2.new(0, 68, 0, 28)
            }):Play()
            
            wait(0.1)
            
            smoothTween(PlayButton, 0.1, {
                Size = UDim2.new(0, 70, 0, 30)
            }):Play()
            
            -- Execute callback
            gameCallback()
        end)
        
        -- Search functionality
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
    
    -- Add category function
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
        CategoryButton.Font = config.ButtonFont
        CategoryButton.Text = " " .. categoryName .. " "
        CategoryButton.TextColor3 = config.TextColor
        CategoryButton.TextSize = 14
        CategoryButton.Parent = CategoryContainer
        
        CategoryButtonCorner.CornerRadius = config.ButtonCornerRadius
        CategoryButtonCorner.Parent = CategoryButton
        
        -- Select category on click
        CategoryButton.MouseButton1Click:Connect(function()
            if categoryName ~= selectedCategory then
                -- Update old selected button
                for _, btn in pairs(categoryButtons) do
                    if btn.Name == "Category_" .. selectedCategory then
                        smoothTween(btn, config.AnimationSpeedFast, {
                            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                            BackgroundTransparency = 0.5
                        }):Play()
                    end
                end
                
                -- Update new selected button
                smoothTween(CategoryButton, config.AnimationSpeedFast, {
                    BackgroundColor3 = config.AccentColor,
                    BackgroundTransparency = 0
                }):Play()
                
                selectedCategory = categoryName
                
                -- Filter games based on category
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
                        
                        child.Visible = shouldBeVisible
                    end
                end
            end
        end)
        
        table.insert(categoryButtons, CategoryButton)
        return CategoryButton
    end
    
    -- Set title
    function hub:SetTitle(titleText)
        Title.Text = titleText
    end
    
    -- Set description
    function hub:SetDescription(descText)
        Description.Text = descText
    end
    
    -- Show notification
    function hub:ShowNotification(message, duration)
        duration = duration or 3
        
        local notification = Instance.new("Frame")
        local notificationCorner = Instance.new("UICorner")
        local notificationBorder = Instance.new("UIStroke")
        local notificationText = Instance.new("TextLabel")
        
        notification.Name = "Notification"
        notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        notification.BackgroundTransparency = 0.1
        notification.Position = UDim2.new(0.5, 0, 0, -40)
        notification.AnchorPoint = Vector2.new(0.5, 0)
        notification.Size = UDim2.new(0, 0, 0, 36)
        notification.AutomaticSize = Enum.AutomaticSize.X
        notification.Parent = ScreenGui
        
        notificationCorner.CornerRadius = UDim.new(0, 4)
        notificationCorner.Parent = notification
        
        notificationBorder.Color = config.BorderColor
        notificationBorder.Thickness = 1
        notificationBorder.Parent = notification
        
        notificationText.Name = "NotificationText"
        notificationText.BackgroundTransparency = 1
        notificationText.Position = UDim2.new(0, 15, 0, 0)
        notificationText.Size = UDim2.new(0, 0, 1, 0)
        notificationText.AutomaticSize = Enum.AutomaticSize.X
        notificationText.Font = Enum.Font.Gotham
        notificationText.Text = message
        notificationText.TextColor3 = config.TextColor
        notificationText.TextSize = 14
        notificationText.Parent = notification
        
        -- Animation for showing
        smoothTween(notification, 0.5, {
            Position = UDim2.new(0.5, 0, 0, 20)
        }):Play()
        
        -- Hide after duration
        wait(duration)
        
        smoothTween(notification, 0.5, {
            Position = UDim2.new(0.5, 0, 0, -40)
        }):Play()
        
        wait(0.5)
        notification:Destroy()
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
    HubButton.TextSize = 15
    HubButton.Parent = ButtonContainer
    
    HubButtonCorner.CornerRadius = config.ButtonCornerRadius
    HubButtonCorner.Parent = HubButton
    
    -- Universal Button - matching design
    UniversalButton.Name = "UniversalButton"
    UniversalButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    UniversalButton.Size = UDim2.new(1, -20, 0, 36)
    UniversalButton.Font = config.ButtonFont
    UniversalButton.Text = "Load Lomu Universal"
    UniversalButton.TextColor3 = config.TextColor
    UniversalButton.TextSize = 15
    UniversalButton.Parent = ButtonContainer
    
    UniversalButtonCorner.CornerRadius = config.ButtonCornerRadius
    UniversalButtonCorner.Parent = UniversalButton
    
    -- Hover effects - subtle and clean
    HubButton.MouseEnter:Connect(function()
        smoothTween(HubButton, config.AnimationSpeedFast, {
            BackgroundColor3 = Color3.fromRGB(
                math.min(config.AccentColor.R * 255 + 20, 255)/255,
                math.min(config.AccentColor.G * 255 + 20, 255)/255,
                math.min(config.AccentColor.B * 255 + 20, 255)/255
            )
        }):Play()
    end)
    
    HubButton.MouseLeave:Connect(function()
        smoothTween(HubButton, config.AnimationSpeedFast, {
            BackgroundColor3 = config.AccentColor
        }):Play()
    end)
    
    UniversalButton.MouseEnter:Connect(function()
        smoothTween(UniversalButton, config.AnimationSpeedFast, {
            BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        }):Play()
    end)
    
    UniversalButton.MouseLeave:Connect(function()
        smoothTween(UniversalButton, config.AnimationSpeedFast, {
            BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        }):Play()
    end)
    
    -- Button Click Events with improved clean animations
    HubButton.MouseButton1Click:Connect(function()
        -- Visual feedback
        smoothTween(HubButton, 0.1, {
            Size = UDim2.new(1, -24, 0, 34)
        }):Play()
        
        wait(0.1)
        
        smoothTween(HubButton, 0.1, {
            Size = UDim2.new(1, -20, 0, 36)
        }):Play()
        
        -- Hide Start Menu with animation
        local hideTween = smoothTween(MainFrame, config.AnimationSpeed, {
            Position = UDim2.new(0.5, 0, 1, 100) -- Move back below screen
        })
        
        hideTween:Play()
        
        -- Wait for animation to complete before destroying
        hideTween.Completed:Connect(function()
            ScreenGui:Destroy()
            
            -- Call hub callback
            if hubCallback then
                hubCallback()
            end
        end)
    end)
    
    UniversalButton.MouseButton1Click:Connect(function()
        -- Visual feedback
        smoothTween(UniversalButton, 0.1, {
            Size = UDim2.new(1, -24, 0, 34)
        }):Play()
        
        wait(0.1)
        
        smoothTween(UniversalButton, 0.1, {
            Size = UDim2.new(1, -20, 0, 36)
        }):Play()
        
        -- Hide Start Menu with animation
        local hideTween = smoothTween(MainFrame, config.AnimationSpeed, {
            Position = UDim2.new(0.5, 0, 1, 100) -- Move back below screen
        })
        
        hideTween:Play()
        
        -- Wait for animation to complete before destroying
        hideTween.Completed:Connect(function()
            ScreenGui:Destroy()
            
            -- Call universal callback
            if universalCallback then
                universalCallback()
            end
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
        Position = UDim2.new(0.5, 0, 1, -20) -- Bottom center with small margin
    })
    
    openTween:Play()
    
    -- Functions
    function startMenu:Hide()
        local hideTween = smoothTween(MainFrame, config.AnimationSpeed, {
            Position = UDim2.new(0.5, 0, 1, 100) -- Move back below screen
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
    
    NotificationText.Name = "Text"
    NotificationText.BackgroundTransparency = 1
    NotificationText.Position = UDim2.new(0, 15, 0, 0)
    NotificationText.Size = UDim2.new(0, 0, 1, 0)
    NotificationText.AutomaticSize = Enum.AutomaticSize.X
    NotificationText.Font = Enum.Font.Gotham
    NotificationText.Text = message
    NotificationText.TextColor3 = Color3.fromRGB(255, 236, 209)
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
