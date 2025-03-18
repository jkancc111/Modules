local UILibrary = {}

-- Configuration with simplified design
local config = {
    -- Core colors
    MainColor = Color3.fromRGB(8, 12, 26),          -- Deep blue background
    SecondaryColor = Color3.fromRGB(16, 21, 39),    -- Card background
    AccentColor = Color3.fromRGB(119, 86, 255),     -- Purple accent
    AccentColorLight = Color3.fromRGB(134, 106, 255),-- Lighter purple for hover
    
    -- Text colors
    TextColor = Color3.fromRGB(235, 235, 235),      -- White text
    SecondaryTextColor = Color3.fromRGB(165, 165, 170), -- Soft gray
    
    -- UI element styling
    Font = Enum.Font.GothamSemibold,
    ButtonFont = Enum.Font.Gotham,
    CornerRadius = UDim.new(0, 12),                -- Rounded corners
    ButtonCornerRadius = UDim.new(0, 10),          -- Button rounding
    SearchBarCornerRadius = UDim.new(0, 8),        -- Search bar rounding
    
    -- Animation and effects
    AnimationSpeed = 0.5,
    AnimationSpeedFast = 0.25,
    AnimationEasingStyle = Enum.EasingStyle.Quint,
    AnimationEasingDirection = Enum.EasingDirection.Out,
    
    -- Layout and spacing
    GameItemHeight = 90,                           -- Game item height
    DefaultThumbnail = "rbxassetid://6894586021",
    Padding = 16,                                  -- Consistent padding
    ItemSpacing = 10,                              -- Space between items
    
    -- Status colors
    StatusColors = {
        ["Working"] = Color3.fromRGB(86, 180, 116),   -- Green
        ["Updated"] = Color3.fromRGB(79, 140, 201),   -- Blue
        ["Testing"] = Color3.fromRGB(220, 170, 80),   -- Yellow
        ["Patched"] = Color3.fromRGB(192, 96, 86)     -- Red
    }
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
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local SearchContainer = Instance.new("Frame")
    local SearchBar = Instance.new("Frame")
    local SearchIcon = Instance.new("ImageLabel")
    local SearchInput = Instance.new("TextBox")
    local Description = Instance.new("TextLabel")
    local CategoryContainer = Instance.new("Frame")
    local CategoryLayout = Instance.new("UIListLayout")
    local GameList = Instance.new("ScrollingFrame")
    local GameListLayout = Instance.new("UIListLayout")
    
    -- Set up ScreenGui
    ScreenGui.Name = "GamerHubLibrary"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main frame
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = config.MainColor
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Size = UDim2.new(0, 700, 0, 500)
    MainFrame.Parent = ScreenGui
    
    MainCorner.CornerRadius = config.CornerRadius
    MainCorner.Parent = MainFrame
    
    -- Top bar with title and close button
    TopBar.Name = "TopBar"
    TopBar.BackgroundTransparency = 1
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.Parent = MainFrame
    
    Title.Name = "Title"
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 20, 0, 0)
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Font = config.Font
    Title.Text = "GamerHub"
    Title.TextColor3 = config.TextColor
    Title.TextSize = 24
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar
    
    CloseButton.Name = "CloseButton"
    CloseButton.BackgroundColor3 = Color3.fromRGB(192, 57, 57)
    CloseButton.Position = UDim2.new(1, -40, 0.5, 0)
    CloseButton.AnchorPoint = Vector2.new(0, 0.5)
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 14
    CloseButton.Parent = TopBar
    
    local CloseButtonCorner = Instance.new("UICorner")
    CloseButtonCorner.CornerRadius = UDim.new(0, 6)
    CloseButtonCorner.Parent = CloseButton
    
    -- Description section
    Description.Name = "Description"
    Description.BackgroundTransparency = 1
    Description.Position = UDim2.new(0, 20, 0, 50)
    Description.Size = UDim2.new(1, -40, 0, 40)
    Description.Font = config.ButtonFont
    Description.Text = "Experience the future of gaming - All your favorite scripts in one place."
    Description.TextColor3 = config.SecondaryTextColor
    Description.TextSize = 16
    Description.TextWrapped = true
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.Parent = MainFrame
    
    -- Search container
    SearchContainer.Name = "SearchContainer"
    SearchContainer.BackgroundTransparency = 1
    SearchContainer.Position = UDim2.new(0, 20, 0, 100)
    SearchContainer.Size = UDim2.new(1, -40, 0, 40)
    SearchContainer.Parent = MainFrame
    
    -- Search bar
    SearchBar.Name = "SearchBar"
    SearchBar.BackgroundColor3 = Color3.fromRGB(14, 18, 32)
    SearchBar.Size = UDim2.new(1, 0, 1, 0)
    SearchBar.Parent = SearchContainer
    
    local SearchBarCorner = Instance.new("UICorner")
    SearchBarCorner.CornerRadius = config.SearchBarCornerRadius
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
    SearchInput.PlaceholderText = "Search games..."
    SearchInput.Text = ""
    SearchInput.TextColor3 = Color3.fromRGB(235, 235, 235)
    SearchInput.PlaceholderColor3 = Color3.fromRGB(130, 130, 135)
    SearchInput.TextSize = 14
    SearchInput.TextXAlignment = Enum.TextXAlignment.Left
    SearchInput.Parent = SearchBar
    
    -- Category container
    CategoryContainer.Name = "CategoryContainer"
    CategoryContainer.BackgroundTransparency = 1
    CategoryContainer.Position = UDim2.new(0, 20, 0, 150)
    CategoryContainer.Size = UDim2.new(1, -40, 0, 30)
    CategoryContainer.Parent = MainFrame
    
    CategoryLayout.Name = "CategoryLayout"
    CategoryLayout.FillDirection = Enum.FillDirection.Horizontal
    CategoryLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    CategoryLayout.SortOrder = Enum.SortOrder.LayoutOrder
    CategoryLayout.Padding = UDim.new(0, 10)
    CategoryLayout.Parent = CategoryContainer
    
    -- Game list
    GameList.Name = "GameList"
    GameList.BackgroundTransparency = 1
    GameList.Position = UDim2.new(0, 20, 0, 190)
    GameList.Size = UDim2.new(1, -40, 1, -210)
    GameList.CanvasSize = UDim2.new(0, 0, 0, 0)
    GameList.ScrollBarThickness = 4
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
        CategoryButton.BackgroundColor3 = (catName == selectedCategory) and config.AccentColor or Color3.fromRGB(25, 30, 50)
        CategoryButton.BackgroundTransparency = (catName == selectedCategory) and 0 or 0.5
        CategoryButton.Size = UDim2.new(0, 0, 1, 0)
        CategoryButton.AutomaticSize = Enum.AutomaticSize.X
        CategoryButton.Font = config.ButtonFont
        CategoryButton.Text = "  " .. catName .. "  "
        CategoryButton.TextColor3 = config.TextColor
        CategoryButton.TextSize = 14
        CategoryButton.Parent = CategoryContainer
        
        CategoryButtonCorner.CornerRadius = UDim.new(0, 6)
        CategoryButtonCorner.Parent = CategoryButton
        
        -- Select category on click
        CategoryButton.MouseButton1Click:Connect(function()
            if catName ~= selectedCategory then
                -- Update old selected button
                for _, btn in pairs(categoryButtons) do
                    if btn.Name == "Category_" .. selectedCategory then
                        smoothTween(btn, config.AnimationSpeedFast, {
                            BackgroundColor3 = Color3.fromRGB(25, 30, 50),
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
        -- Animation for closing
        smoothTween(MainFrame, config.AnimationSpeed, {
            Size = UDim2.new(0, MainFrame.Size.X.Offset, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        }):Play()
        
        wait(config.AnimationSpeed)
        ScreenGui:Destroy()
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
        
        -- Create game item
        local GameItem = Instance.new("Frame")
        local GameCorner = Instance.new("UICorner")
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
        GameItem.Size = UDim2.new(1, 0, 0, config.GameItemHeight)
        GameItem.Parent = GameList
        GameItem:SetAttribute("Category", gameCategory)
        
        GameCorner.CornerRadius = UDim.new(0, 8)
        GameCorner.Parent = GameItem
        
        -- Thumbnail
        Thumbnail.Name = "Thumbnail"
        Thumbnail.BackgroundColor3 = Color3.fromRGB(30, 35, 55)
        Thumbnail.Position = UDim2.new(0, 10, 0.5, 0)
        Thumbnail.AnchorPoint = Vector2.new(0, 0.5)
        Thumbnail.Size = UDim2.new(0, 70, 0, 70)
        Thumbnail.Image = gameThumbnail
        Thumbnail.Parent = GameItem
        
        ThumbnailCorner.CornerRadius = UDim.new(0, 6)
        ThumbnailCorner.Parent = Thumbnail
        
        -- Game name
        GameName.Name = "GameName"
        GameName.BackgroundTransparency = 1
        GameName.Position = UDim2.new(0, 90, 0, 15)
        GameName.Size = UDim2.new(1, -200, 0, 20)
        GameName.Font = config.Font
        GameName.Text = gameName
        GameName.TextColor3 = config.TextColor
        GameName.TextSize = 16
        GameName.TextXAlignment = Enum.TextXAlignment.Left
        GameName.Parent = GameItem
        
        -- Last update
        LastUpdate.Name = "LastUpdate"
        LastUpdate.BackgroundTransparency = 1
        LastUpdate.Position = UDim2.new(0, 90, 0, 40)
        LastUpdate.Size = UDim2.new(1, -200, 0, 16)
        LastUpdate.Font = config.ButtonFont
        LastUpdate.Text = "Last update: " .. gameLastUpdate
        LastUpdate.TextColor3 = config.SecondaryTextColor
        LastUpdate.TextSize = 14
        LastUpdate.TextXAlignment = Enum.TextXAlignment.Left
        LastUpdate.Parent = GameItem
        
        -- Status
        local statusColor = config.StatusColors[gameStatus] or Color3.fromRGB(150, 150, 150)
        
        StatusIndicator.Name = "StatusIndicator"
        StatusIndicator.BackgroundColor3 = statusColor
        StatusIndicator.Position = UDim2.new(0, 90, 0, 65)
        StatusIndicator.Size = UDim2.new(0, 8, 0, 8)
        StatusIndicator.Parent = GameItem
        
        local StatusIndicatorCorner = Instance.new("UICorner")
        StatusIndicatorCorner.CornerRadius = UDim.new(1, 0)
        StatusIndicatorCorner.Parent = StatusIndicator
        
        StatusLabel.Name = "StatusLabel"
        StatusLabel.BackgroundTransparency = 1
        StatusLabel.Position = UDim2.new(0, 105, 0, 60)
        StatusLabel.Size = UDim2.new(0, 100, 0, 16)
        StatusLabel.Font = config.ButtonFont
        StatusLabel.Text = gameStatus
        StatusLabel.TextColor3 = statusColor
        StatusLabel.TextSize = 14
        StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
        StatusLabel.Parent = GameItem
        
        -- Play button
        PlayButton.Name = "PlayButton"
        PlayButton.BackgroundColor3 = config.AccentColor
        PlayButton.Position = UDim2.new(1, -90, 0.5, 0)
        PlayButton.AnchorPoint = Vector2.new(0, 0.5)
        PlayButton.Size = UDim2.new(0, 80, 0, 36)
        PlayButton.Font = config.ButtonFont
        PlayButton.Text = "PLAY"
        PlayButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        PlayButton.TextSize = 14
        PlayButton.Parent = GameItem
        
        PlayButtonCorner.CornerRadius = UDim.new(0, 6)
        PlayButtonCorner.Parent = PlayButton
        
        -- Hover effects
        PlayButton.MouseEnter:Connect(function()
            smoothTween(PlayButton, config.AnimationSpeedFast, {
                BackgroundColor3 = config.AccentColorLight,
                Size = UDim2.new(0, 84, 0, 38)
            }):Play()
        end)
        
        PlayButton.MouseLeave:Connect(function()
            smoothTween(PlayButton, config.AnimationSpeedFast, {
                BackgroundColor3 = config.AccentColor,
                Size = UDim2.new(0, 80, 0, 36)
            }):Play()
        end)
        
        GameItem.MouseEnter:Connect(function()
            smoothTween(GameItem, config.AnimationSpeedFast, {
                BackgroundColor3 = Color3.fromRGB(
                    math.min(config.SecondaryColor.R * 255 + 10, 255)/255,
                    math.min(config.SecondaryColor.G * 255 + 10, 255)/255,
                    math.min(config.SecondaryColor.B * 255 + 10, 255)/255
                )
            }):Play()
        end)
        
        GameItem.MouseLeave:Connect(function()
            smoothTween(GameItem, config.AnimationSpeedFast, {
                BackgroundColor3 = config.SecondaryColor
            }):Play()
        end)
        
        -- Play button functionality
        PlayButton.MouseButton1Click:Connect(function()
            -- Visual feedback
            smoothTween(PlayButton, 0.1, {
                Size = UDim2.new(0, 76, 0, 34)
            }):Play()
            
            wait(0.1)
            
            smoothTween(PlayButton, 0.1, {
                Size = UDim2.new(0, 80, 0, 36)
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
        CategoryButton.BackgroundColor3 = Color3.fromRGB(25, 30, 50)
        CategoryButton.BackgroundTransparency = 0.5
        CategoryButton.Size = UDim2.new(0, 0, 1, 0)
        CategoryButton.AutomaticSize = Enum.AutomaticSize.X
        CategoryButton.Font = config.ButtonFont
        CategoryButton.Text = "  " .. categoryName .. "  "
        CategoryButton.TextColor3 = config.TextColor
        CategoryButton.TextSize = 14
        CategoryButton.Parent = CategoryContainer
        
        CategoryButtonCorner.CornerRadius = UDim.new(0, 6)
        CategoryButtonCorner.Parent = CategoryButton
        
        -- Select category on click
        CategoryButton.MouseButton1Click:Connect(function()
            if categoryName ~= selectedCategory then
                -- Update old selected button
                for _, btn in pairs(categoryButtons) do
                    if btn.Name == "Category_" .. selectedCategory then
                        smoothTween(btn, config.AnimationSpeedFast, {
                            BackgroundColor3 = Color3.fromRGB(25, 30, 50),
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
        local notificationText = Instance.new("TextLabel")
        
        notification.Name = "Notification"
        notification.BackgroundColor3 = Color3.fromRGB(30, 34, 48)
        notification.Position = UDim2.new(0.5, 0, 0, -40)
        notification.AnchorPoint = Vector2.new(0.5, 0)
        notification.Size = UDim2.new(0, 0, 0, 40)
        notification.AutomaticSize = Enum.AutomaticSize.X
        notification.Parent = ScreenGui
        
        notificationCorner.CornerRadius = UDim.new(0, 8)
        notificationCorner.Parent = notification
        
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
    
    -- Animation for opening
    MainFrame.Size = UDim2.new(0, 700, 0, 0)
    
    smoothTween(MainFrame, config.AnimationSpeed, {
        Size = UDim2.new(0, 700, 0, 500)
    }):Play()
    
    return hub
end

-- Create hub function
function UILibrary.CreateHub(customConfig)
    return UILibrary.new(customConfig)
end

return UILibrary
