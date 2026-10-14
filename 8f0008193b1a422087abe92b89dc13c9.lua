-- خدمات
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- واجهة المستخدم الرئيسية للشاشة
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HSH_TimebombUI_V30"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- المتغيرات
local SelectedLanguage = "AR"
local AutoTargetActive = false
local FastSpinActive = false
local IsTeleporting = false
local OriginalSizes = {}

local LongHitboxEnabled = false
local SquareHitboxEnabled = false
local NoclipEnabled = false
local StretchedResEnabled = false
local AvatarESPEnabled = false
local World4000Enabled = false
local InfiniteJumpEnabled = false

-- نظام الألوان
local BG_DARK = Color3.fromRGB(15, 17, 22)
local CARD_BG = Color3.fromRGB(24, 27, 36)
local ACCENT_GOLD = Color3.fromRGB(255, 200, 60)
local ACCENT_CYAN = Color3.fromRGB(0, 220, 255)
local BTN_DARK = Color3.fromRGB(32, 36, 48)
local BTN_ACTIVE = Color3.fromRGB(0, 160, 220)

local function applyGradient(instance)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, ACCENT_CYAN),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 100, 255)),
        ColorSequenceKeypoint.new(1, ACCENT_GOLD)
    })
    gradient.Rotation = 45
    gradient.Parent = instance
    return gradient
end

------------------------------------------------------------------------
-- 1. طبقة اختيار اللغة
------------------------------------------------------------------------
local LangOverlay = Instance.new("Frame")
LangOverlay.Name = "LangOverlay"
LangOverlay.Size = UDim2.new(1, 0, 1, 0)
LangOverlay.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
LangOverlay.BackgroundTransparency = 0.2
LangOverlay.ZIndex = 200
LangOverlay.Parent = ScreenGui

local LangBox = Instance.new("Frame")
LangBox.Size = UDim2.new(0, 320, 0, 200)
LangBox.Position = UDim2.new(0.5, -160, 0.5, -100)
LangBox.BackgroundColor3 = CARD_BG
LangBox.ZIndex = 201
LangBox.Parent = LangOverlay

Instance.new("UICorner", LangBox).CornerRadius = UDim.new(0, 16)
local LangStroke = Instance.new("UIStroke", LangBox)
LangStroke.Thickness = 2
applyGradient(LangStroke)

local LangTitle = Instance.new("TextLabel")
LangTitle.Size = UDim2.new(1, 0, 0, 40)
LangTitle.Position = UDim2.new(0, 0, 0, 15)
LangTitle.BackgroundTransparency = 1
LangTitle.Text = "👑 اختر اللغة / Choose Language 👑"
LangTitle.TextColor3 = ACCENT_GOLD
LangTitle.TextSize = 12
LangTitle.Font = Enum.Font.GothamBold
LangTitle.ZIndex = 202
LangTitle.Parent = LangBox

local BtnArabic = Instance.new("TextButton")
BtnArabic.Size = UDim2.new(0, 120, 0, 42)
BtnArabic.Position = UDim2.new(0.1, 0, 0.55, 0)
BtnArabic.BackgroundColor3 = BTN_DARK
BtnArabic.Text = "العربية 🇸🇦"
BtnArabic.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnArabic.Font = Enum.Font.GothamBold
BtnArabic.TextSize = 13
BtnArabic.ZIndex = 202
BtnArabic.Parent = LangBox

Instance.new("UICorner", BtnArabic).CornerRadius = UDim.new(0, 10)
local ArStroke = Instance.new("UIStroke", BtnArabic)
ArStroke.Thickness = 1.5
applyGradient(ArStroke)

local BtnEnglish = Instance.new("TextButton")
BtnEnglish.Size = UDim2.new(0, 120, 0, 42)
BtnEnglish.Position = UDim2.new(0.52, 0, 0.55, 0)
BtnEnglish.BackgroundColor3 = BTN_DARK
BtnEnglish.Text = "English 🇺🇸"
BtnEnglish.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnEnglish.Font = Enum.Font.GothamBold
BtnEnglish.TextSize = 13
BtnEnglish.ZIndex = 202
BtnEnglish.Parent = LangBox

Instance.new("UICorner", BtnEnglish).CornerRadius = UDim.new(0, 10)
local EnStroke = Instance.new("UIStroke", BtnEnglish)
EnStroke.Thickness = 1.5
applyGradient(EnStroke)

------------------------------------------------------------------------
-- 2. طبقة تحذيرية
------------------------------------------------------------------------
local WarningOverlay = Instance.new("Frame")
WarningOverlay.Name = "WarningOverlay"
WarningOverlay.Size = UDim2.new(1, 0, 1, 0)
WarningOverlay.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
WarningOverlay.BackgroundTransparency = 0.2
WarningOverlay.ZIndex = 100
WarningOverlay.Visible = false
WarningOverlay.Parent = ScreenGui

local WarningBox = Instance.new("Frame")
WarningBox.Size = UDim2.new(0, 340, 0, 220)
WarningBox.Position = UDim2.new(0.5, -170, 0.5, -110)
WarningBox.BackgroundColor3 = CARD_BG
WarningBox.ZIndex = 101
WarningBox.Parent = WarningOverlay

Instance.new("UICorner", WarningBox).CornerRadius = UDim.new(0, 16)
local WarnStroke = Instance.new("UIStroke", WarningBox)
WarnStroke.Thickness = 2
applyGradient(WarnStroke)

local DevNameTitle = Instance.new("TextLabel")
DevNameTitle.Size = UDim2.new(1, 0, 0, 30)
DevNameTitle.Position = UDim2.new(0, 0, 0, 10)
DevNameTitle.BackgroundTransparency = 1
DevNameTitle.Text = "👑 SCRIPT BY: HSH X 👑"
DevNameTitle.TextColor3 = ACCENT_GOLD
DevNameTitle.TextSize = 13
DevNameTitle.Font = Enum.Font.GothamBold
DevNameTitle.ZIndex = 102
DevNameTitle.Parent = WarningBox

local WarnText = Instance.new("TextLabel")
WarnText.Size = UDim2.new(0.9, 0, 0, 90)
WarnText.Position = UDim2.new(0.05, 0, 0.25, 0)
WarnText.BackgroundTransparency = 1
WarnText.Text = ""
WarnText.TextColor3 = Color3.fromRGB(220, 220, 220)
WarnText.TextSize = 11
WarnText.Font = Enum.Font.GothamSemibold
WarnText.TextWrapped = true
WarnText.ZIndex = 102
WarnText.Parent = WarningBox

local SkipBtn = Instance.new("TextButton")
SkipBtn.Size = UDim2.new(0, 180, 0, 36)
SkipBtn.Position = UDim2.new(0.5, -90, 0.78, 0)
SkipBtn.BackgroundColor3 = BTN_DARK
SkipBtn.Text = ""
SkipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SkipBtn.Font = Enum.Font.GothamBold
SkipBtn.TextSize = 11
SkipBtn.ZIndex = 102
SkipBtn.Parent = WarningBox

Instance.new("UICorner", SkipBtn).CornerRadius = UDim.new(0, 10)
local SkipStroke = Instance.new("UIStroke", SkipBtn)
SkipStroke.Thickness = 1.5
applyGradient(SkipStroke)

------------------------------------------------------------------------
-- 3. إطار واجهة المستخدم الرسومية الرئيسية
------------------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 480)
MainFrame.Position = UDim2.new(0.5, -210, 0.12, 0)
MainFrame.BackgroundColor3 = BG_DARK
MainFrame.Active = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 18)
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Thickness = 2.5
applyGradient(UIStroke)

-- شريط العنوان
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = CARD_BG
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 18)

local Title = Instance.new("TextLabel")
Title.Name = "TitleLabel"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "👑 HSH HUB - Don Lorenzo Edition"
Title.TextColor3 = ACCENT_GOLD
Title.TextSize = 11
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local HideBtn = Instance.new("TextButton")
HideBtn.Size = UDim2.new(0, 26, 0, 26)
HideBtn.Position = UDim2.new(1, -32, 0, 7)
HideBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 70)
HideBtn.Text = "✕"
HideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HideBtn.Font = Enum.Font.GothamBold
HideBtn.TextSize = 12
HideBtn.Parent = TitleBar
Instance.new("UICorner", HideBtn).CornerRadius = UDim.new(0, 8)

-- صورة ثابتة في الأعلى
local ImageContainer = Instance.new("Frame")
ImageContainer.Size = UDim2.new(1, -24, 0, 115)
ImageContainer.Position = UDim2.new(0, 12, 0, 46)
ImageContainer.BackgroundColor3 = CARD_BG
ImageContainer.Parent = MainFrame
Instance.new("UICorner", ImageContainer).CornerRadius = UDim.new(0, 12)

local ImageStroke = Instance.new("UIStroke", ImageContainer)
ImageStroke.Thickness = 1.5
applyGradient(ImageStroke)

local DonLorenzoImage = Instance.new("ImageLabel")
DonLorenzoImage.Name = "DonLorenzoImage"
DonLorenzoImage.Size = UDim2.new(1, -6, 1, -6)
DonLorenzoImage.Position = UDim2.new(0, 3, 0, 3)
DonLorenzoImage.BackgroundTransparency = 1
DonLorenzoImage.Image = "rbxassetid://125812693508490"
DonLorenzoImage.ScaleType = Enum.ScaleType.Fit
DonLorenzoImage.Parent = ImageContainer
Instance.new("UICorner", DonLorenzoImage).CornerRadius = UDim.new(0, 10)

------------------------------------------------------------------------
-- نظام التنقل باستخدام علامات التبويب
------------------------------------------------------------------------
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 110, 0, 300)
Sidebar.Position = UDim2.new(1, -122, 0, 168)
Sidebar.BackgroundColor3 = CARD_BG
Sidebar.Parent = MainFrame
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 12)

local SideStroke = Instance.new("UIStroke", Sidebar)
SideStroke.Thickness = 1.2
applyGradient(SideStroke)

local TabButton1 = Instance.new("TextButton")
TabButton1.Size = UDim2.new(0.9, 0, 0, 40)
TabButton1.Position = UDim2.new(0.05, 0, 0, 10)
TabButton1.BackgroundColor3 = BTN_ACTIVE
TabButton1.Text = "🥊 COMBAT"
TabButton1.TextColor3 = Color3.fromRGB(255, 255, 255)
TabButton1.Font = Enum.Font.GothamBold
TabButton1.TextSize = 10
TabButton1.Parent = Sidebar
Instance.new("UICorner", TabButton1).CornerRadius = UDim.new(0, 8)

local TabButton2 = Instance.new("TextButton")
TabButton2.Size = UDim2.new(0.9, 0, 0, 40)
TabButton2.Position = UDim2.new(0.05, 0, 0, 60)
TabButton2.BackgroundColor3 = BTN_DARK
TabButton2.Text = "⚡ MOVEMENT"
TabButton2.TextColor3 = Color3.fromRGB(200, 200, 200)
TabButton2.Font = Enum.Font.GothamBold
TabButton2.TextSize = 10
TabButton2.Parent = Sidebar
Instance.new("UICorner", TabButton2).CornerRadius = UDim.new(0, 8)

local TabButton3 = Instance.new("TextButton")
TabButton3.Size = UDim2.new(0.9, 0, 0, 40)
TabButton3.Position = UDim2.new(0.05, 0, 0, 110)
TabButton3.BackgroundColor3 = BTN_DARK
TabButton3.Text = "🔘 CONTROLS"
TabButton3.TextColor3 = Color3.fromRGB(200, 200, 200)
TabButton3.Font = Enum.Font.GothamBold
TabButton3.TextSize = 10
TabButton3.Parent = Sidebar
Instance.new("UICorner", TabButton3).CornerRadius = UDim.new(0, 8)

local PagesContainer = Instance.new("Frame")
PagesContainer.Size = UDim2.new(0, 270, 0, 300)
PagesContainer.Position = UDim2.new(0, 12, 0, 168)
PagesContainer.BackgroundTransparency = 1
PagesContainer.Parent = MainFrame

local Page1 = Instance.new("Frame")
Page1.Size = UDim2.new(1, 0, 1, 0)
Page1.BackgroundTransparency = 1
Page1.Visible = true
Page1.Parent = PagesContainer

local Page2 = Instance.new("Frame")
Page2.Size = UDim2.new(1, 0, 1, 0)
Page2.BackgroundTransparency = 1
Page2.Visible = false
Page2.Parent = PagesContainer

local Page3 = Instance.new("Frame")
Page3.Size = UDim2.new(1, 0, 1, 0)
Page3.BackgroundTransparency = 1
Page3.Visible = false
Page3.Parent = PagesContainer

local function switchTab(activePage, activeBtn)
    Page1.Visible = (activePage == Page1)
    Page2.Visible = (activePage == Page2)
    Page3.Visible = (activePage == Page3)

    TabButton1.BackgroundColor3 = (activeBtn == TabButton1) and BTN_ACTIVE or BTN_DARK
    TabButton2.BackgroundColor3 = (activeBtn == TabButton2) and BTN_ACTIVE or BTN_DARK
    TabButton3.BackgroundColor3 = (activeBtn == TabButton3) and BTN_ACTIVE or BTN_DARK

    TabButton1.TextColor3 = (activeBtn == TabButton1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
    TabButton2.TextColor3 = (activeBtn == TabButton2) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
    TabButton3.TextColor3 = (activeBtn == TabButton3) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
end

TabButton1.Activated:Connect(function() switchTab(Page1, TabButton1) end)
TabButton2.Activated:Connect(function() switchTab(Page2, TabButton2) end)
TabButton3.Activated:Connect(function() switchTab(Page3, TabButton3) end)

------------------------------------------------------------------------
-- منشئ أزرار الصفحة
------------------------------------------------------------------------
local function styleMenuButton(btn, parentFrame, yPos)
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = BTN_DARK
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.Parent = parentFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 1.2
    applyGradient(stroke)
end

-- الصفحة 1
local LongBtn = Instance.new("TextButton")
styleMenuButton(LongBtn, Page1, 10)
local SquareBtn = Instance.new("TextButton")
styleMenuButton(SquareBtn, Page1, 55)
local NoclipBtn = Instance.new("TextButton")
styleMenuButton(NoclipBtn, Page1, 100)

-- الصفحة 2
local InfJumpToggleBtn = Instance.new("TextButton")
styleMenuButton(InfJumpToggleBtn, Page2, 10)
local StretchBtn = Instance.new("TextButton")
styleMenuButton(StretchBtn, Page2, 55)
local AvatarESPBtn = Instance.new("TextButton")
styleMenuButton(AvatarESPBtn, Page2, 100)
local World4000Btn = Instance.new("TextButton")
styleMenuButton(World4000Btn, Page2, 145)

-- الصفحة 3 (التحكم)
local ShowAutoTargetBtnMenu = Instance.new("TextButton")
styleMenuButton(ShowAutoTargetBtnMenu, Page3, 10)
local ShowTPBtnMenu = Instance.new("TextButton")
styleMenuButton(ShowTPBtnMenu, Page3, 55)
local ShowJumpBtnMenu = Instance.new("TextButton")
styleMenuButton(ShowJumpBtnMenu, Page3, 100)

-- زر الفتح الأساسي
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 140, 0, 40)
OpenBtn.Position = UDim2.new(0.02, 0, 0.25, 0)
OpenBtn.BackgroundColor3 = CARD_BG
OpenBtn.Text = "👑 OPEN MENU"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextSize = 10
OpenBtn.Visible = false
OpenBtn.Active = true
OpenBtn.Parent = ScreenGui

Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 12)
local OpenStroke = Instance.new("UIStroke", OpenBtn)
OpenStroke.Thickness = 2
applyGradient(OpenStroke)

------------------------------------------------------------------------
-- الأزرار العائمة والخارجية
------------------------------------------------------------------------
local AutoSpinMasterContainer = Instance.new("Frame")
AutoSpinMasterContainer.Name = "AutoSpinMasterContainer"
AutoSpinMasterContainer.Size = UDim2.new(0, 140, 0, 95)
AutoSpinMasterContainer.Position = UDim2.new(0.02, 0, 0.35, 0)
AutoSpinMasterContainer.BackgroundTransparency = 1
AutoSpinMasterContainer.Visible = false
AutoSpinMasterContainer.Parent = ScreenGui

local MasterHeaderLabel = Instance.new("TextLabel")
MasterHeaderLabel.Name = "MasterHeaderLabel"
MasterHeaderLabel.Size = UDim2.new(1, 0, 0, 18)
MasterHeaderLabel.Position = UDim2.new(0, 0, 0, 0)
MasterHeaderLabel.BackgroundTransparency = 1
MasterHeaderLabel.Text = "👑 Don Lorenzo 👑"
MasterHeaderLabel.TextColor3 = ACCENT_GOLD
MasterHeaderLabel.Font = Enum.Font.GothamBold
MasterHeaderLabel.TextSize = 9
MasterHeaderLabel.Parent = AutoSpinMasterContainer

local FloatAutoBtn = Instance.new("TextButton")
FloatAutoBtn.Name = "FloatAutoButton"
FloatAutoBtn.Size = UDim2.new(1, 0, 0, 35)
FloatAutoBtn.Position = UDim2.new(0, 0, 0, 18)
FloatAutoBtn.BackgroundColor3 = CARD_BG
FloatAutoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatAutoBtn.Font = Enum.Font.GothamBold
FloatAutoBtn.TextSize = 9
FloatAutoBtn.Active = true
FloatAutoBtn.Parent = AutoSpinMasterContainer

Instance.new("UICorner", FloatAutoBtn).CornerRadius = UDim.new(0, 10)
local autoStroke = Instance.new("UIStroke", FloatAutoBtn)
autoStroke.Thickness = 2
applyGradient(autoStroke)

local FloatSpinBtn = Instance.new("TextButton")
FloatSpinBtn.Name = "FloatSpinBtn"
FloatSpinBtn.Size = UDim2.new(1, 0, 0, 35)
FloatSpinBtn.Position = UDim2.new(0, 0, 0, 56)
FloatSpinBtn.BackgroundColor3 = CARD_BG
FloatSpinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatSpinBtn.Font = Enum.Font.GothamBold
FloatSpinBtn.TextSize = 9
FloatSpinBtn.Active = true
FloatSpinBtn.Parent = AutoSpinMasterContainer

Instance.new("UICorner", FloatSpinBtn).CornerRadius = UDim.new(0, 10)
local spinStroke = Instance.new("UIStroke", FloatSpinBtn)
spinStroke.Thickness = 2
applyGradient(spinStroke)

local function createCustomFloatingButton(name, pos, defaultColor)
    local container = Instance.new("Frame")
    container.Name = name .. "Container"
    container.Size = UDim2.new(0, 140, 0, 55)
    container.Position = pos
    container.BackgroundTransparency = 1
    container.Visible = false
    container.Parent = ScreenGui

    local headerLabel = Instance.new("TextLabel")
    headerLabel.Size = UDim2.new(1, 0, 0, 16)
    headerLabel.Position = UDim2.new(0, 0, 0, 0)
    headerLabel.BackgroundTransparency = 1
    headerLabel.Text = "👑 Don Lorenzo 👑"
    headerLabel.TextColor3 = ACCENT_GOLD
    headerLabel.Font = Enum.Font.GothamBold
    headerLabel.TextSize = 8
    headerLabel.Parent = container

    local mainBtn = Instance.new("TextButton")
    mainBtn.Name = name
    mainBtn.Size = UDim2.new(1, 0, 0, 35)
    mainBtn.Position = UDim2.new(0, 0, 0, 16)
    mainBtn.BackgroundColor3 = defaultColor
    mainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    mainBtn.Font = Enum.Font.GothamBold
    mainBtn.TextSize = 9
    mainBtn.Active = true
    mainBtn.Parent = container

    Instance.new("UICorner", mainBtn).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", mainBtn)
    stroke.Thickness = 2
    applyGradient(stroke)

    return container, mainBtn
end

local TPContainer, FloatTPBtn = createCustomFloatingButton("FloatTPButton", UDim2.new(0.02, 0, 0.52, 0), CARD_BG)

local JumpBtn = Instance.new("TextButton")
JumpBtn.Size = UDim2.new(0, 68, 0, 68)
JumpBtn.Position = UDim2.new(1, -100, 1, -120)
JumpBtn.BackgroundColor3 = BTN_DARK
JumpBtn.Text = "🚀 JUMP"
JumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpBtn.Font = Enum.Font.GothamBold
JumpBtn.TextSize = 11
JumpBtn.Visible = false
JumpBtn.Active = true
JumpBtn.Parent = ScreenGui

Instance.new("UICorner", JumpBtn).CornerRadius = UDim.new(1, 0)
local JumpStroke = Instance.new("UIStroke", JumpBtn)
JumpStroke.Thickness = 2.5
applyGradient(JumpStroke)

-- وظيفة السحب
local function makeDraggable(guiObject, handleObject)
    local dragging, dragInput, dragStart, startPos
    handleObject = handleObject or guiObject

    handleObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handleObject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

makeDraggable(MainFrame, TitleBar)
makeDraggable(OpenBtn, OpenBtn)
makeDraggable(AutoSpinMasterContainer, MasterHeaderLabel)
makeDraggable(AutoSpinMasterContainer, FloatAutoBtn)
makeDraggable(AutoSpinMasterContainer, FloatSpinBtn)
makeDraggable(TPContainer, FloatTPBtn)

HideBtn.Activated:Connect(function() MainFrame.Visible = false; OpenBtn.Visible = true end)
OpenBtn.Activated:Connect(function() MainFrame.Visible = true; OpenBtn.Visible = false end)

local function updateTexts()
    if SelectedLanguage == "AR" then
        Title.Text = "👑 HSH HUB - إصدار Don Lorenzo"
        MasterHeaderLabel.Text = "👑 Don Lorenzo 👑"
        WarnText.Text = "⚠️ تنبيه ⚠️\nهذا السكريبت مصمم خصيصًا للعبة Timebomb Tag فقط!\nاستخدامه في ألعاب أخرى قد يسبب مشاكل."
        SkipBtn.Text = "تخطي / متابعة ➔"
        
        TabButton1.Text = "🥊 القتال"
        TabButton2.Text = "⚡ الحركة"
        TabButton3.Text = "🔘 التحكم"

        OpenBtn.Text = "👑 فتح القائمة"
        FloatAutoBtn.Text = AutoTargetActive and "🎯 الأوتو الذكي: مفعل" or "🎯 الأوتو الذكي: معطل"
        FloatSpinBtn.Text = FastSpinActive and "🌀 الدوران الذكي: مفعل" or "🌀 الدوران الذكي: معطل"
        FloatTPBtn.Text = IsTeleporting and "⚡ جاري الالتصاق (1ث)..." or "⚡ أم الصواعق (داخلهم)"
        JumpBtn.Text = "🚀 اقفز"

        LongBtn.Text = LongHitboxEnabled and "هيت بوكس طولي: مفعل" or "هيت بوكس طولي: معطل"
        SquareBtn.Text = SquareHitboxEnabled and "هيت بوكس مربع: مفعل" or "هيت بوكس مربع: معطل"
        InfJumpToggleBtn.Text = InfiniteJumpEnabled and "🚀 قفز لا نهائي: مفعل" or "🚀 قفز لا نهائي: معطل"
        NoclipBtn.Text = NoclipEnabled and "اختراق اللاعبين: مفعل" or "اختراق اللاعبين: معطل"
        StretchBtn.Text = StretchedResEnabled and "🖥️ شاشة ممتدة: مفعل" or "🖥️ شاشة ممتدة: معطل"
        AvatarESPBtn.Text = AvatarESPEnabled and "صور الحسابات والمسافة: مفعل" or "صور الحسابات والمسافة: معطل"
        World4000Btn.Text = World4000Enabled and "✨ عالم 4000: مفعل" or "✨ عالم 4000: معطل"

        ShowAutoTargetBtnMenu.Text = AutoSpinMasterContainer.Visible and "🎯 زر الأوتو والدوران: مفعل" or "🎯 زر الأوتو والدوران: معطل"
        ShowTPBtnMenu.Text = TPContainer.Visible and "⚡ زر الصواعق: مفعل" or "⚡ زر الصواعق: معطل"
        ShowJumpBtnMenu.Text = JumpBtn.Visible and "🚀 زر القفز: مفعل" or "🚀 زر القفز: معطل"
    else
        Title.Text = "👑 HSH HUB - Don Lorenzo Edition"
        MasterHeaderLabel.Text = "👑 Don Lorenzo 👑"
        WarnText.Text = "⚠️ WARNING ⚠️\nThis script is designed specifically for Timebomb Tag only!\nUsing it in other games may cause errors."
        SkipBtn.Text = "Skip / Continue ➔"

        TabButton1.Text = "🥊 COMBAT"
        TabButton2.Text = "⚡ MOVEMENT"
        TabButton3.Text = "🔘 CONTROLS"

        OpenBtn.Text = "👑 OPEN MENU"
        FloatAutoBtn.Text = AutoTargetActive and "🎯 SMART AUTO: ON" or "🎯 SMART AUTO: OFF"
        FloatSpinBtn.Text = FastSpinActive and "🌀 SMART SPIN: ON" or "🌀 SMART SPIN: OFF"
        FloatTPBtn.Text = IsTeleporting and "⚡ ATTACHED (1S)..." or "⚡ MOTHER THUNDER (INSIDE)"
        JumpBtn.Text = "🚀 JUMP"

        LongBtn.Text = LongHitboxEnabled and "WIDE LONG HITBOX: ON" or "WIDE LONG HITBOX: OFF"
        SquareBtn.Text = SquareHitboxEnabled and "SQUARE HITBOX: ON" or "SQUARE HITBOX: OFF"
        InfJumpToggleBtn.Text = InfiniteJumpEnabled and "🚀 INFINITE JUMP: ON" or "🚀 INFINITE JUMP: OFF"
        NoclipBtn.Text = NoclipEnabled and "NOCLIP PLAYERS: ON" or "NOCLIP PLAYERS: OFF"
        StretchBtn.Text = StretchedResEnabled and "🖥️ STRETCHED RES: ON" or "🖥️ STRETCHED RES: OFF"
        AvatarESPBtn.Text = AvatarESPEnabled and "AVATARS & DISTANCE ESP: ON" or "AVATARS & DISTANCE ESP: ON"
        World4000Btn.Text = World4000Enabled and "✨ WORLD 4000: ON" or "✨ WORLD 4000: OFF"

        ShowAutoTargetBtnMenu.Text = AutoSpinMasterContainer.Visible and "🎯 AUTO & SPIN BTNS: ON" or "🎯 AUTO & SPIN BTNS: OFF"
        ShowTPBtnMenu.Text = TPContainer.Visible and "⚡ THUNDER BTN: ON" or "⚡ THUNDER BTN: OFF"
        ShowJumpBtnMenu.Text = JumpBtn.Visible and "🚀 JUMP BTN: ON" or "🚀 JUMP BTN: OFF"
    end
end

BtnArabic.Activated:Connect(function()
    SelectedLanguage = "AR"
    LangOverlay:Destroy()
    WarningOverlay.Visible = true
    updateTexts()
end)

BtnEnglish.Activated:Connect(function()
    SelectedLanguage = "EN"
    LangOverlay:Destroy()
    WarningOverlay.Visible = true
    updateTexts()
end)

SkipBtn.Activated:Connect(function()
    WarningOverlay:Destroy()
    MainFrame.Visible = true
    AutoSpinMasterContainer.Visible = false
    TPContainer.Visible = false
end)

ShowAutoTargetBtnMenu.Activated:Connect(function()
    AutoSpinMasterContainer.Visible = not AutoSpinMasterContainer.Visible
    updateTexts()
end)

ShowTPBtnMenu.Activated:Connect(function() TPContainer.Visible = not TPContainer.Visible; updateTexts() end)
ShowJumpBtnMenu.Activated:Connect(function() JumpBtn.Visible = not JumpBtn.Visible; updateTexts() end)

FloatAutoBtn.Activated:Connect(function()
    AutoTargetActive = not AutoTargetActive
    FloatAutoBtn.BackgroundColor3 = AutoTargetActive and Color3.fromRGB(200, 40, 40) or CARD_BG
    updateTexts()
end)

FloatSpinBtn.Activated:Connect(function()
    FastSpinActive = not FastSpinActive
    FloatSpinBtn.BackgroundColor3 = FastSpinActive and Color3.fromRGB(220, 120, 0) or CARD_BG
    updateTexts()
end)

InfJumpToggleBtn.Activated:Connect(function()
    InfiniteJumpEnabled = not InfiniteJumpEnabled
    InfJumpToggleBtn.BackgroundColor3 = InfiniteJumpEnabled and BTN_ACTIVE or BTN_DARK
    updateTexts()
end)

------------------------------------------------------------------------
-- نظام القفز والقفز اللانهائي
------------------------------------------------------------------------
local function executeNormalJump()
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        local hum = char:FindFirstChildOfClass("Humanoid")
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end

JumpBtn.Activated:Connect(executeNormalJump)

UserInputService.JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        executeNormalJump()
    end
end)

------------------------------------------------------------------------
-- وظائف مساعدة
------------------------------------------------------------------------
local function isInGame()
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return false end
    local myHum = myChar:FindFirstChildOfClass("Humanoid")
    return myHum and myHum.Health > 0
end

local function getBombTool()
    local myChar = LocalPlayer.Character
    if not myChar then return nil end
    local toolInHand = myChar:FindFirstChildOfClass("Tool")
    if toolInHand then return toolInHand end
    return LocalPlayer.Backpack and LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
end

local function hasBomb()
    return getBombTool() ~= nil
end

local function isEnemyValidInRound(player)
    if not player or player == LocalPlayer or not player.Character then return false end
    local char = player.Character
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")

    if not hrp or not hum or hum.Health <= 0 then return false end
    if char:FindFirstChild("Dead") or char:FindFirstChild("Spectator") or player:FindFirstChild("IsDead") then return false end
    if LocalPlayer.Team and player.Team and LocalPlayer.Team == player.Team then return false end

    return true
end

local function getClosestEnemyTarget()
    if not isInGame() then return nil end
    local myHrp = LocalPlayer.Character.HumanoidRootPart
    local nearestTarget = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        if isEnemyValidInRound(player) then
            local targetHrp = player.Character.HumanoidRootPart
            local distance = (myHrp.Position - targetHrp.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestTarget = player
            end
        end
    end
    return nearestTarget
end

------------------------------------------------------------------------
-- نظام الأوتو والدوران
------------------------------------------------------------------------
local currentSpinAngle = 0

RunService.RenderStepped:Connect(function(deltaTime)
    if not isInGame() then return end
    
    local myChar = LocalPlayer.Character
    local myHrp = myChar:FindFirstChild("HumanoidRootPart")
    local myHum = myChar:FindFirstChildOfClass("Humanoid")
    
    if not myHrp or not myHum then return end

    if FastSpinActive and hasBomb() then
        currentSpinAngle = (currentSpinAngle + (deltaTime * 5000)) % 360
        myHrp.CFrame = CFrame.new(myHrp.Position) * CFrame.Angles(0, math.rad(currentSpinAngle), 0)
    end

    if AutoTargetActive and hasBomb() then
        local nearestEnemy = getClosestEnemyTarget()
        if nearestEnemy and nearestEnemy.Character then
            local targetHrp = nearestEnemy.Character:FindFirstChild("HumanoidRootPart")
            if targetHrp then
                myHum:MoveTo(targetHrp.Position)
            end
        end
    end
end)

-- زر أم الصواعق
FloatTPBtn.Activated:Connect(function()
    if IsTeleporting or not isInGame() or not hasBomb() then return end
    
    local myChar = LocalPlayer.Character
    local myHrp = myChar.HumanoidRootPart
    local enemy = getClosestEnemyTarget()
    
    if enemy and enemy.Character then
        local enemyTorso = enemy.Character:FindFirstChild("HumanoidRootPart") or enemy.Character:FindFirstChild("Torso")
        if enemyTorso then
            IsTeleporting = true
            FloatTPBtn.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
            updateTexts()
            
            local originalCFrame = myHrp.CFrame
            local startTime = tick()
            local connection
            
            connection = RunService.Heartbeat:Connect(function()
                if not isEnemyValidInRound(enemy) then
                    if connection then connection:Disconnect() end
                    return
                end

                if tick() - startTime < 1 then
                    if enemyTorso and enemyTorso.Parent and myHrp and myHrp.Parent then
                        myHrp.CFrame = enemyTorso.CFrame
                    end
                else
                    if connection then connection:Disconnect() end
                end
            end)
            
            task.wait(1)
            if connection then connection:Disconnect() end
            
            if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                myHrp.CFrame = originalCFrame
            end
            
            FloatTPBtn.BackgroundColor3 = CARD_BG
            IsTeleporting = false
            updateTexts()
        end
    end
end)

-- العالم 4000
local originalLightingSettings = {
    ClockTime = Lighting.ClockTime,
    Brightness = Lighting.Brightness,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    GlobalShadows = Lighting.GlobalShadows,
    FogEnd = Lighting.FogEnd
}

local function toggleWorld4000(state)
    if state then
        Lighting.ClockTime = 18.5
        Lighting.Brightness = 2.5
        Lighting.OutdoorAmbient = Color3.fromRGB(150, 80, 220)
        Lighting.GlobalShadows = true
        Lighting.FogColor = Color3.fromRGB(40, 10, 60)
        Lighting.FogEnd = 1200

        local bloom = Lighting:FindFirstChild("World4000Bloom") or Instance.new("BloomEffect")
        bloom.Name = "World4000Bloom"
        bloom.Intensity = 0.8
        bloom.Size = 24
        bloom.Threshold = 0.8
        bloom.Parent = Lighting

        local colorCorr = Lighting:FindFirstChild("World4000CC") or Instance.new("ColorCorrectionEffect")
        colorCorr.Name = "World4000CC"
        colorCorr.Brightness = 0.05
        colorCorr.Contrast = 0.25
        colorCorr.Saturation = 0.35
        colorCorr.TintColor = Color3.fromRGB(255, 230, 255)
        colorCorr.Parent = Lighting
    else
        Lighting.ClockTime = originalLightingSettings.ClockTime
        Lighting.Brightness = originalLightingSettings.Brightness
        Lighting.OutdoorAmbient = originalLightingSettings.OutdoorAmbient
        Lighting.GlobalShadows = originalLightingSettings.GlobalShadows
        Lighting.FogEnd = originalLightingSettings.FogEnd

        local bloom = Lighting:FindFirstChild("World4000Bloom")
        if bloom then bloom:Destroy() end
        local colorCorr = Lighting:FindFirstChild("World4000CC")
        if colorCorr then colorCorr:Destroy() end
    end
end

World4000Btn.Activated:Connect(function()
    World4000Enabled = not World4000Enabled
    World4000Btn.BackgroundColor3 = World4000Enabled and BTN_ACTIVE or BTN_DARK
    toggleWorld4000(World4000Enabled)
    updateTexts()
end)

-- نظام عرض صور الحسابات والمسافة الديناميكية فوق الرؤوس
local function createAvatarESP(player)
    if not player.Character then return end
    local head = player.Character:FindFirstChild("Head")
    if not head then return end

    local billboard = head:FindFirstChild("AvatarESP")
    if not billboard then
        billboard = Instance.new("BillboardGui")
        billboard.Name = "AvatarESP"
        billboard.Size = UDim2.new(0, 60, 0, 75)
        billboard.StudsOffset = Vector3.new(0, 3.2, 0)
        billboard.AlwaysOnTop = true
        billboard.Adornee = head
        billboard.Parent = head

        local img = Instance.new("ImageLabel")
        img.Size = UDim2.new(0, 40, 0, 40)
        img.Position = UDim2.new(0.5, -20, 0, 0)
        img.BackgroundTransparency = 1
        img.Parent = billboard

        task.spawn(function()
            local thumb = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
            if img and img.Parent then img.Image = thumb end
        end)

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = img

        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 1.5
        stroke.Color = ACCENT_GOLD
        stroke.Parent = img

        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "DistLabel"
        textLabel.Size = UDim2.new(1, 0, 0, 22)
        textLabel.Position = UDim2.new(0, 0, 1, -22)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = ACCENT_GOLD
        textLabel.TextStrokeTransparency = 0
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextSize = 10
        textLabel.Parent = billboard
    end
end

local function removeAvatarESP(player)
    if player.Character and player.Character:FindFirstChild("Head") then
        local esp = player.Character.Head:FindFirstChild("AvatarESP")
        if esp then esp:Destroy() end
    end
end

AvatarESPBtn.Activated:Connect(function()
    AvatarESPEnabled = not AvatarESPEnabled
    AvatarESPBtn.BackgroundColor3 = AvatarESPEnabled and BTN_ACTIVE or BTN_DARK
    updateTexts()
    if not AvatarESPEnabled then
        for _, plr in pairs(Players:GetPlayers()) do removeAvatarESP(plr) end
    end
end)

-- مفاتيح تبديل الهيد بوكس
LongBtn.Activated:Connect(function()
    LongHitboxEnabled = not LongHitboxEnabled
    if LongHitboxEnabled then SquareHitboxEnabled = false end
    LongBtn.BackgroundColor3 = LongHitboxEnabled and BTN_ACTIVE or BTN_DARK
    SquareBtn.BackgroundColor3 = BTN_DARK
    updateTexts()
end)

SquareBtn.Activated:Connect(function()
    SquareHitboxEnabled = not SquareHitboxEnabled
    if SquareHitboxEnabled then LongHitboxEnabled = false end
    SquareBtn.BackgroundColor3 = SquareHitboxEnabled and BTN_ACTIVE or BTN_DARK
    LongBtn.BackgroundColor3 = BTN_DARK
    updateTexts()
end)

NoclipBtn.Activated:Connect(function()
    NoclipEnabled = not NoclipEnabled
    NoclipBtn.BackgroundColor3 = NoclipEnabled and BTN_ACTIVE or BTN_DARK
    updateTexts()
end)

StretchBtn.Activated:Connect(function()
    StretchedResEnabled = not StretchedResEnabled
    if StretchedResEnabled then
        StretchBtn.BackgroundColor3 = BTN_ACTIVE
        pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Stretched-Resolution-Higher-FOV-48170"))() end)
    else
        StretchBtn.BackgroundColor3 = BTN_DARK
        if Camera then Camera.FieldOfView = 70 end
    end
    updateTexts()
end)

------------------------------------------------------------------------
-- حلقة التحديث الرئيسية
------------------------------------------------------------------------
RunService.Stepped:Connect(function()
    if not isInGame() then return end
    local anyHitboxOn = LongHitboxEnabled or SquareHitboxEnabled
    local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")

            if AvatarESPEnabled then
                createAvatarESP(player)
                local head = char:FindFirstChild("Head")
                if head and myHrp and hrp then
                    local esp = head:FindFirstChild("AvatarESP")
                    if esp and esp:FindFirstChild("DistLabel") then
                        local dist = math.floor((myHrp.Position - hrp.Position).Magnitude)
                        esp.DistLabel.Text = dist .. "m"
                    end
                end
            else
                removeAvatarESP(player)
            end

            if hrp then
                local box = hrp:FindFirstChild("R6_BoxESP")
                if box then box:Destroy() end
            end

            if NoclipEnabled or anyHitboxOn then
                for _, child in pairs(char:GetChildren()) do
                    if child:IsA("BasePart") then
                        child.CanCollide = false
                    end
                end
            end

            local Limbs = {
                "Left Arm", "Right Arm", "Left Leg", "Right Leg",
                "UpperLeftArm", "UpperRightArm", "LowerLeftArm", "LowerRightArm", "LeftHand", "RightHand",
                "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg", "LeftFoot", "RightFoot",
                "Torso", "UpperTorso", "LowerTorso"
            }
            
            for _, partName in pairs(Limbs) do
                local part = char:FindFirstChild(partName)
                if part and part:IsA("BasePart") then
                    if not OriginalSizes[part] then
                        OriginalSizes[part] = part.Size
                    end

                    if LongHitboxEnabled then
                        if partName:find("Arm") or partName:find("Leg") or partName:find("Hand") or partName:find("Foot") or partName:find("Torso") then
                            if part.Size ~= Vector3.new(20, 40, 20) then
                                part.Size = Vector3.new(20, 40, 20)
                                part.Transparency = 0.55
                                part.CanCollide = false
                                part.Massless = true
                            end
                        end
                    elseif SquareHitboxEnabled then
                        if part.Size ~= Vector3.new(18, 18, 18) then
                            part.Size = Vector3.new(18, 18, 18)
                            part.Transparency = 0.55
                            part.CanCollide = false
                            part.Massless = true
                        end
                    else
                        if OriginalSizes[part] and part.Size ~= OriginalSizes[part] then
                            part.Size = OriginalSizes[part]
                            part.Transparency = 0
                            part.Massless = false
                        end
                    end
                end
            end
        else
            removeAvatarESP(player)
        end
    end
end)

Players.PlayerRemoving:Connect(function(player)
    removeAvatarESP(player)
end)
