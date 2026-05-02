local UILibrary = {}
UILibrary.__index = UILibrary

local pl  = game:GetService("Players")
local ui  = game:GetService("UserInputService")
local tw  = game:GetService("TweenService")
local ss  = game:GetService("SoundService")
local db  = game:GetService("Debris")
local hs  = game:GetService("HttpService")
local lp  = pl.LocalPlayer
local cg  = game:GetService("CoreGui")

local guiParent = cg
do
	local ok = pcall(function()
		local sg = Instance.new("ScreenGui")
		sg.Parent = cg
		sg:Destroy()
	end)
	if not ok then
		guiParent = lp:WaitForChild("PlayerGui")
	end
end

local notifQueue      = {}
local notifGap        = 10
local notifBaseY      = 200
local guiCounter      = 0
local activeInstances = {}
local activeSounds    = {}

local globalFlags = {}

local CONFIG_FOLDER = "AK_ADMIN_CONFIGS"

local function make(className, props)
	local obj = Instance.new(className)
	for k, v in pairs(props or {}) do
		obj[k] = v
	end
	return obj
end

local function addCorner(parent, radius)
	local c = make("UICorner", { CornerRadius = UDim.new(0, radius or 10) })
	c.Parent = parent
	return c
end

local function tween(obj, goals, duration, style, direction)
	local t = tw:Create(obj, TweenInfo.new(
		duration or 0.25,
		style     or Enum.EasingStyle.Quint,
		direction or Enum.EasingDirection.Out
	), goals)
	t:Play()
	return t
end

local function makeRow(parent, layoutOrder)
	local row = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundColor3       = Color3.fromRGB(20, 20, 20),
		BackgroundTransparency = 0.4,
		BorderSizePixel        = 0,
		LayoutOrder            = layoutOrder or 1,
		Parent                 = parent,
	})
	addCorner(row, 10)
	make("UIPadding", {
		PaddingTop    = UDim.new(0, 5),
		PaddingBottom = UDim.new(0, 5),
		Parent        = row,
	})
	return row
end

local function makeOrderCounter()
	local n = 0
	return function()
		n = n + 1
		return n
	end
end

local function playSound()
	for i = #activeSounds, 1, -1 do
		if not activeSounds[i] or not activeSounds[i].Parent then
			table.remove(activeSounds, i)
		end
	end
	if #activeSounds < 8 then
		local sd = make("Sound", {
			SoundId = "rbxassetid://3023237993",
			Volume  = 0.5,
			Parent  = ss,
		})
		sd:Play()
		table.insert(activeSounds, sd)
		db:AddItem(sd, 5)
		sd.Ended:Connect(function()
			for i = #activeSounds, 1, -1 do
				if activeSounds[i] == sd then
					table.remove(activeSounds, i)
					break
				end
			end
		end)
	end
end

local function reflowNotifs()
	for i, nd in ipairs(notifQueue) do
		local yp = notifBaseY + (i - 1) * (nd.fh + notifGap)
		if nd.frame and nd.frame.Parent then
			tween(nd.frame, { Position = UDim2.new(1, -(nd.fw + 10), 0, yp) }, 0.3)
			nd.ypos = yp
		end
	end
end

local function sendNotif(title, subtitle, imageId, persistent, notifType)
	local nd = { fh = 0, fw = 0, ypos = 0, frame = nil, _persistent = false, _spawned = false }

	nd.dismiss = function()
		if not nd._spawned then
			nd._dismissed = true
			return
		end
		for i, v in ipairs(notifQueue) do
			if v == nd then
				table.remove(notifQueue, i)
				break
			end
		end
		if nd.frame and nd.frame.Parent then
			local fr = nd.frame
			local t = tween(fr, { Position = UDim2.new(1, 10, 0, nd.ypos) }, 0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
			t.Completed:Connect(function()
				if fr and fr.Parent then fr:Destroy() end
			end)
		end
		reflowNotifs()
	end

	task.spawn(function()
		local hasImage = imageId ~= nil and imageId ~= ""
		local fh = hasImage and 105 or 72
		local fw = hasImage and 320 or 280
		nd.fh = fh
		nd.fw = fw

		local accentColor = Color3.fromRGB(80, 200, 120)
		if notifType == "warning" then
			accentColor = Color3.fromRGB(255, 200, 60)
		elseif notifType == "error" then
			accentColor = Color3.fromRGB(255, 80, 80)
		elseif notifType == "info" then
			accentColor = Color3.fromRGB(80, 160, 255)
		end

		local notifGui = guiParent:FindFirstChild("AK_NOTIF_GUI")
		if not notifGui then
			notifGui = make("ScreenGui", {
				Name           = "AK_NOTIF_GUI",
				ResetOnSpawn   = false,
				ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
				Parent         = guiParent,
			})
		end

		if nd._dismissed then return end

		table.insert(notifQueue, nd)

		local yp = notifBaseY
		for i = 1, #notifQueue - 1 do
			yp = yp + notifQueue[i].fh + notifGap
		end
		nd.ypos = yp

		local fr = make("Frame", {
			Size                   = UDim2.new(0, fw, 0, fh),
			Position               = UDim2.new(1, 10, 0, yp),
			BackgroundColor3       = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 0.45,
			BorderSizePixel        = 0,
			ClipsDescendants       = true,
			Parent                 = notifGui,
		})
		addCorner(fr, 12)
		nd.frame = fr

		local accentBar = make("Frame", {
			Size             = UDim2.new(0, 4, 0, fh * 0.55),
			Position         = UDim2.new(0, 0, 0.5, -(fh * 0.55) / 2),
			BackgroundColor3 = accentColor,
			BorderSizePixel  = 0,
			Parent           = fr,
		})
		addCorner(accentBar, 4)

		make("TextLabel", {
			Size                   = UDim2.new(1, -12, 0, 16),
			Position               = UDim2.new(0, 10, 0, 8),
			BackgroundTransparency = 1,
			Text                   = title and ("AK ADMIN  •  " .. title) or "AK ADMIN",
			TextColor3             = Color3.fromRGB(180, 180, 180),
			TextSize               = 11,
			Font                   = Enum.Font.GothamBold,
			TextXAlignment         = Enum.TextXAlignment.Left,
			Parent                 = fr,
		})

		local textOffsetX = hasImage and 60 or 10
		local textOffsetW = hasImage and -65 or -20

		if hasImage then
			make("ImageLabel", {
				Size                   = UDim2.new(0, 38, 0, 38),
				Position               = UDim2.new(0, 12, 0, 34),
				BackgroundTransparency = 1,
				Image                  = "rbxassetid://" .. tostring(imageId),
				ImageColor3            = Color3.fromRGB(255, 255, 255),
				Parent                 = fr,
			})
		end

		make("TextLabel", {
			Size                   = UDim2.new(1, textOffsetW, 0, 22),
			Position               = UDim2.new(0, textOffsetX, 0, hasImage and 30 or 22),
			BackgroundTransparency = 1,
			Text                   = title or "",
			TextColor3             = Color3.fromRGB(255, 255, 255),
			TextSize               = 15,
			Font                   = Enum.Font.GothamBold,
			TextXAlignment         = Enum.TextXAlignment.Left,
			Parent                 = fr,
		})

		make("TextLabel", {
			Size                   = UDim2.new(1, textOffsetW, 0, hasImage and 34 or 22),
			Position               = UDim2.new(0, textOffsetX, 0, hasImage and 54 or 46),
			BackgroundTransparency = 1,
			Text                   = subtitle or "",
			TextColor3             = Color3.fromRGB(200, 200, 200),
			TextSize               = 12,
			Font                   = Enum.Font.Gotham,
			TextXAlignment         = Enum.TextXAlignment.Left,
			TextWrapped            = true,
			Parent                 = fr,
		})

		local dismissBtn = make("TextButton", {
			Size                   = UDim2.new(0, 18, 0, 18),
			Position               = UDim2.new(1, -22, 0, 4),
			BackgroundTransparency = 1,
			Text                   = "×",
			TextColor3             = Color3.fromRGB(140, 140, 140),
			TextSize               = 16,
			Font                   = Enum.Font.GothamBold,
			BorderSizePixel        = 0,
			Parent                 = fr,
		})
		dismissBtn.MouseButton1Click:Connect(function()
			nd.dismiss()
		end)

		playSound()
		tween(fr, { Position = UDim2.new(1, -(fw + 10), 0, yp) }, 0.5, Enum.EasingStyle.Quint)

		nd._spawned = true

		if not persistent then
			task.wait(6)
			nd.dismiss()
		else
			nd._persistent = true
		end
	end)

	return nd
end

local function saveConfig(configName, data)
	local ok = pcall(function()
		if not isfolder(CONFIG_FOLDER) then
			makefolder(CONFIG_FOLDER)
		end
		writefile(CONFIG_FOLDER .. "/" .. configName .. ".json", hs:JSONEncode(data))
	end)
	return ok
end

local function loadConfig(configName)
	local ok, result = pcall(function()
		if not isfolder(CONFIG_FOLDER) then return nil end
		local path = CONFIG_FOLDER .. "/" .. configName .. ".json"
		if not isfile(path) then return nil end
		return hs:JSONDecode(readfile(path))
	end)
	if ok then return result end
	return nil
end

local function showKeySystem(validKeys, getKeyCallback, onSuccess, onFail)
	local keyGui = make("ScreenGui", {
		Name           = "AK_ADMIN_KEY_GUI",
		ResetOnSpawn   = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		Parent         = cg,
	})

	local panelW    = 360
	local barH      = 48
	local expandedH = 210

	local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)

	local panel = make("Frame", {
		Size                   = UDim2.new(0, panelW, 0, barH),
		Position               = UDim2.new(0.5, -(panelW / 2), 0, -(barH + 20)),
		BackgroundColor3       = Color3.fromRGB(10, 10, 10),
		BackgroundTransparency = 0.18,
		BorderSizePixel        = 0,
		ClipsDescendants       = true,
		Parent                 = keyGui,
	})
	addCorner(panel, 14)
	make("UIStroke", {
		Color     = Color3.fromRGB(50, 50, 50),
		Thickness = 1,
		Parent    = panel,
	})

	local topBar = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, barH),
		Position               = UDim2.new(0, 0, 0, 0),
		BackgroundTransparency = 1,
		Parent                 = panel,
	})

	local accentLine = make("Frame", {
		Size             = UDim2.new(0, 0, 0, 2),
		Position         = UDim2.new(0, 0, 1, -2),
		BackgroundColor3 = Color3.fromRGB(80, 200, 120),
		BorderSizePixel  = 0,
		Parent           = topBar,
	})
	addCorner(accentLine, 1)

	make("TextLabel", {
		Size                   = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text                   = "AK ADMIN  —  Authentication Required",
		TextColor3             = Color3.fromRGB(200, 200, 200),
		TextSize               = 12,
		Font                   = Enum.Font.GothamBold,
		TextXAlignment         = Enum.TextXAlignment.Center,
		Parent                 = topBar,
	})

	local contentFrame = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, expandedH - barH),
		Position               = UDim2.new(0, 0, 0, barH),
		BackgroundTransparency = 1,
		ClipsDescendants       = false,
		Parent                 = panel,
	})

	local avatarFrame = make("Frame", {
		Size             = UDim2.new(0, 62, 0, 62),
		Position         = UDim2.new(0, 18, 0, 14),
		BackgroundColor3 = Color3.fromRGB(20, 20, 20),
		BorderSizePixel  = 0,
		Parent           = contentFrame,
	})
	addCorner(avatarFrame, 14)
	make("UIStroke", {
		Color     = Color3.fromRGB(80, 200, 120),
		Thickness = 1.5,
		Parent    = avatarFrame,
	})

	local avatarImg = make("ImageLabel", {
		Size                   = UDim2.new(1, -4, 1, -4),
		Position               = UDim2.new(0, 2, 0, 2),
		BackgroundTransparency = 1,
		Image                  = "",
		Parent                 = avatarFrame,
	})
	addCorner(avatarImg, 11)

	task.spawn(function()
		local ok, img = pcall(function()
			return pl:GetUserThumbnailAsync(lp.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
		end)
		if ok and avatarImg and avatarImg.Parent then
			avatarImg.Image = img
		end
	end)

	local infoCol = make("Frame", {
		Size                   = UDim2.new(1, -98, 0, 62),
		Position               = UDim2.new(0, 90, 0, 14),
		BackgroundTransparency = 1,
		Parent                 = contentFrame,
	})

	make("TextLabel", {
		Size                   = UDim2.new(1, 0, 0, 20),
		Position               = UDim2.new(0, 0, 0, 4),
		BackgroundTransparency = 1,
		Text                   = lp.DisplayName,
		TextColor3             = Color3.fromRGB(240, 240, 240),
		TextSize               = 14,
		Font                   = Enum.Font.GothamBold,
		TextXAlignment         = Enum.TextXAlignment.Left,
		Parent                 = infoCol,
	})

	make("TextLabel", {
		Size                   = UDim2.new(1, 0, 0, 14),
		Position               = UDim2.new(0, 0, 0, 26),
		BackgroundTransparency = 1,
		Text                   = "@" .. lp.Name,
		TextColor3             = Color3.fromRGB(90, 90, 90),
		TextSize               = 10,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Left,
		Parent                 = infoCol,
	})

	local statusDot = make("Frame", {
		Size             = UDim2.new(0, 7, 0, 7),
		Position         = UDim2.new(0, 0, 0, 47),
		BackgroundColor3 = Color3.fromRGB(255, 200, 60),
		BorderSizePixel  = 0,
		Parent           = infoCol,
	})
	addCorner(statusDot, 4)

	make("TextLabel", {
		Size                   = UDim2.new(1, -12, 0, 14),
		Position               = UDim2.new(0, 12, 0, 45),
		BackgroundTransparency = 1,
		Text                   = "Awaiting key",
		TextColor3             = Color3.fromRGB(120, 120, 120),
		TextSize               = 10,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Left,
		Parent                 = infoCol,
	})

	local divider = make("Frame", {
		Size             = UDim2.new(1, -36, 0, 1),
		Position         = UDim2.new(0, 18, 0, 86),
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BorderSizePixel  = 0,
		Parent           = contentFrame,
	})

	local inputBox = make("TextBox", {
		Size                   = UDim2.new(1, -36, 0, 34),
		Position               = UDim2.new(0, 18, 0, 96),
		BackgroundColor3       = Color3.fromRGB(16, 16, 16),
		BackgroundTransparency = 0.1,
		PlaceholderText        = "Paste your key here...",
		Text                   = "",
		TextColor3             = Color3.fromRGB(220, 220, 220),
		PlaceholderColor3      = Color3.fromRGB(50, 50, 50),
		TextSize               = 12,
		Font                   = Enum.Font.Gotham,
		BorderSizePixel        = 0,
		ClearTextOnFocus       = false,
		Parent                 = contentFrame,
	})
	addCorner(inputBox, 8)
	make("UIStroke", {
		Color     = Color3.fromRGB(38, 38, 38),
		Thickness = 1,
		Parent    = inputBox,
	})
	make("UIPadding", {
		PaddingLeft  = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
		Parent       = inputBox,
	})

	local statusLabel = make("TextLabel", {
		Size                   = UDim2.new(1, -36, 0, 14),
		Position               = UDim2.new(0, 18, 0, 136),
		BackgroundTransparency = 1,
		Text                   = "",
		TextColor3             = Color3.fromRGB(255, 80, 80),
		TextSize               = 10,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Center,
		Parent                 = contentFrame,
	})

	local loadBarBg = make("Frame", {
		Size             = UDim2.new(1, -36, 0, 3),
		Position         = UDim2.new(0, 18, 0, 152),
		BackgroundColor3 = Color3.fromRGB(25, 25, 25),
		BorderSizePixel  = 0,
		Parent           = contentFrame,
	})
	addCorner(loadBarBg, 2)

	local loadBarFill = make("Frame", {
		Size             = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(80, 200, 120),
		BorderSizePixel  = 0,
		Parent           = loadBarBg,
	})
	addCorner(loadBarFill, 2)

	local btnRow = make("Frame", {
		Size                   = UDim2.new(1, -36, 0, 30),
		Position               = UDim2.new(0, 18, 0, 162),
		BackgroundTransparency = 1,
		Parent                 = contentFrame,
	})
	make("UIListLayout", {
		FillDirection       = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		VerticalAlignment   = Enum.VerticalAlignment.Center,
		Padding             = UDim.new(0, 8),
		Parent              = btnRow,
	})

	local getKeyBtn = make("TextButton", {
		Size                   = UDim2.new(0, 72, 0, 26),
		BackgroundColor3       = Color3.fromRGB(22, 22, 22),
		BackgroundTransparency = 0.1,
		Text                   = "Get Key",
		TextColor3             = Color3.fromRGB(100, 100, 100),
		TextSize               = 11,
		Font                   = Enum.Font.Gotham,
		BorderSizePixel        = 0,
		LayoutOrder            = 1,
		Parent                 = btnRow,
	})
	addCorner(getKeyBtn, 7)
	make("UIStroke", {
		Color     = Color3.fromRGB(40, 40, 40),
		Thickness = 1,
		Parent    = getKeyBtn,
	})

	local authBtn = make("TextButton", {
		Size                   = UDim2.new(0, 96, 0, 26),
		BackgroundColor3       = Color3.fromRGB(18, 40, 26),
		BackgroundTransparency = 0.0,
		Text                   = "Authenticate",
		TextColor3             = Color3.fromRGB(80, 200, 120),
		TextSize               = 11,
		Font                   = Enum.Font.GothamSemibold,
		BorderSizePixel        = 0,
		LayoutOrder            = 2,
		Parent                 = btnRow,
	})
	addCorner(authBtn, 7)
	make("UIStroke", {
		Color     = Color3.fromRGB(40, 80, 55),
		Thickness = 1,
		Parent    = authBtn,
	})

	task.spawn(function()
		task.wait(0.05)
		tween(panel, { Position = UDim2.new(0.5, -(panelW / 2), 0, 14) }, 0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		task.wait(0.3)
		tween(accentLine, { Size = UDim2.new(1, 0, 0, 2) }, 0.6, Enum.EasingStyle.Quint)
		task.wait(0.55)
		tween(panel, { Size = UDim2.new(0, panelW, 0, expandedH) }, 0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	end)

	getKeyBtn.MouseEnter:Connect(function()
		tween(getKeyBtn, { TextColor3 = Color3.fromRGB(180, 180, 180) }, 0.12)
	end)
	getKeyBtn.MouseLeave:Connect(function()
		tween(getKeyBtn, { TextColor3 = Color3.fromRGB(100, 100, 100) }, 0.12)
	end)
	getKeyBtn.MouseButton1Click:Connect(function()
		if getKeyCallback then pcall(getKeyCallback) end
	end)

	authBtn.MouseEnter:Connect(function()
		tween(authBtn, { BackgroundColor3 = Color3.fromRGB(24, 52, 34) }, 0.12)
	end)
	authBtn.MouseLeave:Connect(function()
		tween(authBtn, { BackgroundColor3 = Color3.fromRGB(18, 40, 26) }, 0.12)
	end)

	local attempting = false

	local function attempt()
		if attempting then return end
		attempting = true
		authBtn.Text       = "Checking..."
		authBtn.TextColor3 = Color3.fromRGB(140, 140, 140)

		tween(loadBarFill, { Size = UDim2.new(0.6, 0, 1, 0) }, 0.5, Enum.EasingStyle.Quint)

		task.wait(0.55)

		local entered = inputBox.Text
		local valid   = false
		for _, k in ipairs(validKeys) do
			if k == entered then valid = true break end
		end

		if valid then
			statusLabel.Text       = "Key accepted."
			statusLabel.TextColor3 = Color3.fromRGB(80, 200, 120)
			loadBarFill.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
			tween(loadBarFill, { Size = UDim2.new(1, 0, 1, 0) }, 0.3, Enum.EasingStyle.Quint)
			tween(statusDot, { BackgroundColor3 = Color3.fromRGB(80, 200, 120) }, 0.3)
			authBtn.Text       = "✓ Verified"
			authBtn.TextColor3 = Color3.fromRGB(80, 200, 120)
			task.wait(0.7)
			local t = tween(panel, { Position = UDim2.new(0.5, -(panelW / 2), 0, -(expandedH + 30)) }, 0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
			t.Completed:Connect(function()
				keyGui:Destroy()
				if onSuccess then onSuccess() end
			end)
		else
			statusLabel.Text       = "Invalid key. Please try again."
			statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
			loadBarFill.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
			tween(loadBarFill, { Size = UDim2.new(1, 0, 1, 0) }, 0.2, Enum.EasingStyle.Quint)
			authBtn.Text       = "Authenticate"
			authBtn.TextColor3 = Color3.fromRGB(80, 200, 120)
			tween(inputBox, { BackgroundColor3 = Color3.fromRGB(40, 16, 16) }, 0.1)
			task.wait(0.4)
			tween(loadBarFill, { Size = UDim2.new(0, 0, 1, 0) }, 0.35, Enum.EasingStyle.Quint)
			tween(inputBox, { BackgroundColor3 = Color3.fromRGB(16, 16, 16) }, 0.35)
			if onFail then onFail(entered) end
			attempting = false
		end
	end

	authBtn.MouseButton1Click:Connect(attempt)
	inputBox.FocusLost:Connect(function(enter) if enter then attempt() end end)
end

local function showConfirmDialog(screenGui, message, onConfirm, onCancel)
	local overlay = make("Frame", {
		Size                   = UDim2.new(1, 0, 1, 0),
		BackgroundColor3       = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.5,
		BorderSizePixel        = 0,
		ZIndex                 = 995,
		Parent                 = screenGui,
	})

	local box = make("Frame", {
		Size                   = UDim2.new(0, 300, 0, 140),
		Position               = UDim2.new(0.5, -150, 0.5, -70),
		BackgroundColor3       = Color3.fromRGB(14, 14, 14),
		BackgroundTransparency = 0.05,
		BorderSizePixel        = 0,
		ZIndex                 = 996,
		Parent                 = overlay,
	})
	addCorner(box, 12)
	make("UIStroke", { Color = Color3.fromRGB(55, 55, 55), Thickness = 1, Parent = box })

	make("TextLabel", {
		Size                   = UDim2.new(1, -20, 0, 60),
		Position               = UDim2.new(0, 10, 0, 20),
		BackgroundTransparency = 1,
		Text                   = message or "Are you sure?",
		TextColor3             = Color3.fromRGB(220, 220, 220),
		TextSize               = 13,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Center,
		TextWrapped            = true,
		ZIndex                 = 997,
		Parent                 = box,
	})

	local btnRow = make("Frame", {
		Size                   = UDim2.new(1, -20, 0, 32),
		Position               = UDim2.new(0, 10, 0, 96),
		BackgroundTransparency = 1,
		ZIndex                 = 997,
		Parent                 = box,
	})
	make("UIListLayout", {
		FillDirection       = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		Padding             = UDim.new(0, 8),
		Parent              = btnRow,
	})

	local confirmBtn = make("TextButton", {
		Size                   = UDim2.new(0, 120, 1, 0),
		BackgroundColor3       = Color3.fromRGB(60, 20, 20),
		BackgroundTransparency = 0.1,
		Text                   = "Confirm",
		TextColor3             = Color3.fromRGB(255, 100, 100),
		TextSize               = 12,
		Font                   = Enum.Font.GothamBold,
		BorderSizePixel        = 0,
		ZIndex                 = 998,
		Parent                 = btnRow,
	})
	addCorner(confirmBtn, 7)

	local cancelBtn = make("TextButton", {
		Size                   = UDim2.new(0, 120, 1, 0),
		BackgroundColor3       = Color3.fromRGB(30, 30, 30),
		BackgroundTransparency = 0.2,
		Text                   = "Cancel",
		TextColor3             = Color3.fromRGB(180, 180, 180),
		TextSize               = 12,
		Font                   = Enum.Font.GothamBold,
		BorderSizePixel        = 0,
		ZIndex                 = 998,
		Parent                 = btnRow,
	})
	addCorner(cancelBtn, 7)

	confirmBtn.MouseButton1Click:Connect(function()
		overlay:Destroy()
		if onConfirm then onConfirm() end
	end)
	cancelBtn.MouseButton1Click:Connect(function()
		overlay:Destroy()
		if onCancel then onCancel() end
	end)
end

function UILibrary.new(title, options)
	options = options or {}
	local hideKey     = options.hideKey or Enum.KeyCode.RightShift
	local keys        = options.keys
	local getKeyUrl   = options.getKeyUrl
	local discordLink = options.discord
	local configName  = options.configName
	local obfuscate   = options.obfuscate or false

	local self       = setmetatable({}, UILibrary)
	self._conns      = {}
	self._closed     = false
	self._listening  = false
	self._toggles    = {}
	self._keybinds   = {}
	self._closeCallbacks = {}
	self._resizePending  = false
	self._userResized    = false
	self._minimized      = false
	self._animating      = false
	self._manualWidth    = 300
	self._manualHeight   = 300
	self._tabs           = {}
	self._activeTab      = nil
	self._activeTweens   = {}
	self._hideKey        = hideKey
	self._orderCounter   = makeOrderCounter()
	self._destroyed      = false
	self._configName     = configName
	self.Flags           = globalFlags

	local function conn(signal, fn)
		local c = signal:Connect(fn)
		table.insert(self._conns, c)
		return c
	end
	self._conn = conn

	local function disconnectAll()
		for _, c in ipairs(self._conns) do
			if c and c.Connected then c:Disconnect() end
		end
		self._conns     = {}
		self._closed    = true
		self._listening = false
		self._destroyed = true
	end
	self._disconnectAll = disconnectAll

	local titleKey = title or "__untitled__"
	self._titleKey = titleKey

	if activeInstances[titleKey] then
		for _, old in ipairs(activeInstances[titleKey]) do
			if not old._closed then
				for _, fn in ipairs(old._closeCallbacks or {}) do pcall(fn) end
				old._disconnectAll()
				if old.screenGui and old.screenGui.Parent then old.screenGui:Destroy() end
			end
		end
		activeInstances[titleKey] = nil
	end
	activeInstances[titleKey] = {}
	table.insert(activeInstances[titleKey], self)

	guiCounter = guiCounter + 1
	local rawName = "AK_ADMIN_LIB_" .. guiCounter .. "_" .. hs:GenerateGUID(false):gsub("-", ""):sub(1, 12)
	local guiName = obfuscate and hs:GenerateGUID(false):gsub("-", "") or rawName

	self.screenGui = make("ScreenGui", {
		Name           = guiName,
		ResetOnSpawn   = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		Parent         = guiParent,
	})

	self.mainFrame = make("Frame", {
		Size                   = UDim2.new(0, 300, 0, 40),
		Position               = UDim2.new(0.5, -150, 0.5, -200),
		BackgroundColor3       = Color3.fromRGB(10, 10, 10),
		BackgroundTransparency = 0.3,
		BorderSizePixel        = 0,
		ClipsDescendants       = false,
		Visible                = false,
		Parent                 = self.screenGui,
	})
	addCorner(self.mainFrame, 14)
	make("UIStroke", {
		Color     = Color3.fromRGB(60, 60, 60),
		Thickness = 1,
		Parent    = self.mainFrame,
	})

	self.titleBar = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 40),
		BackgroundTransparency = 1,
		Parent                 = self.mainFrame,
	})

	make("TextLabel", {
		Size                   = UDim2.new(1, -80, 1, 0),
		Position               = UDim2.new(0, 14, 0, 0),
		BackgroundTransparency = 1,
		Text                   = "AK ADMIN" .. (title and ("  •  " .. title) or ""),
		TextColor3             = Color3.fromRGB(255, 255, 255),
		TextSize               = 13,
		Font                   = Enum.Font.GothamBold,
		TextXAlignment         = Enum.TextXAlignment.Left,
		Parent                 = self.titleBar,
	})

	self.minimizeBtn = make("TextButton", {
		Size                   = UDim2.new(0, 24, 0, 24),
		Position               = UDim2.new(1, -52, 0.5, -12),
		BackgroundColor3       = Color3.fromRGB(30, 30, 30),
		BackgroundTransparency = 0.4,
		Text                   = "—",
		TextColor3             = Color3.fromRGB(200, 200, 200),
		TextSize               = 11,
		Font                   = Enum.Font.GothamBold,
		BorderSizePixel        = 0,
		Parent                 = self.titleBar,
	})
	addCorner(self.minimizeBtn, 8)

	self.closeBtn = make("TextButton", {
		Size                   = UDim2.new(0, 24, 0, 24),
		Position               = UDim2.new(1, -26, 0.5, -12),
		BackgroundColor3       = Color3.fromRGB(30, 30, 30),
		BackgroundTransparency = 0.4,
		Text                   = "X",
		TextColor3             = Color3.fromRGB(200, 200, 200),
		TextSize               = 11,
		Font                   = Enum.Font.GothamBold,
		BorderSizePixel        = 0,
		Parent                 = self.titleBar,
	})
	addCorner(self.closeBtn, 8)

	self.contentFrame = make("Frame", {
		Size                   = UDim2.new(1, 0, 1, -44),
		Position               = UDim2.new(0, 0, 0, 44),
		BackgroundTransparency = 1,
		Parent                 = self.mainFrame,
	})

	self.tabScrollFrame = make("ScrollingFrame", {
		Size                       = UDim2.new(1, -16, 0, 28),
		Position                   = UDim2.new(0, 8, 0, 0),
		BackgroundTransparency     = 1,
		BorderSizePixel            = 0,
		ScrollBarThickness         = 0,
		ScrollingDirection         = Enum.ScrollingDirection.X,
		CanvasSize                 = UDim2.new(0, 0, 0, 0),
		Visible                    = false,
		Parent                     = self.contentFrame,
	})

	self.tabContainer = make("Frame", {
		Size                   = UDim2.new(0, 0, 1, 0),
		AutomaticSize          = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		Parent                 = self.tabScrollFrame,
	})
	make("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		Padding       = UDim.new(0, 4),
		SortOrder     = Enum.SortOrder.LayoutOrder,
		Parent        = self.tabContainer,
	})

	self.scrollFrame = make("ScrollingFrame", {
		Size                       = UDim2.new(1, -16, 1, -8),
		Position                   = UDim2.new(0, 8, 0, 4),
		BackgroundTransparency     = 1,
		ScrollBarThickness         = 3,
		ScrollBarImageColor3       = Color3.fromRGB(255, 255, 255),
		ScrollBarImageTransparency = 0.5,
		BorderSizePixel            = 0,
		ScrollingDirection         = Enum.ScrollingDirection.Y,
		CanvasSize                 = UDim2.new(0, 0, 0, 0),
		Parent                     = self.contentFrame,
	})

	self.listLayout = make("UIListLayout", {
		Padding   = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent    = self.scrollFrame,
	})
	make("UIPadding", {
		PaddingTop    = UDim.new(0, 4),
		PaddingBottom = UDim.new(0, 4),
		Parent        = self.scrollFrame,
	})

	local resizeHandle = make("Frame", {
		Size                   = UDim2.new(0, 28, 0, 28),
		Position               = UDim2.new(1, -6, 1, -6),
		BackgroundTransparency = 1,
		BorderSizePixel        = 0,
		ZIndex                 = 10,
		Parent                 = self.mainFrame,
	})

	local rLine1 = make("Frame", {
		Size                   = UDim2.new(0, 16, 0, 2),
		Position               = UDim2.new(0, 0, 1, -8),
		BackgroundColor3       = Color3.fromRGB(120, 120, 120),
		BackgroundTransparency = 0.3,
		BorderSizePixel        = 0,
		ZIndex                 = 11,
		Parent                 = resizeHandle,
	})
	addCorner(rLine1, 1)

	local rLine2 = make("Frame", {
		Size                   = UDim2.new(0, 2, 0, 16),
		Position               = UDim2.new(1, -8, 0, 0),
		BackgroundColor3       = Color3.fromRGB(120, 120, 120),
		BackgroundTransparency = 0.3,
		BorderSizePixel        = 0,
		ZIndex                 = 11,
		Parent                 = resizeHandle,
	})
	addCorner(rLine2, 1)

	local minW, minH      = 200, 100
	local resizeDragging  = false
	local resizeOrigin    = nil
	local resizeStartSize = nil

	conn(resizeHandle.InputBegan, function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			resizeDragging  = true
			resizeOrigin    = inp.Position
			resizeStartSize = self.mainFrame.AbsoluteSize
			self._userResized = true
		end
	end)

	conn(resizeHandle.MouseEnter, function()
		tween(rLine1, { BackgroundTransparency = 0 }, 0.1)
		tween(rLine2, { BackgroundTransparency = 0 }, 0.1)
	end)
	conn(resizeHandle.MouseLeave, function()
		tween(rLine1, { BackgroundTransparency = 0.3 }, 0.1)
		tween(rLine2, { BackgroundTransparency = 0.3 }, 0.1)
	end)

	local screenBounds = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
	conn(workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), function()
		screenBounds = workspace.CurrentCamera.ViewportSize
	end)

	conn(ui.InputChanged, function(inp)
		if resizeDragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
			local delta = inp.Position - resizeOrigin
			local maxW  = screenBounds.X - self.mainFrame.AbsolutePosition.X - 10
			local maxH  = screenBounds.Y - self.mainFrame.AbsolutePosition.Y - 10
			local newW  = math.clamp(resizeStartSize.X + delta.X, minW, maxW)
			if self._minimized then
				self._manualWidth  = newW
				self.mainFrame.Size = UDim2.new(0, newW, 0, 40)
			else
				local newH = math.clamp(resizeStartSize.Y + delta.Y, minH, maxH)
				self._manualWidth  = newW
				self._manualHeight = newH
				self.mainFrame.Size = UDim2.new(0, newW, 0, newH)
				self:_updateScroll()
			end
		end
	end)

	conn(ui.InputEnded, function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			resizeDragging = false
		end
	end)

	local dragActive   = false
	local dragOrigin   = nil
	local dragStartPos = nil

	conn(self.titleBar.InputBegan, function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			dragActive   = true
			dragOrigin   = inp.Position
			dragStartPos = self.mainFrame.Position
		end
	end)

	conn(ui.InputChanged, function(inp)
		if dragActive and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
			local delta = inp.Position - dragOrigin
			self.mainFrame.Position = UDim2.new(
				dragStartPos.X.Scale, dragStartPos.X.Offset + delta.X,
				dragStartPos.Y.Scale, dragStartPos.Y.Offset + delta.Y
			)
		end
	end)

	conn(ui.InputEnded, function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			dragActive = false
		end
	end)

	conn(self.minimizeBtn.MouseButton1Click, function() self:minimize() end)

	conn(self.closeBtn.MouseButton1Click, function()
		for _, fn in ipairs(self._closeCallbacks) do pcall(fn) end
		if activeInstances[self._titleKey] then
			for i, v in ipairs(activeInstances[self._titleKey]) do
				if v == self then table.remove(activeInstances[self._titleKey], i) break end
			end
			if #activeInstances[self._titleKey] == 0 then activeInstances[self._titleKey] = nil end
		end
		disconnectAll()
		if self.screenGui and self.screenGui.Parent then self.screenGui:Destroy() end
	end)

	conn(self.minimizeBtn.MouseEnter, function() tween(self.minimizeBtn, { BackgroundTransparency = 0.1, TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.15) end)
	conn(self.minimizeBtn.MouseLeave, function() tween(self.minimizeBtn, { BackgroundTransparency = 0.4, TextColor3 = Color3.fromRGB(200, 200, 200) }, 0.15) end)
	conn(self.closeBtn.MouseEnter,    function() tween(self.closeBtn, { BackgroundTransparency = 0.1, TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.15) end)
	conn(self.closeBtn.MouseLeave,    function() tween(self.closeBtn, { BackgroundTransparency = 0.4, TextColor3 = Color3.fromRGB(200, 200, 200) }, 0.15) end)

	conn(ui.InputBegan, function(inp, gp)
		if gp then return end
		if self._closed then return end
		if inp.KeyCode == self._hideKey then
			self.mainFrame.Visible = not self.mainFrame.Visible
		end
		if not self._listening then
			for _, kb in pairs(self._keybinds) do
				if inp.KeyCode == kb.keyCode then pcall(kb.callback) end
			end
		end
	end)

	conn(self.listLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
		self:_scheduleResize()
	end)

	self:_updateScroll()

	local function revealMain()
		self.mainFrame.Visible = true
		if discordLink then
			pcall(function()
				if setclipboard then setclipboard(discordLink) end
			end)
		end
		if configName then
			self:loadConfig()
		end
	end

	if keys and #keys > 0 then
		showKeySystem(keys, getKeyUrl and function()
			if setclipboard then pcall(function() setclipboard(getKeyUrl) end) end
			pcall(function() if syn and syn.request then syn.request({ Url = getKeyUrl, Method = "GET" }) end end)
		end or nil, revealMain, nil)
	else
		revealMain()
	end

	return self
end

function UILibrary:saveConfig()
	if not self._configName then return false end
	local data = {}
	for flag, val in pairs(globalFlags) do
		data[flag] = val
	end
	return saveConfig(self._configName, data)
end

function UILibrary:loadConfig()
	if not self._configName then return false end
	local data = loadConfig(self._configName)
	if not data then return false end
	for flag, val in pairs(data) do
		globalFlags[flag] = val
	end
	return data
end

function UILibrary:_scheduleResize()
	if self._resizePending then return end
	self._resizePending = true
	task.defer(function()
		self._resizePending = false
		if self._destroyed then return end
		if not self.mainFrame or not self.mainFrame.Parent then return end
		self:resize()
	end)
end

function UILibrary:_updateTabScroll()
	if not self.tabContainer or not self.tabScrollFrame then return end
	local contentW = self.tabContainer.AbsoluteSize.X
	self.tabScrollFrame.CanvasSize = UDim2.new(0, contentW, 0, 0)
end

function UILibrary:_updateScroll()
	local tabOffset   = self.tabScrollFrame.Visible and 34 or 0
	local contentSize = self._activeTab
		and self._activeTab.listLayout.AbsoluteContentSize.Y + 8
		or  self.listLayout.AbsoluteContentSize.Y + 8

	self.scrollFrame.CanvasSize = UDim2.new(0, 0, 0, contentSize)
	if tabOffset > 0 then
		self.scrollFrame.Size     = UDim2.new(1, -16, 1, -(tabOffset + 8))
		self.scrollFrame.Position = UDim2.new(0, 8, 0, tabOffset)
	else
		self.scrollFrame.Size     = UDim2.new(1, -16, 1, -8)
		self.scrollFrame.Position = UDim2.new(0, 8, 0, 4)
	end
end

function UILibrary:resize()
	if self._minimized then return end
	self:_updateScroll()
	if self._userResized then return end

	local tabOffset   = self.tabScrollFrame.Visible and 34 or 0
	local contentSize = self._activeTab
		and self._activeTab.listLayout.AbsoluteContentSize.Y + 8
		or  self.listLayout.AbsoluteContentSize.Y + 8

	local targetH = math.min(contentSize + tabOffset, 460)
	local finalH  = math.max(40 + math.max(targetH, 20), 60)
	local curSize = self.mainFrame.Size

	if math.abs(curSize.Y.Offset - finalH) > 0.5 then
		for _, t in ipairs(self._activeTweens) do pcall(function() t:Cancel() end) end
		self._activeTweens = {}
		local t = tween(self.mainFrame, { Size = UDim2.new(0, curSize.X.Offset, 0, finalH) }, 0.2)
		table.insert(self._activeTweens, t)
		t.Completed:Connect(function()
			for i, v in ipairs(self._activeTweens) do
				if v == t then table.remove(self._activeTweens, i) break end
			end
		end)
	end
end

function UILibrary:minimize()
	if self._animating then return end
	self._animating = true

	if not self._minimized then
		self._minimized           = true
		self.minimizeBtn.Text     = "+"
		self.contentFrame.Visible = false
		local cw = self.mainFrame.AbsoluteSize.X
		local t  = tween(self.mainFrame, { Size = UDim2.new(0, cw, 0, 40) }, 0.3)
		t.Completed:Connect(function()
			self._animating = false
		end)
	else
		self._minimized           = false
		self.minimizeBtn.Text     = "—"
		self.contentFrame.Visible = true
		if self._userResized then
			self:_updateScroll()
			local t = tween(self.mainFrame, { Size = UDim2.new(0, self._manualWidth, 0, self._manualHeight) }, 0.3)
			t.Completed:Connect(function() self._animating = false end)
		else
			local tabOffset   = self.tabScrollFrame.Visible and 34 or 0
			local contentSize = self._activeTab
				and self._activeTab.listLayout.AbsoluteContentSize.Y + 8
				or  self.listLayout.AbsoluteContentSize.Y + 8
			local finalH = math.max(40 + math.max(math.min(contentSize + tabOffset, 460), 20), 60)
			local curW   = self.mainFrame.AbsoluteSize.X
			local t = tween(self.mainFrame, { Size = UDim2.new(0, curW, 0, finalH) }, 0.3)
			t.Completed:Connect(function()
				self:_updateScroll()
				self._animating = false
			end)
		end
	end
end

function UILibrary:destroy(skipConfirm, onDone)
	if skipConfirm then
		for _, fn in ipairs(self._closeCallbacks) do pcall(fn) end
		self._disconnectAll()
		if self.screenGui and self.screenGui.Parent then self.screenGui:Destroy() end
		if onDone then onDone() end
	else
		showConfirmDialog(self.screenGui, "Are you sure you want to close AK Admin?", function()
			for _, fn in ipairs(self._closeCallbacks) do pcall(fn) end
			self._disconnectAll()
			if self.screenGui and self.screenGui.Parent then self.screenGui:Destroy() end
			if onDone then onDone() end
		end, nil)
	end
end

function UILibrary:_getTarget()
	if self._activeTab then
		return self._activeTab.frame, self._activeTab.listLayout, self._activeTab.orderCounter()
	end
	return self.scrollFrame, self.listLayout, self._orderCounter()
end

function UILibrary:addTab(name, icon)
	local tabData = {
		name         = name,
		lib          = self,
		items        = {},
		orderCounter = makeOrderCounter(),
	}

	local btnText = icon and (icon .. "  " .. name) or ("  " .. name .. "  ")

	local btn = make("TextButton", {
		Size                   = UDim2.new(0, 0, 1, 0),
		AutomaticSize          = Enum.AutomaticSize.X,
		BackgroundColor3       = Color3.fromRGB(30, 30, 30),
		BackgroundTransparency = 0.4,
		Text                   = btnText,
		TextColor3             = Color3.fromRGB(160, 160, 160),
		TextSize               = 11,
		Font                   = Enum.Font.Gotham,
		BorderSizePixel        = 0,
		LayoutOrder            = #self._tabs + 1,
		Parent                 = self.tabContainer,
	})
	addCorner(btn, 8)
	tabData.btn = btn

	tabData.frame = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		BackgroundTransparency = 1,
		Visible                = false,
		Parent                 = self.scrollFrame,
	})

	tabData.listLayout = make("UIListLayout", {
		Padding   = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent    = tabData.frame,
	})

	make("UIPadding", {
		PaddingTop    = UDim.new(0, 2),
		PaddingBottom = UDim.new(0, 4),
		Parent        = tabData.frame,
	})

	self._conn(tabData.listLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
		if self._destroyed then return end
		self:_scheduleResize()
		tabData.frame.Size = UDim2.new(1, 0, 0, tabData.listLayout.AbsoluteContentSize.Y + 8)
	end)

	self._conn(self.tabContainer:GetPropertyChangedSignal("AbsoluteSize"), function()
		self:_updateTabScroll()
	end)

	table.insert(self._tabs, tabData)
	self.tabScrollFrame.Visible = #self._tabs > 1

	if self.tabScrollFrame.Visible then
		self.scrollFrame.Parent = self.contentFrame
		self.listLayout.Parent  = nil
	end

	self._conn(btn.MouseButton1Click, function()
		self:switchTab(tabData)
	end)

	if #self._tabs == 1 then self:switchTab(tabData) end

	self:_updateTabScroll()
	self:resize()
	return tabData
end

function UILibrary:switchTab(tabData)
	for _, other in pairs(self._tabs) do
		other.frame.Visible = false
		tween(other.btn, { BackgroundTransparency = 0.6, TextColor3 = Color3.fromRGB(140, 140, 140) }, 0.15)
	end
	tabData.frame.Visible = true
	tween(tabData.btn, { BackgroundTransparency = 0.1, TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.15)
	self._activeTab = tabData
	self:_updateScroll()
	self:resize()
end

function UILibrary:addButton(name, callback, options)
	options = options or {}
	local cooldown  = options.cooldown or 0
	local disabled  = options.disabled or false

	local parent, _, layoutOrder = self:_getTarget()
	local row = makeRow(parent, layoutOrder)

	local btn = make("TextButton", {
		Size                   = UDim2.new(1, -16, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		Position               = UDim2.new(0, 8, 0, 0),
		BackgroundColor3       = Color3.fromRGB(35, 35, 35),
		BackgroundTransparency = disabled and 0.6 or 0.3,
		Text                   = name,
		TextColor3             = disabled and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(255, 255, 255),
		TextSize               = 12,
		Font                   = Enum.Font.Gotham,
		BorderSizePixel        = 0,
		TextWrapped            = true,
		TextXAlignment         = Enum.TextXAlignment.Center,
		Active                 = not disabled,
		Parent                 = row,
	})
	make("UIPadding", {
		PaddingTop    = UDim.new(0, 7),
		PaddingBottom = UDim.new(0, 7),
		PaddingLeft   = UDim.new(0, 8),
		PaddingRight  = UDim.new(0, 8),
		Parent        = btn,
	})
	addCorner(btn, 8)

	local _disabled   = disabled
	local _onCooldown = false

	local function setDisabled(val)
		_disabled = val
		btn.Active = not val
		tween(btn, {
			BackgroundTransparency = val and 0.6 or 0.3,
			TextColor3             = val and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(255, 255, 255),
		}, 0.15)
	end

	self._conn(btn.MouseEnter, function()
		if not _disabled and not _onCooldown then tween(btn, { BackgroundTransparency = 0.05 }, 0.1) end
	end)
	self._conn(btn.MouseLeave, function()
		if not _disabled and not _onCooldown then tween(btn, { BackgroundTransparency = 0.3 }, 0.1) end
	end)
	self._conn(btn.MouseButton1Click, function()
		if _disabled or _onCooldown then return end
		tween(btn, { BackgroundTransparency = 0.3 }, 0.1)
		if callback then pcall(callback) end
		if cooldown > 0 then
			_onCooldown = true
			local originalText = btn.Text
			btn.Active = false
			tween(btn, { BackgroundTransparency = 0.55, TextColor3 = Color3.fromRGB(120, 120, 120) }, 0.1)
			task.spawn(function()
				local endTime = tick() + cooldown
				while tick() < endTime do
					local remaining = math.ceil(endTime - tick())
					btn.Text = originalText .. " (" .. remaining .. ")"
					task.wait(0.1)
				end
				btn.Text = originalText
				btn.Active = not _disabled
				_onCooldown = false
				tween(btn, {
					BackgroundTransparency = _disabled and 0.6 or 0.3,
					TextColor3             = _disabled and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(255, 255, 255),
				}, 0.15)
			end)
		end
	end)

	if self._activeTab then table.insert(self._activeTab.items, row) end
	self:resize()

	return {
		setText     = function(text) btn.Text = text end,
		getText     = function()     return btn.Text end,
		setDisabled = setDisabled,
		isDisabled  = function()     return _disabled end,
	}
end

function UILibrary:addToggle(name, default, callback, flag)
	local parent, _, layoutOrder = self:_getTarget()
	local row   = makeRow(parent, layoutOrder)
	local state = default or false

	if flag then globalFlags[flag] = state end

	local inner = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent                 = row,
	})
	make("UIPadding", {
		PaddingLeft  = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
		Parent       = inner,
	})
	make("UIListLayout", {
		FillDirection     = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder         = Enum.SortOrder.LayoutOrder,
		Parent            = inner,
	})

	make("TextLabel", {
		Size                   = UDim2.new(1, -60, 0, 26),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Text                   = name,
		TextColor3             = Color3.fromRGB(220, 220, 220),
		TextSize               = 12,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Left,
		TextWrapped            = true,
		LayoutOrder            = 1,
		Parent                 = inner,
	})

	local track = make("Frame", {
		Size             = UDim2.new(0, 36, 0, 20),
		BackgroundColor3 = state and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(60, 60, 60),
		BorderSizePixel  = 0,
		LayoutOrder      = 2,
		Parent           = inner,
	})
	addCorner(track, 10)

	local knob = make("Frame", {
		Size             = UDim2.new(0, 14, 0, 14),
		Position         = UDim2.new(0, state and 19 or 3, 0.5, -7),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel  = 0,
		Parent           = track,
	})
	addCorner(knob, 7)

	local _disabled = false

	local function updateVisual(val)
		tween(track, { BackgroundColor3 = val and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(60, 60, 60) }, 0.15)
		tween(knob,  { Position = UDim2.new(0, val and 19 or 3, 0.5, -7) }, 0.15)
	end

	local function setValue(val, fire)
		state = val
		if flag then globalFlags[flag] = val end
		updateVisual(val)
		if fire and callback then pcall(callback, val) end
	end

	self._conn(track.InputBegan, function(inp)
		if _disabled then return end
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			setValue(not state, true)
		end
	end)

	if self._activeTab then table.insert(self._activeTab.items, row) end
	self:resize()

	local obj = {}
	setmetatable(obj, {
		__index = function(_, k)
			if k == "Value" then return state end
		end,
		__newindex = function(_, k, v)
			if k == "Value" then setValue(v, false) else rawset(obj, k, v) end
		end,
	})

	obj.set         = function(v, silent) setValue(v, not silent) end
	obj.get         = function() return state end
	obj.setDisabled = function(val)
		_disabled = val
		tween(track, { BackgroundTransparency = val and 0.5 or 0 }, 0.15)
		tween(knob,  { BackgroundTransparency = val and 0.5 or 0 }, 0.15)
	end

	self._toggles[name] = obj
	return obj
end

function UILibrary:addCheckbox(name, default, callback, flag)
	local parent, _, layoutOrder = self:_getTarget()
	local row   = makeRow(parent, layoutOrder)
	local state = default or false

	if flag then globalFlags[flag] = state end

	local inner = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent                 = row,
	})
	make("UIPadding", {
		PaddingLeft  = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
		Parent       = inner,
	})
	make("UIListLayout", {
		FillDirection     = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder         = Enum.SortOrder.LayoutOrder,
		Parent            = inner,
	})

	local box = make("Frame", {
		Size             = UDim2.new(0, 18, 0, 18),
		BackgroundColor3 = state and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(40, 40, 40),
		BorderSizePixel  = 0,
		LayoutOrder      = 1,
		Parent           = inner,
	})
	addCorner(box, 5)
	make("UIStroke", { Color = Color3.fromRGB(80, 80, 80), Thickness = 1, Parent = box })

	local checkmark = make("TextLabel", {
		Size                   = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text                   = "✓",
		TextColor3             = Color3.fromRGB(255, 255, 255),
		TextSize               = 12,
		Font                   = Enum.Font.GothamBold,
		TextXAlignment         = Enum.TextXAlignment.Center,
		TextTransparency       = state and 0 or 1,
		Parent                 = box,
	})

	make("TextLabel", {
		Size                   = UDim2.new(1, -26, 0, 26),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Text                   = name,
		TextColor3             = Color3.fromRGB(220, 220, 220),
		TextSize               = 12,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Left,
		TextWrapped            = true,
		LayoutOrder            = 2,
		Parent                 = inner,
	})
	make("UIPadding", { PaddingLeft = UDim.new(0, 8), Parent = inner:FindFirstChildWhichIsA("TextLabel") })

	local _disabled = false

	local clickBtn = make("TextButton", {
		Size                   = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text                   = "",
		Parent                 = row,
	})

	local function setValue(val, fire)
		state = val
		if flag then globalFlags[flag] = val end
		tween(box, { BackgroundColor3 = val and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(40, 40, 40) }, 0.15)
		tween(checkmark, { TextTransparency = val and 0 or 1 }, 0.1)
		if fire and callback then pcall(callback, val) end
	end

	self._conn(clickBtn.MouseButton1Click, function()
		if _disabled then return end
		setValue(not state, true)
	end)

	if self._activeTab then table.insert(self._activeTab.items, row) end
	self:resize()

	return {
		set         = function(v, silent) setValue(v, not silent) end,
		get         = function() return state end,
		setDisabled = function(val)
			_disabled = val
			tween(box, { BackgroundTransparency = val and 0.5 or 0 }, 0.15)
		end,
	}
end

function UILibrary:addRadioGroup(name, options, default, callback, flag)
	if not options or #options == 0 then options = { "Option 1" } end
	local parent, _, layoutOrder = self:_getTarget()
	local row     = makeRow(parent, layoutOrder)
	local selected = default or options[1]

	if flag then globalFlags[flag] = selected end

	local inner = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent                 = row,
	})
	make("UIListLayout", {
		Padding   = UDim.new(0, 2),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent    = inner,
	})
	make("UIPadding", {
		PaddingLeft  = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
		PaddingTop   = UDim.new(0, 2),
		Parent       = inner,
	})

	if name and name ~= "" then
		make("TextLabel", {
			Size                   = UDim2.new(1, 0, 0, 18),
			BackgroundTransparency = 1,
			Text                   = name,
			TextColor3             = Color3.fromRGB(160, 160, 160),
			TextSize               = 10,
			Font                   = Enum.Font.GothamBold,
			TextXAlignment         = Enum.TextXAlignment.Left,
			LayoutOrder            = 0,
			Parent                 = inner,
		})
	end

	local radioButtons = {}

	local function setSelected(val, fire)
		selected = val
		if flag then globalFlags[flag] = val end
		for _, rb in pairs(radioButtons) do
			local isActive = rb.value == val
			tween(rb.dot, { BackgroundColor3 = isActive and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(40, 40, 40) }, 0.15)
			tween(rb.dot, { Size = isActive and UDim2.new(0, 10, 0, 10) or UDim2.new(0, 6, 0, 6) }, 0.15)
			rb.label.TextColor3 = isActive and Color3.fromRGB(240, 240, 240) or Color3.fromRGB(180, 180, 180)
		end
		if fire and callback then pcall(callback, val) end
	end

	for i, opt in ipairs(options) do
		local optRow = make("Frame", {
			Size                   = UDim2.new(1, 0, 0, 26),
			BackgroundTransparency = 1,
			LayoutOrder            = i,
			Parent                 = inner,
		})
		make("UIListLayout", {
			FillDirection     = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding           = UDim.new(0, 8),
			Parent            = optRow,
		})

		local ring = make("Frame", {
			Size             = UDim2.new(0, 16, 0, 16),
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BorderSizePixel  = 0,
			LayoutOrder      = 1,
			Parent           = optRow,
		})
		addCorner(ring, 8)
		make("UIStroke", { Color = Color3.fromRGB(80, 80, 80), Thickness = 1, Parent = ring })

		local isActive = opt == selected
		local dot = make("Frame", {
			Size             = isActive and UDim2.new(0, 10, 0, 10) or UDim2.new(0, 6, 0, 6),
			AnchorPoint      = Vector2.new(0.5, 0.5),
			Position         = UDim2.new(0.5, 0, 0.5, 0),
			BackgroundColor3 = isActive and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(40, 40, 40),
			BorderSizePixel  = 0,
			Parent           = ring,
		})
		addCorner(dot, 6)

		local label = make("TextLabel", {
			Size                   = UDim2.new(1, -28, 1, 0),
			BackgroundTransparency = 1,
			Text                   = tostring(opt),
			TextColor3             = isActive and Color3.fromRGB(240, 240, 240) or Color3.fromRGB(180, 180, 180),
			TextSize               = 12,
			Font                   = Enum.Font.Gotham,
			TextXAlignment         = Enum.TextXAlignment.Left,
			LayoutOrder            = 2,
			Parent                 = optRow,
		})

		local clickBtn = make("TextButton", {
			Size                   = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text                   = "",
			Parent                 = optRow,
		})

		table.insert(radioButtons, { value = opt, dot = dot, label = label })

		self._conn(clickBtn.MouseButton1Click, function()
			setSelected(opt, true)
		end)
	end

	if self._activeTab then table.insert(self._activeTab.items, row) end
	self:resize()

	return {
		get = function() return selected end,
		set = function(v, silent) setSelected(v, not silent) end,
	}
end

function UILibrary:addSlider(name, min, max, default, step, callback, flag)
	if type(step) == "function" then callback = step step = 1 end
	step = (type(step) == "number" and step > 0) and step or 1
	if min >= max then return { set = function() end, get = function() return min end } end

	local range        = max - min
	local steps        = math.round(range / step)
	local correctedMax = min + steps * step

	local parent, _, layoutOrder = self:_getTarget()
	local row     = makeRow(parent, layoutOrder)
	local current = min + math.round((math.clamp(default or min, min, correctedMax) - min) / step) * step

	if flag then globalFlags[flag] = current end

	local inner = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent                 = row,
	})
	make("UIListLayout", {
		Padding   = UDim.new(0, 2),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent    = inner,
	})

	local headerRow = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 20),
		BackgroundTransparency = 1,
		LayoutOrder            = 1,
		Parent                 = inner,
	})
	make("UIPadding", {
		PaddingLeft  = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
		Parent       = headerRow,
	})
	make("TextLabel", {
		Size                   = UDim2.new(1, -60, 1, 0),
		BackgroundTransparency = 1,
		Text                   = name,
		TextColor3             = Color3.fromRGB(220, 220, 220),
		TextSize               = 12,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Left,
		TextWrapped            = true,
		Parent                 = headerRow,
	})
	local valueLabel = make("TextLabel", {
		Size                   = UDim2.new(0, 55, 1, 0),
		Position               = UDim2.new(1, -55, 0, 0),
		BackgroundTransparency = 1,
		Text                   = tostring(current),
		TextColor3             = Color3.fromRGB(160, 160, 160),
		TextSize               = 11,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Right,
		Parent                 = headerRow,
	})

	local sliderRow = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 18),
		BackgroundTransparency = 1,
		LayoutOrder            = 2,
		Parent                 = inner,
	})
	make("UIPadding", {
		PaddingLeft  = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
		Parent       = sliderRow,
	})

	local track = make("Frame", {
		Size             = UDim2.new(1, 0, 0, 6),
		Position         = UDim2.new(0, 0, 0.5, -3),
		BackgroundColor3 = Color3.fromRGB(40, 40, 40),
		BorderSizePixel  = 0,
		Parent           = sliderRow,
	})
	addCorner(track, 3)

	local function getProgress(val)
		return (val - min) / (correctedMax - min)
	end

	local fill = make("Frame", {
		Size             = UDim2.new(getProgress(current), 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(80, 200, 120),
		BorderSizePixel  = 0,
		Parent           = track,
	})
	addCorner(fill, 3)

	local knob = make("Frame", {
		Size             = UDim2.new(0, 14, 0, 14),
		AnchorPoint      = Vector2.new(0.5, 0.5),
		Position         = UDim2.new(getProgress(current), 0, 0.5, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel  = 0,
		ZIndex           = 3,
		Parent           = track,
	})
	addCorner(knob, 7)

	local _disabled = false

	local function snapValue(raw)
		return math.clamp(min + math.round((raw - min) / step) * step, min, correctedMax)
	end

	local function applyValue(x)
		if _disabled then return end
		local ratio   = math.clamp((x - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
		local snapped = snapValue(min + ratio * (correctedMax - min))
		current = snapped
		if flag then globalFlags[flag] = snapped end
		local p = getProgress(snapped)
		fill.Size       = UDim2.new(p, 0, 1, 0)
		knob.Position   = UDim2.new(p, 0, 0.5, 0)
		valueLabel.Text = tostring(snapped)
		if callback then pcall(callback, snapped) end
	end

	local sliderDragging = false
	self._conn(ui.InputChanged, function(inp)
		if sliderDragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
			applyValue(inp.Position.X)
		end
	end)
	self._conn(ui.InputEnded, function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			sliderDragging = false
		end
	end)
	self._conn(track.InputBegan, function(inp)
		if _disabled then return end
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			sliderDragging = true
			applyValue(inp.Position.X)
		end
	end)

	if self._activeTab then table.insert(self._activeTab.items, row) end
	self:resize()

	return {
		set = function(v)
			current = snapValue(v)
			if flag then globalFlags[flag] = current end
			local p = getProgress(current)
			fill.Size       = UDim2.new(p, 0, 1, 0)
			knob.Position   = UDim2.new(p, 0, 0.5, 0)
			valueLabel.Text = tostring(current)
		end,
		get         = function() return current end,
		setDisabled = function(val)
			_disabled = val
			tween(track, { BackgroundTransparency = val and 0.5 or 0 }, 0.15)
			tween(knob,  { BackgroundTransparency = val and 0.5 or 0 }, 0.15)
			tween(fill,  { BackgroundTransparency = val and 0.5 or 0 }, 0.15)
		end,
	}
end

function UILibrary:addTextBox(name, placeholder, maxLength, callback, options)
	if type(maxLength) == "function" then callback = maxLength maxLength = 200 end
	maxLength = maxLength or 200
	options = options or {}
	local liveCallback = options.liveCallback
	local flag         = options.flag
	local disabled     = options.disabled or false

	local parent, _, layoutOrder = self:_getTarget()
	local row = makeRow(parent, layoutOrder)

	local inner = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent                 = row,
	})
	make("UIListLayout", {
		Padding   = UDim.new(0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent    = inner,
	})
	make("UIPadding", {
		PaddingLeft  = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
		Parent       = inner,
	})

	make("TextLabel", {
		Size                   = UDim2.new(1, 0, 0, 16),
		BackgroundTransparency = 1,
		Text                   = name,
		TextColor3             = Color3.fromRGB(200, 200, 200),
		TextSize               = 11,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Left,
		TextWrapped            = true,
		AutomaticSize          = Enum.AutomaticSize.Y,
		LayoutOrder            = 1,
		Parent                 = inner,
	})

	local box = make("TextBox", {
		Size                   = UDim2.new(1, 0, 0, 26),
		BackgroundColor3       = Color3.fromRGB(15, 15, 15),
		BackgroundTransparency = disabled and 0.5 or 0.3,
		PlaceholderText        = placeholder or "",
		Text                   = "",
		TextColor3             = disabled and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(255, 255, 255),
		PlaceholderColor3      = Color3.fromRGB(100, 100, 100),
		TextSize               = 11,
		Font                   = Enum.Font.Gotham,
		BorderSizePixel        = 0,
		ClearTextOnFocus       = false,
		TextEditable           = not disabled,
		LayoutOrder            = 2,
		Parent                 = inner,
	})
	addCorner(box, 6)

	local _disabled = disabled

	self._conn(box:GetPropertyChangedSignal("Text"), function()
		if #box.Text > maxLength then box.Text = box.Text:sub(1, maxLength) end
		if flag then globalFlags[flag] = box.Text end
		if liveCallback then pcall(liveCallback, box.Text) end
	end)

	self._conn(box.FocusLost, function(enterPressed)
		if enterPressed and callback then pcall(callback, box.Text) end
	end)

	if self._activeTab then table.insert(self._activeTab.items, row) end
	self:resize()

	return {
		get   = function()  return box.Text end,
		set   = function(v)
			box.Text = tostring(v):sub(1, maxLength)
			if flag then globalFlags[flag] = box.Text end
		end,
		clear = function()  box.Text = "" end,
		setDisabled = function(val)
			_disabled = val
			box.TextEditable           = not val
			box.BackgroundTransparency = val and 0.5 or 0.3
			box.TextColor3             = val and Color3.fromRGB(80, 80, 80) or Color3.fromRGB(255, 255, 255)
		end,
	}
end

function UILibrary:addDropdown(name, options, default, callback, flag)
	if not options or #options == 0 then options = { "" } end

	local parent, _, layoutOrder = self:_getTarget()
	local row            = makeRow(parent, layoutOrder)
	local isOpen         = false
	local selected       = default or options[1]
	local currentOptions = { table.unpack(options) }

	if flag then globalFlags[flag] = selected end

	local inner = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent                 = row,
	})
	make("UIPadding", {
		PaddingLeft  = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
		Parent       = inner,
	})
	make("UIListLayout", {
		FillDirection     = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder         = Enum.SortOrder.LayoutOrder,
		Parent            = inner,
	})

	make("TextLabel", {
		Size                   = UDim2.new(0.5, 0, 0, 26),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Text                   = name,
		TextColor3             = Color3.fromRGB(220, 220, 220),
		TextSize               = 12,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Left,
		TextWrapped            = true,
		LayoutOrder            = 1,
		Parent                 = inner,
	})

	local dropBtn = make("TextButton", {
		Size                   = UDim2.new(0.5, -8, 0, 24),
		BackgroundColor3       = Color3.fromRGB(30, 30, 30),
		BackgroundTransparency = 0.3,
		Text                   = tostring(selected) .. " ▾",
		TextColor3             = Color3.fromRGB(220, 220, 220),
		TextSize               = 11,
		Font                   = Enum.Font.Gotham,
		BorderSizePixel        = 0,
		TextTruncate           = Enum.TextTruncate.AtEnd,
		LayoutOrder            = 2,
		Parent                 = inner,
	})
	addCorner(dropBtn, 7)

	local panel = make("Frame", {
		Size                   = UDim2.new(0, 140, 0, 0),
		BackgroundColor3       = Color3.fromRGB(18, 18, 18),
		BackgroundTransparency = 0.1,
		BorderSizePixel        = 0,
		ZIndex                 = 500,
		Visible                = false,
		Parent                 = self.screenGui,
	})
	addCorner(panel, 8)
	make("UIStroke", {
		Color     = Color3.fromRGB(50, 50, 50),
		Thickness = 1,
		Parent    = panel,
	})

	local panelLayout = make("UIListLayout", {
		Padding   = UDim.new(0, 2),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent    = panel,
	})
	make("UIPadding", {
		PaddingTop    = UDim.new(0, 4),
		PaddingBottom = UDim.new(0, 4),
		PaddingLeft   = UDim.new(0, 4),
		PaddingRight  = UDim.new(0, 4),
		Parent        = panel,
	})

	local function updatePanelPosition()
		local ap     = dropBtn.AbsolutePosition
		local as     = dropBtn.AbsoluteSize
		local vp     = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
		local panelH = panel.AbsoluteSize.Y
		local yBelow = ap.Y + as.Y + 2
		local yAbove = ap.Y - panelH - 2
		local finalY = (yBelow + panelH > vp.Y) and yAbove or yBelow
		local finalX = math.clamp(ap.X, 4, vp.X - 144)
		panel.Position = UDim2.new(0, finalX, 0, finalY)
	end

	self._conn(panelLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
		if not panel.Parent then return end
		local vp       = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
		local contentH = panelLayout.AbsoluteContentSize.Y + 8
		local maxH     = vp.Y - 20
		panel.Size = UDim2.new(0, 140, 0, math.min(contentH, math.max(maxH, 30)))
		if isOpen then updatePanelPosition() end
	end)

	local optionConns   = {}
	local optionConnSet = {}

	local function closePanel()
		isOpen        = false
		panel.Visible = false
	end

	local _disabled = false

	local function buildOption(index, value)
		local optBtn = make("TextButton", {
			Size                   = UDim2.new(1, 0, 0, 24),
			BackgroundColor3       = Color3.fromRGB(30, 30, 30),
			BackgroundTransparency = 0.5,
			Text                   = value,
			TextColor3             = Color3.fromRGB(220, 220, 220),
			TextSize               = 11,
			Font                   = Enum.Font.Gotham,
			BorderSizePixel        = 0,
			ZIndex                 = 501,
			LayoutOrder            = index,
			Parent                 = panel,
		})
		addCorner(optBtn, 6)

		local function reg(c)
			table.insert(optionConns, c)
			optionConnSet[c] = true
			table.insert(self._conns, c)
		end

		reg(optBtn.MouseEnter:Connect(function() tween(optBtn, { BackgroundTransparency = 0.1 }, 0.1) end))
		reg(optBtn.MouseLeave:Connect(function() tween(optBtn, { BackgroundTransparency = 0.5 }, 0.1) end))
		reg(optBtn.MouseButton1Click:Connect(function()
			selected      = value
			if flag then globalFlags[flag] = value end
			dropBtn.Text  = tostring(value) .. " ▾"
			closePanel()
			if callback then pcall(callback, value) end
		end))
	end

	for i, v in ipairs(currentOptions) do buildOption(i, v) end

	self._conn(dropBtn.MouseButton1Click, function()
		if _disabled then return end
		if isOpen then
			closePanel()
		else
			isOpen        = true
			updatePanelPosition()
			panel.Visible = true
		end
	end)

	self._conn(dropBtn:GetPropertyChangedSignal("AbsolutePosition"), function()
		if isOpen then updatePanelPosition() end
	end)

	if self._activeTab then table.insert(self._activeTab.items, row) end
	self:resize()

	return {
		get = function() return selected end,
		set = function(v)
			selected     = v
			if flag then globalFlags[flag] = v end
			dropBtn.Text = tostring(v) .. " ▾"
		end,
		setDisabled = function(val)
			_disabled = val
			tween(dropBtn, { BackgroundTransparency = val and 0.6 or 0.3 }, 0.15)
			dropBtn.Active = not val
		end,
		refresh = function(newOptions)
			if not newOptions or #newOptions == 0 then newOptions = { "" } end
			currentOptions = { table.unpack(newOptions) }
			for _, c in ipairs(optionConns) do
				if c and c.Connected then c:Disconnect() end
			end
			for i = #self._conns, 1, -1 do
				if optionConnSet[self._conns[i]] then table.remove(self._conns, i) end
			end
			optionConns   = {}
			optionConnSet = {}
			for _, ch in pairs(panel:GetChildren()) do
				if ch:IsA("TextButton") then ch:Destroy() end
			end
			for i, v in ipairs(currentOptions) do buildOption(i, v) end
		end,
		destroy = function()
			closePanel()
			for _, c in ipairs(optionConns) do
				if c and c.Connected then c:Disconnect() end
			end
			for i = #self._conns, 1, -1 do
				if optionConnSet[self._conns[i]] then table.remove(self._conns, i) end
			end
			optionConns   = {}
			optionConnSet = {}
			panel:Destroy()
		end,
	}
end

function UILibrary:addMultiDropdown(name, options, defaults, callback, flag)
	if not options or #options == 0 then options = { "" } end
	defaults = defaults or {}

	local parent, _, layoutOrder = self:_getTarget()
	local row           = makeRow(parent, layoutOrder)
	local isOpen        = false
	local selected      = {}
	for _, v in ipairs(defaults) do selected[v] = true end
	local currentOptions = { table.unpack(options) }

	local function getSelectedList()
		local list = {}
		for _, opt in ipairs(currentOptions) do
			if selected[opt] then table.insert(list, opt) end
		end
		return list
	end

	local function updateBtnText()
		local list = getSelectedList()
		if #list == 0 then
			return "None ▾"
		elseif #list == 1 then
			return list[1] .. " ▾"
		else
			return list[1] .. " +" .. (#list - 1) .. " ▾"
		end
	end

	if flag then globalFlags[flag] = getSelectedList() end

	local inner = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent                 = row,
	})
	make("UIPadding", {
		PaddingLeft  = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
		Parent       = inner,
	})
	make("UIListLayout", {
		FillDirection     = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder         = Enum.SortOrder.LayoutOrder,
		Parent            = inner,
	})

	make("TextLabel", {
		Size                   = UDim2.new(0.5, 0, 0, 26),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Text                   = name,
		TextColor3             = Color3.fromRGB(220, 220, 220),
		TextSize               = 12,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Left,
		TextWrapped            = true,
		LayoutOrder            = 1,
		Parent                 = inner,
	})

	local dropBtn = make("TextButton", {
		Size                   = UDim2.new(0.5, -8, 0, 24),
		BackgroundColor3       = Color3.fromRGB(30, 30, 30),
		BackgroundTransparency = 0.3,
		Text                   = updateBtnText(),
		TextColor3             = Color3.fromRGB(220, 220, 220),
		TextSize               = 11,
		Font                   = Enum.Font.Gotham,
		BorderSizePixel        = 0,
		TextTruncate           = Enum.TextTruncate.AtEnd,
		LayoutOrder            = 2,
		Parent                 = inner,
	})
	addCorner(dropBtn, 7)

	local panel = make("Frame", {
		Size                   = UDim2.new(0, 160, 0, 0),
		BackgroundColor3       = Color3.fromRGB(18, 18, 18),
		BackgroundTransparency = 0.1,
		BorderSizePixel        = 0,
		ZIndex                 = 500,
		Visible                = false,
		Parent                 = self.screenGui,
	})
	addCorner(panel, 8)
	make("UIStroke", { Color = Color3.fromRGB(50, 50, 50), Thickness = 1, Parent = panel })

	local panelLayout = make("UIListLayout", {
		Padding   = UDim.new(0, 2),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent    = panel,
	})
	make("UIPadding", {
		PaddingTop    = UDim.new(0, 4),
		PaddingBottom = UDim.new(0, 4),
		PaddingLeft   = UDim.new(0, 4),
		PaddingRight  = UDim.new(0, 4),
		Parent        = panel,
	})

	local function updatePanelPosition()
		local ap     = dropBtn.AbsolutePosition
		local as     = dropBtn.AbsoluteSize
		local vp     = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
		local panelH = panel.AbsoluteSize.Y
		local yBelow = ap.Y + as.Y + 2
		local yAbove = ap.Y - panelH - 2
		local finalY = (yBelow + panelH > vp.Y) and yAbove or yBelow
		local finalX = math.clamp(ap.X, 4, vp.X - 164)
		panel.Position = UDim2.new(0, finalX, 0, finalY)
	end

	self._conn(panelLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
		if not panel.Parent then return end
		local vp       = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
		local contentH = panelLayout.AbsoluteContentSize.Y + 8
		panel.Size     = UDim2.new(0, 160, 0, math.min(contentH, vp.Y - 20))
		if isOpen then updatePanelPosition() end
	end)

	local checkFrames   = {}
	local optionConns   = {}
	local optionConnSet = {}

	local function rebuildOptions()
		for _, c in ipairs(optionConns) do
			if c and c.Connected then c:Disconnect() end
		end
		for i = #self._conns, 1, -1 do
			if optionConnSet[self._conns[i]] then table.remove(self._conns, i) end
		end
		optionConns   = {}
		optionConnSet = {}
		checkFrames   = {}
		for _, ch in pairs(panel:GetChildren()) do
			if ch:IsA("Frame") or ch:IsA("TextButton") then ch:Destroy() end
		end

		for i, value in ipairs(currentOptions) do
			local optRow = make("Frame", {
				Size                   = UDim2.new(1, 0, 0, 26),
				BackgroundColor3       = Color3.fromRGB(28, 28, 28),
				BackgroundTransparency = 0.3,
				BorderSizePixel        = 0,
				ZIndex                 = 501,
				LayoutOrder            = i,
				Parent                 = panel,
			})
			addCorner(optRow, 5)

			local isChecked = selected[value] == true
			local cb = make("Frame", {
				Size             = UDim2.new(0, 14, 0, 14),
				Position         = UDim2.new(0, 6, 0.5, -7),
				BackgroundColor3 = isChecked and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(40, 40, 40),
				BorderSizePixel  = 0,
				ZIndex           = 502,
				Parent           = optRow,
			})
			addCorner(cb, 3)

			local checkTick = make("TextLabel", {
				Size                   = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Text                   = "✓",
				TextColor3             = Color3.fromRGB(255, 255, 255),
				TextSize               = 10,
				Font                   = Enum.Font.GothamBold,
				TextXAlignment         = Enum.TextXAlignment.Center,
				TextTransparency       = isChecked and 0 or 1,
				ZIndex                 = 503,
				Parent                 = cb,
			})

			make("TextLabel", {
				Size                   = UDim2.new(1, -28, 1, 0),
				Position               = UDim2.new(0, 26, 0, 0),
				BackgroundTransparency = 1,
				Text                   = tostring(value),
				TextColor3             = Color3.fromRGB(220, 220, 220),
				TextSize               = 11,
				Font                   = Enum.Font.Gotham,
				TextXAlignment         = Enum.TextXAlignment.Left,
				ZIndex                 = 502,
				Parent                 = optRow,
			})

			local clickBtn = make("TextButton", {
				Size                   = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Text                   = "",
				ZIndex                 = 504,
				Parent                 = optRow,
			})

			table.insert(checkFrames, { value = value, box = cb, tick = checkTick })

			local function reg(c)
				table.insert(optionConns, c)
				optionConnSet[c] = true
				table.insert(self._conns, c)
			end

			reg(clickBtn.MouseButton1Click:Connect(function()
				selected[value] = not selected[value]
				local nowChecked = selected[value]
				tween(cb, { BackgroundColor3 = nowChecked and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(40, 40, 40) }, 0.12)
				tween(checkTick, { TextTransparency = nowChecked and 0 or 1 }, 0.1)
				dropBtn.Text = updateBtnText()
				if flag then globalFlags[flag] = getSelectedList() end
				if callback then pcall(callback, getSelectedList()) end
			end))
		end
	end

	rebuildOptions()

	self._conn(dropBtn.MouseButton1Click, function()
		if isOpen then
			isOpen        = false
			panel.Visible = false
		else
			isOpen        = true
			updatePanelPosition()
			panel.Visible = true
		end
	end)

	self._conn(dropBtn:GetPropertyChangedSignal("AbsolutePosition"), function()
		if isOpen then updatePanelPosition() end
	end)

	if self._activeTab then table.insert(self._activeTab.items, row) end
	self:resize()

	return {
		get     = getSelectedList,
		set     = function(list)
			selected = {}
			for _, v in ipairs(list) do selected[v] = true end
			if flag then globalFlags[flag] = list end
			dropBtn.Text = updateBtnText()
			rebuildOptions()
		end,
		refresh = function(newOptions)
			currentOptions = newOptions or {}
			rebuildOptions()
		end,
	}
end

function UILibrary:addColorPicker(name, defaultColor, callback, flag)
	defaultColor = defaultColor or Color3.fromRGB(255, 255, 255)

	local parent, _, layoutOrder = self:_getTarget()
	local row    = makeRow(parent, layoutOrder)
	local isOpen = false

	local h, s, v = Color3.toHSV(defaultColor)
	local currentColor = defaultColor

	if flag then globalFlags[flag] = currentColor end

	local inner = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent                 = row,
	})
	make("UIPadding", {
		PaddingLeft  = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
		Parent       = inner,
	})
	make("UIListLayout", {
		FillDirection     = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder         = Enum.SortOrder.LayoutOrder,
		Parent            = inner,
	})

	make("TextLabel", {
		Size                   = UDim2.new(1, -60, 0, 28),
		BackgroundTransparency = 1,
		Text                   = name,
		TextColor3             = Color3.fromRGB(220, 220, 220),
		TextSize               = 12,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Left,
		TextWrapped            = true,
		LayoutOrder            = 1,
		Parent                 = inner,
	})

	local preview = make("TextButton", {
		Size                   = UDim2.new(0, 42, 0, 22),
		BackgroundColor3       = currentColor,
		BorderSizePixel        = 0,
		Text                   = "",
		LayoutOrder            = 2,
		Parent                 = inner,
	})
	addCorner(preview, 6)
	make("UIStroke", { Color = Color3.fromRGB(80, 80, 80), Thickness = 1, Parent = preview })

	local pickerPanel = make("Frame", {
		Size                   = UDim2.new(0, 220, 0, 210),
		BackgroundColor3       = Color3.fromRGB(16, 16, 16),
		BackgroundTransparency = 0.05,
		BorderSizePixel        = 0,
		ZIndex                 = 500,
		Visible                = false,
		Parent                 = self.screenGui,
	})
	addCorner(pickerPanel, 10)
	make("UIStroke", { Color = Color3.fromRGB(55, 55, 55), Thickness = 1, Parent = pickerPanel })

	local function updatePickerPosition()
		local ap = preview.AbsolutePosition
		local as = preview.AbsoluteSize
		local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1920, 1080)
		local px = math.clamp(ap.X, 4, vp.X - 224)
		local py = ap.Y + as.Y + 4
		if py + 210 > vp.Y then py = ap.Y - 214 end
		pickerPanel.Position = UDim2.new(0, px, 0, py)
	end

	local svCanvas = make("ImageLabel", {
		Size                   = UDim2.new(0, 190, 0, 120),
		Position               = UDim2.new(0, 15, 0, 14),
		Image                  = "rbxassetid://4155801252",
		BackgroundColor3       = Color3.fromHSV(h, 1, 1),
		BorderSizePixel        = 0,
		ZIndex                 = 501,
		Parent                 = pickerPanel,
	})
	addCorner(svCanvas, 5)

	local svCursor = make("Frame", {
		Size             = UDim2.new(0, 10, 0, 10),
		AnchorPoint      = Vector2.new(0.5, 0.5),
		Position         = UDim2.new(s, 0, 1 - v, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel  = 0,
		ZIndex           = 502,
		Parent           = svCanvas,
	})
	addCorner(svCursor, 5)
	make("UIStroke", { Color = Color3.fromRGB(0, 0, 0), Thickness = 1.5, Parent = svCursor })

	local hueBar = make("ImageLabel", {
		Size             = UDim2.new(0, 190, 0, 14),
		Position         = UDim2.new(0, 15, 0, 142),
		Image            = "rbxassetid://4155806578",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel  = 0,
		ZIndex           = 501,
		Parent           = pickerPanel,
	})
	addCorner(hueBar, 4)

	local hueCursor = make("Frame", {
		Size             = UDim2.new(0, 6, 1, 2),
		AnchorPoint      = Vector2.new(0.5, 0.5),
		Position         = UDim2.new(h, 0, 0.5, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel  = 0,
		ZIndex           = 502,
		Parent           = hueBar,
	})
	addCorner(hueCursor, 3)
	make("UIStroke", { Color = Color3.fromRGB(0, 0, 0), Thickness = 1, Parent = hueCursor })

	local hexInput = make("TextBox", {
		Size                   = UDim2.new(0, 100, 0, 22),
		Position               = UDim2.new(0, 15, 0, 166),
		BackgroundColor3       = Color3.fromRGB(25, 25, 25),
		BackgroundTransparency = 0.2,
		Text                   = string.format("#%02X%02X%02X", math.floor(currentColor.R * 255), math.floor(currentColor.G * 255), math.floor(currentColor.B * 255)),
		TextColor3             = Color3.fromRGB(220, 220, 220),
		PlaceholderColor3      = Color3.fromRGB(100, 100, 100),
		TextSize               = 11,
		Font                   = Enum.Font.Gotham,
		BorderSizePixel        = 0,
		ClearTextOnFocus       = false,
		ZIndex                 = 501,
		Parent                 = pickerPanel,
	})
	addCorner(hexInput, 5)

	local colorPreviewSmall = make("Frame", {
		Size             = UDim2.new(0, 60, 0, 22),
		Position         = UDim2.new(0, 125, 0, 166),
		BackgroundColor3 = currentColor,
		BorderSizePixel  = 0,
		ZIndex           = 501,
		Parent           = pickerPanel,
	})
	addCorner(colorPreviewSmall, 5)
	make("UIStroke", { Color = Color3.fromRGB(60, 60, 60), Thickness = 1, Parent = colorPreviewSmall })

	local closePickerBtn = make("TextButton", {
		Size                   = UDim2.new(1, -18, 0, 16),
		Position               = UDim2.new(0, 9, 1, -20),
		BackgroundColor3       = Color3.fromRGB(35, 35, 35),
		BackgroundTransparency = 0.3,
		Text                   = "Close",
		TextColor3             = Color3.fromRGB(160, 160, 160),
		TextSize               = 10,
		Font                   = Enum.Font.Gotham,
		BorderSizePixel        = 0,
		ZIndex                 = 501,
		Parent                 = pickerPanel,
	})
	addCorner(closePickerBtn, 4)

	local function applyColor(newH, newS, newV)
		h = math.clamp(newH, 0, 1)
		s = math.clamp(newS, 0, 1)
		v = math.clamp(newV, 0, 1)
		currentColor = Color3.fromHSV(h, s, v)
		if flag then globalFlags[flag] = currentColor end
		svCanvas.BackgroundColor3         = Color3.fromHSV(h, 1, 1)
		svCursor.Position                  = UDim2.new(s, 0, 1 - v, 0)
		hueCursor.Position                 = UDim2.new(h, 0, 0.5, 0)
		preview.BackgroundColor3           = currentColor
		colorPreviewSmall.BackgroundColor3 = currentColor
		hexInput.Text = string.format("#%02X%02X%02X",
			math.floor(currentColor.R * 255),
			math.floor(currentColor.G * 255),
			math.floor(currentColor.B * 255))
		if callback then pcall(callback, currentColor) end
	end

	local svDragging  = false
	local hueDragging = false

	self._conn(svCanvas.InputBegan, function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			svDragging = true
			local rx = math.clamp((inp.Position.X - svCanvas.AbsolutePosition.X) / svCanvas.AbsoluteSize.X, 0, 1)
			local ry = math.clamp((inp.Position.Y - svCanvas.AbsolutePosition.Y) / svCanvas.AbsoluteSize.Y, 0, 1)
			applyColor(h, rx, 1 - ry)
		end
	end)

	self._conn(hueBar.InputBegan, function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			hueDragging = true
			local rx = math.clamp((inp.Position.X - hueBar.AbsolutePosition.X) / hueBar.AbsoluteSize.X, 0, 1)
			applyColor(rx, s, v)
		end
	end)

	self._conn(ui.InputChanged, function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
			if svDragging then
				local rx = math.clamp((inp.Position.X - svCanvas.AbsolutePosition.X) / svCanvas.AbsoluteSize.X, 0, 1)
				local ry = math.clamp((inp.Position.Y - svCanvas.AbsolutePosition.Y) / svCanvas.AbsoluteSize.Y, 0, 1)
				applyColor(h, rx, 1 - ry)
			elseif hueDragging then
				local rx = math.clamp((inp.Position.X - hueBar.AbsolutePosition.X) / hueBar.AbsoluteSize.X, 0, 1)
				applyColor(rx, s, v)
			end
		end
	end)

	self._conn(ui.InputEnded, function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			svDragging  = false
			hueDragging = false
		end
	end)

	self._conn(hexInput.FocusLost, function(enter)
		if enter then
			local hex = hexInput.Text:gsub("#", "")
			if #hex == 6 then
				local ok, r, g, b = pcall(function()
					return tonumber("0x" .. hex:sub(1, 2)),
					       tonumber("0x" .. hex:sub(3, 4)),
					       tonumber("0x" .. hex:sub(5, 6))
				end)
				if ok and r and g and b then
					local newColor = Color3.fromRGB(r, g, b)
					local nh, ns, nv = Color3.toHSV(newColor)
					applyColor(nh, ns, nv)
				end
			end
		end
	end)

	self._conn(preview.MouseButton1Click, function()
		if isOpen then
			isOpen              = false
			pickerPanel.Visible = false
		else
			isOpen              = true
			updatePickerPosition()
			pickerPanel.Visible = true
		end
	end)

	self._conn(closePickerBtn.MouseButton1Click, function()
		isOpen              = false
		pickerPanel.Visible = false
	end)

	self._conn(preview:GetPropertyChangedSignal("AbsolutePosition"), function()
		if isOpen then updatePickerPosition() end
	end)

	if self._activeTab then table.insert(self._activeTab.items, row) end
	self:resize()

	return {
		get = function() return currentColor end,
		set = function(color)
			local nh, ns, nv = Color3.toHSV(color)
			applyColor(nh, ns, nv)
		end,
		destroy = function()
			isOpen = false
			pickerPanel:Destroy()
		end,
	}
end

function UILibrary:addKeybind(name, defaultKey, callback)
	local parent, _, layoutOrder = self:_getTarget()
	local row         = makeRow(parent, layoutOrder)
	local currentKey  = defaultKey
	local isListening = false
	local listenConn  = nil

	local inner = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent                 = row,
	})
	make("UIPadding", {
		PaddingLeft  = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
		Parent       = inner,
	})
	make("UIListLayout", {
		FillDirection     = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder         = Enum.SortOrder.LayoutOrder,
		Parent            = inner,
	})

	make("TextLabel", {
		Size                   = UDim2.new(1, -90, 0, 26),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Text                   = name,
		TextColor3             = Color3.fromRGB(220, 220, 220),
		TextSize               = 12,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Left,
		TextWrapped            = true,
		LayoutOrder            = 1,
		Parent                 = inner,
	})

	local keyBtn = make("TextButton", {
		Size                   = UDim2.new(0, 76, 0, 24),
		BackgroundColor3       = Color3.fromRGB(30, 30, 30),
		BackgroundTransparency = 0.3,
		Text                   = currentKey and currentKey.Name or "None",
		TextColor3             = currentKey and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(160, 160, 160),
		TextSize               = 11,
		Font                   = Enum.Font.Gotham,
		BorderSizePixel        = 0,
		LayoutOrder            = 2,
		Parent                 = inner,
	})
	addCorner(keyBtn, 7)

	local function registerKey(keyCode)
		currentKey           = keyCode
		self._keybinds[name] = { keyCode = keyCode, callback = callback or function() end }
	end

	local function clearKey()
		currentKey           = nil
		keyBtn.Text          = "None"
		keyBtn.TextColor3    = Color3.fromRGB(160, 160, 160)
		self._keybinds[name] = nil
	end

	local function removeListenConn()
		if listenConn then
			if listenConn.Connected then listenConn:Disconnect() end
			local target = listenConn
			listenConn   = nil
			for i = #self._conns, 1, -1 do
				if self._conns[i] == target then table.remove(self._conns, i) break end
			end
		end
	end

	local function stopListening()
		isListening       = false
		self._listening   = false
		removeListenConn()
		keyBtn.Text       = currentKey and currentKey.Name or "None"
		keyBtn.TextColor3 = currentKey and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(160, 160, 160)
	end

	self._conn(keyBtn.MouseButton1Click, function()
		if self._closed then return end
		if isListening then stopListening() clearKey() return end
		removeListenConn()
		isListening       = true
		self._listening   = true
		keyBtn.Text       = "..."
		keyBtn.TextColor3 = Color3.fromRGB(255, 200, 60)

		listenConn = ui.InputBegan:Connect(function(inp, gp)
			if gp then return end
			if self._closed then stopListening() return end
			if inp.KeyCode ~= Enum.KeyCode.Unknown then
				isListening       = false
				self._listening   = false
				removeListenConn()
				registerKey(inp.KeyCode)
				keyBtn.Text       = inp.KeyCode.Name
				keyBtn.TextColor3 = Color3.fromRGB(80, 200, 120)
			end
		end)
		table.insert(self._conns, listenConn)
	end)

	if defaultKey then registerKey(defaultKey) end

	if self._activeTab then table.insert(self._activeTab.items, row) end
	self:resize()

	return {
		get = function() return currentKey end,
		set = function(v)
			currentKey        = v
			keyBtn.Text       = v and v.Name or "None"
			keyBtn.TextColor3 = v and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(160, 160, 160)
			if v then registerKey(v) else clearKey() end
		end,
	}
end

function UILibrary:addHoldButton(name, keyCode, holdDuration, onActive, onInactive)
	holdDuration = holdDuration or 1
	local parent, _, layoutOrder = self:_getTarget()
	local row          = makeRow(parent, layoutOrder)
	local isHolding    = false
	local isActive     = false
	local holdThread   = nil
	local mouseHolding = false
	local keyHolding   = false

	local inner = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent                 = row,
	})
	make("UIPadding", {
		PaddingLeft  = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
		Parent       = inner,
	})
	make("UIListLayout", {
		Padding   = UDim.new(0, 6),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent    = inner,
	})

	local topRow = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 26),
		BackgroundTransparency = 1,
		LayoutOrder            = 1,
		Parent                 = inner,
	})
	make("UIListLayout", {
		FillDirection     = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder         = Enum.SortOrder.LayoutOrder,
		Parent            = topRow,
	})
	make("TextLabel", {
		Size                   = UDim2.new(1, -90, 1, 0),
		BackgroundTransparency = 1,
		Text                   = name,
		TextColor3             = Color3.fromRGB(220, 220, 220),
		TextSize               = 12,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Left,
		TextWrapped            = true,
		LayoutOrder            = 1,
		Parent                 = topRow,
	})
	local keyLabel = make("TextLabel", {
		Size                   = UDim2.new(0, 82, 1, 0),
		BackgroundTransparency = 1,
		Text                   = keyCode and ("[" .. keyCode.Name .. "]") or "[Hold]",
		TextColor3             = Color3.fromRGB(120, 120, 120),
		TextSize               = 10,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Right,
		LayoutOrder            = 2,
		Parent                 = topRow,
	})

	local barBg = make("Frame", {
		Size             = UDim2.new(1, 0, 0, 6),
		BackgroundColor3 = Color3.fromRGB(40, 40, 40),
		BorderSizePixel  = 0,
		LayoutOrder      = 2,
		Parent           = inner,
	})
	addCorner(barBg, 3)

	local barFill = make("Frame", {
		Size             = UDim2.new(0, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(80, 200, 120),
		BorderSizePixel  = 0,
		Parent           = barBg,
	})
	addCorner(barFill, 3)

	local statusLabel = make("TextLabel", {
		Size                   = UDim2.new(1, 0, 0, 14),
		BackgroundTransparency = 1,
		Text                   = "Inactive",
		TextColor3             = Color3.fromRGB(120, 120, 120),
		TextSize               = 10,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Left,
		LayoutOrder            = 3,
		Parent                 = inner,
	})

	local holdBtn = make("TextButton", {
		Size                   = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text                   = "",
		ZIndex                 = 5,
		Parent                 = row,
	})

	local function stopHold()
		if holdThread then task.cancel(holdThread) holdThread = nil end
		isHolding = false
		isActive  = false
		tween(barFill, { Size = UDim2.new(0, 0, 1, 0) }, 0.2)
		if statusLabel and statusLabel.Parent then
			statusLabel.Text       = "Inactive"
			statusLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
		end
		if onInactive then pcall(onInactive) end
	end

	local function startHold()
		if isHolding then return end
		isHolding = true
		isActive  = true
		if statusLabel and statusLabel.Parent then
			statusLabel.Text       = "Active"
			statusLabel.TextColor3 = Color3.fromRGB(80, 200, 120)
		end
		if onActive then pcall(onActive) end
		holdThread = task.spawn(function()
			local startTime = tick()
			while isHolding do
				local p = math.clamp((tick() - startTime) / holdDuration, 0, 1)
				if barFill and barFill.Parent then barFill.Size = UDim2.new(p, 0, 1, 0) end
				task.wait()
			end
		end)
	end

	self._conn(holdBtn.InputBegan, function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			mouseHolding = true
			startHold()
		end
	end)
	self._conn(holdBtn.InputEnded, function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			mouseHolding = false
			if not keyHolding then stopHold() end
		end
	end)

	if keyCode then
		keyLabel.Text = "[" .. keyCode.Name .. "] or [Hold]"
		self._conn(ui.InputBegan, function(inp, gp)
			if gp then return end
			if self._closed then return end
			if self._listening then return end
			if inp.KeyCode == keyCode then keyHolding = true startHold() end
		end)
		self._conn(ui.InputEnded, function(inp)
			if inp.KeyCode == keyCode then
				keyHolding = false
				if not mouseHolding then stopHold() end
			end
		end)
	end

	if self._activeTab then table.insert(self._activeTab.items, row) end
	self:resize()

	return {
		isActive  = function() return isActive end,
		setActive = function(val)
			isActive = val
			if isActive then
				if barFill    and barFill.Parent    then barFill.Size         = UDim2.new(1, 0, 1, 0) end
				if statusLabel and statusLabel.Parent then
					statusLabel.Text       = "Active"
					statusLabel.TextColor3 = Color3.fromRGB(80, 200, 120)
				end
			else
				if barFill    and barFill.Parent    then tween(barFill, { Size = UDim2.new(0, 0, 1, 0) }, 0.2) end
				if statusLabel and statusLabel.Parent then
					statusLabel.Text       = "Inactive"
					statusLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
				end
			end
		end,
	}
end

function UILibrary:addSection(name)
	local parent, _, layoutOrder = self:_getTarget()

	local sectionFrame = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 22),
		BackgroundTransparency = 1,
		LayoutOrder            = layoutOrder,
		Parent                 = parent,
	})

	make("TextLabel", {
		Size                   = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text                   = name,
		TextColor3             = Color3.fromRGB(120, 120, 120),
		TextSize               = 10,
		Font                   = Enum.Font.GothamSemibold,
		TextXAlignment         = Enum.TextXAlignment.Center,
		TextYAlignment         = Enum.TextYAlignment.Center,
		BorderSizePixel        = 0,
		Parent                 = sectionFrame,
	})

	if self._activeTab then table.insert(self._activeTab.items, sectionFrame) end
	self:resize()
	return sectionFrame
end

function UILibrary:addSeparator()
	local parent, _, layoutOrder = self:_getTarget()

	local sep = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 10),
		BackgroundTransparency = 1,
		LayoutOrder            = layoutOrder,
		Parent                 = parent,
	})
	make("Frame", {
		Size             = UDim2.new(1, -16, 0, 1),
		Position         = UDim2.new(0, 8, 0.5, 0),
		BackgroundColor3 = Color3.fromRGB(45, 45, 45),
		BorderSizePixel  = 0,
		Parent           = sep,
	})

	if self._activeTab then table.insert(self._activeTab.items, sep) end
	self:resize()
	return sep
end

function UILibrary:addLabel(text)
	local parent, _, layoutOrder = self:_getTarget()

	local labelFrame = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder            = layoutOrder,
		Parent                 = parent,
	})
	make("UIPadding", {
		PaddingLeft   = UDim.new(0, 10),
		PaddingRight  = UDim.new(0, 10),
		PaddingTop    = UDim.new(0, 4),
		PaddingBottom = UDim.new(0, 4),
		Parent        = labelFrame,
	})

	local textLabel = make("TextLabel", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Text                   = text,
		TextColor3             = Color3.fromRGB(170, 170, 170),
		TextSize               = 11,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Left,
		TextWrapped            = true,
		RichText               = true,
		Parent                 = labelFrame,
	})

	if self._activeTab then table.insert(self._activeTab.items, labelFrame) end
	self:resize()

	return {
		set = function(v) textLabel.Text = v end,
		get = function()  return textLabel.Text end,
	}
end

function UILibrary:addParagraph(title, body)
	local parent, _, layoutOrder = self:_getTarget()
	local row = makeRow(parent, layoutOrder)

	local inner = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent                 = row,
	})
	make("UIListLayout", {
		Padding   = UDim.new(0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent    = inner,
	})
	make("UIPadding", {
		PaddingLeft   = UDim.new(0, 12),
		PaddingRight  = UDim.new(0, 12),
		PaddingTop    = UDim.new(0, 6),
		PaddingBottom = UDim.new(0, 6),
		Parent        = inner,
	})

	local titleLabel = make("TextLabel", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Text                   = title or "",
		TextColor3             = Color3.fromRGB(240, 240, 240),
		TextSize               = 13,
		Font                   = Enum.Font.GothamBold,
		TextXAlignment         = Enum.TextXAlignment.Left,
		TextWrapped            = true,
		RichText               = true,
		LayoutOrder            = 1,
		Parent                 = inner,
	})

	local bodyLabel = make("TextLabel", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Text                   = body or "",
		TextColor3             = Color3.fromRGB(170, 170, 170),
		TextSize               = 11,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Left,
		TextWrapped            = true,
		RichText               = true,
		LayoutOrder            = 2,
		Parent                 = inner,
	})

	if self._activeTab then table.insert(self._activeTab.items, row) end
	self:resize()

	return {
		setTitle = function(v) titleLabel.Text = v end,
		setBody  = function(v) bodyLabel.Text  = v end,
		getTitle = function()  return titleLabel.Text end,
		getBody  = function()  return bodyLabel.Text  end,
	}
end

function UILibrary:addStatus(name, initialValue)
	local parent, _, layoutOrder = self:_getTarget()
	local row = makeRow(parent, layoutOrder)

	local inner = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent                 = row,
	})
	make("UIPadding", {
		PaddingLeft  = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
		Parent       = inner,
	})
	make("UIListLayout", {
		FillDirection     = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder         = Enum.SortOrder.LayoutOrder,
		Parent            = inner,
	})

	make("TextLabel", {
		Size                   = UDim2.new(0.5, 0, 0, 26),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Text                   = name,
		TextColor3             = Color3.fromRGB(170, 170, 170),
		TextSize               = 11,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Left,
		TextWrapped            = true,
		LayoutOrder            = 1,
		Parent                 = inner,
	})

	local valueLabel = make("TextLabel", {
		Size                   = UDim2.new(0.5, 0, 0, 26),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Text                   = initialValue or "—",
		TextColor3             = Color3.fromRGB(80, 200, 120),
		TextSize               = 11,
		Font                   = Enum.Font.GothamBold,
		TextXAlignment         = Enum.TextXAlignment.Right,
		TextWrapped            = true,
		LayoutOrder            = 2,
		Parent                 = inner,
	})

	if self._activeTab then table.insert(self._activeTab.items, row) end
	self:resize()

	return {
		set = function(v, color)
			valueLabel.Text = tostring(v)
			if color then valueLabel.TextColor3 = color end
		end,
		get = function() return valueLabel.Text end,
	}
end

function UILibrary:addProgressBar(name, initialValue)
	initialValue = math.clamp(initialValue or 0, 0, 100)
	local parent, _, layoutOrder = self:_getTarget()
	local row     = makeRow(parent, layoutOrder)
	local current = initialValue

	local inner = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Parent                 = row,
	})
	make("UIListLayout", {
		Padding   = UDim.new(0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent    = inner,
	})
	make("UIPadding", {
		PaddingLeft  = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
		PaddingTop   = UDim.new(0, 4),
		Parent       = inner,
	})

	local headerRow = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 16),
		BackgroundTransparency = 1,
		LayoutOrder            = 1,
		Parent                 = inner,
	})
	make("TextLabel", {
		Size                   = UDim2.new(0.7, 0, 1, 0),
		BackgroundTransparency = 1,
		Text                   = name,
		TextColor3             = Color3.fromRGB(200, 200, 200),
		TextSize               = 11,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Left,
		Parent                 = headerRow,
	})
	local pctLabel = make("TextLabel", {
		Size                   = UDim2.new(0.3, 0, 1, 0),
		Position               = UDim2.new(0.7, 0, 0, 0),
		BackgroundTransparency = 1,
		Text                   = tostring(math.floor(current)) .. "%",
		TextColor3             = Color3.fromRGB(140, 140, 140),
		TextSize               = 10,
		Font                   = Enum.Font.Gotham,
		TextXAlignment         = Enum.TextXAlignment.Right,
		Parent                 = headerRow,
	})

	local track = make("Frame", {
		Size             = UDim2.new(1, 0, 0, 8),
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BorderSizePixel  = 0,
		LayoutOrder      = 2,
		Parent           = inner,
	})
	addCorner(track, 4)

	local fill = make("Frame", {
		Size             = UDim2.new(initialValue / 100, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(80, 200, 120),
		BorderSizePixel  = 0,
		Parent           = track,
	})
	addCorner(fill, 4)

	if self._activeTab then table.insert(self._activeTab.items, row) end
	self:resize()

	return {
		set = function(value, color)
			current = math.clamp(value, 0, 100)
			tween(fill, { Size = UDim2.new(current / 100, 0, 1, 0) }, 0.2)
			pctLabel.Text = tostring(math.floor(current)) .. "%"
			if color then tween(fill, { BackgroundColor3 = color }, 0.2) end
		end,
		get = function() return current end,
	}
end

function UILibrary:addPlayerList(labelOrCallback, callback)
	local toggleMode     = false
	local actionLabel    = "Select"
	local actionCallback = nil

	if type(labelOrCallback) == "function" then
		actionCallback = labelOrCallback
		toggleMode     = true
	elseif type(labelOrCallback) == "string" then
		actionLabel    = labelOrCallback
		actionCallback = callback
	end

	local parent, _, layoutOrder = self:_getTarget()

	local wrapper = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder            = layoutOrder,
		Parent                 = parent,
	})
	make("UIListLayout", {
		Padding   = UDim.new(0, 0),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent    = wrapper,
	})

	local header = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 28),
		BackgroundTransparency = 1,
		LayoutOrder            = 1,
		Parent                 = wrapper,
	})
	make("UIPadding", {
		PaddingLeft  = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
		Parent       = header,
	})
	make("UIListLayout", {
		FillDirection     = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder         = Enum.SortOrder.LayoutOrder,
		Parent            = header,
	})

	local countLabel = make("TextLabel", {
		Size                   = UDim2.new(1, -58, 1, 0),
		BackgroundTransparency = 1,
		Text                   = "Players  •  " .. #pl:GetPlayers(),
		TextColor3             = Color3.fromRGB(140, 140, 140),
		TextSize               = 10,
		Font                   = Enum.Font.GothamBold,
		TextXAlignment         = Enum.TextXAlignment.Left,
		LayoutOrder            = 1,
		Parent                 = header,
	})

	local refreshBtn = make("TextButton", {
		Size                   = UDim2.new(0, 54, 0, 20),
		BackgroundColor3       = Color3.fromRGB(30, 30, 30),
		BackgroundTransparency = 0.3,
		Text                   = "↻ Refresh",
		TextColor3             = Color3.fromRGB(160, 160, 160),
		TextSize               = 10,
		Font                   = Enum.Font.Gotham,
		BorderSizePixel        = 0,
		LayoutOrder            = 2,
		Parent                 = header,
	})
	addCorner(refreshBtn, 6)

	local listFrame = make("Frame", {
		Size                   = UDim2.new(1, 0, 0, 0),
		AutomaticSize          = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder            = 2,
		Parent                 = wrapper,
	})
	make("UIListLayout", {
		Padding   = UDim.new(0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent    = listFrame,
	})
	make("UIPadding", {
		PaddingTop    = UDim.new(0, 2),
		PaddingBottom = UDim.new(0, 2),
		Parent        = listFrame,
	})

	local libRef         = self
	local selectedPlayer = nil
	local cardMap        = {}
	local pendingThumbs  = {}
	local buildConns     = {}
	local buildConnsSet  = {}

	local function buildList()
		for _, c in ipairs(buildConns) do
			if c and c.Connected then c:Disconnect() end
		end
		for i = #libRef._conns, 1, -1 do
			if buildConnsSet[libRef._conns[i]] then table.remove(libRef._conns, i) end
		end
		buildConns    = {}
		buildConnsSet = {}

		local function bConn(signal, fn)
			local c = signal:Connect(fn)
			table.insert(buildConns, c)
			buildConnsSet[c] = true
			table.insert(libRef._conns, c)
			return c
		end

		for _, pending in ipairs(pendingThumbs) do pending.cancelled = true end
		pendingThumbs  = {}
		selectedPlayer = nil
		cardMap        = {}

		for _, ch in pairs(listFrame:GetChildren()) do
			if not ch:IsA("UIListLayout") and not ch:IsA("UIPadding") then ch:Destroy() end
		end

		local players = pl:GetPlayers()
		countLabel.Text = "Players  •  " .. #players

		for idx, player in ipairs(players) do
			local card = make("Frame", {
				Size                   = UDim2.new(1, 0, 0, 52),
				BackgroundColor3       = Color3.fromRGB(20, 20, 20),
				BackgroundTransparency = 0.4,
				BorderSizePixel        = 0,
				LayoutOrder            = idx,
				Parent                 = listFrame,
			})
			addCorner(card, 10)
			cardMap[player] = card

			local thumbImg = make("ImageLabel", {
				Size                   = UDim2.new(0, 38, 0, 38),
				Position               = UDim2.new(0, 8, 0.5, -19),
				BackgroundColor3       = Color3.fromRGB(30, 30, 30),
				BackgroundTransparency = 0.5,
				BorderSizePixel        = 0,
				Image                  = "",
				Parent                 = card,
			})
			addCorner(thumbImg, 8)

			local textRight = (not toggleMode and actionCallback) and -134 or -58

			make("TextLabel", {
				Size           = UDim2.new(1, textRight, 0, 18),
				Position       = UDim2.new(0, 54, 0, 8),
				BackgroundTransparency = 1,
				Text           = player.DisplayName,
				TextColor3     = Color3.fromRGB(240, 240, 240),
				TextSize       = 12,
				Font           = Enum.Font.GothamBold,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate   = Enum.TextTruncate.AtEnd,
				Parent         = card,
			})
			make("TextLabel", {
				Size           = UDim2.new(1, textRight, 0, 14),
				Position       = UDim2.new(0, 54, 0, 28),
				BackgroundTransparency = 1,
				Text           = "@" .. player.Name,
				TextColor3     = Color3.fromRGB(110, 110, 110),
				TextSize       = 10,
				Font           = Enum.Font.Gotham,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate   = Enum.TextTruncate.AtEnd,
				Parent         = card,
			})

			if toggleMode then
				local clickBtn = make("TextButton", {
					Size                   = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					Text                   = "",
					Parent                 = card,
				})
				bConn(clickBtn.MouseButton1Click, function()
					if selectedPlayer and cardMap[selectedPlayer] and cardMap[selectedPlayer].Parent then
						tween(cardMap[selectedPlayer], { BackgroundColor3 = Color3.fromRGB(20, 20, 20), BackgroundTransparency = 0.4 }, 0.15)
					end
					if selectedPlayer == player then
						selectedPlayer = nil
						if actionCallback then pcall(actionCallback, player, false) end
					else
						selectedPlayer = player
						tween(card, { BackgroundColor3 = Color3.fromRGB(20, 80, 30), BackgroundTransparency = 0.25 }, 0.15)
						if actionCallback then pcall(actionCallback, player, true) end
					end
				end)
			else
				if actionCallback then
					local actBtn = make("TextButton", {
						Size                   = UDim2.new(0, 68, 0, 26),
						Position               = UDim2.new(1, -76, 0.5, -13),
						BackgroundColor3       = Color3.fromRGB(35, 35, 35),
						BackgroundTransparency = 0.2,
						Text                   = actionLabel,
						TextColor3             = Color3.fromRGB(220, 220, 220),
						TextSize               = 11,
						Font                   = Enum.Font.Gotham,
						BorderSizePixel        = 0,
						Parent                 = card,
					})
					addCorner(actBtn, 7)
					bConn(actBtn.MouseEnter,        function() tween(actBtn, { BackgroundTransparency = 0.0,  TextColor3 = Color3.fromRGB(255, 255, 255) }, 0.1) end)
					bConn(actBtn.MouseLeave,        function() tween(actBtn, { BackgroundTransparency = 0.2,  TextColor3 = Color3.fromRGB(220, 220, 220) }, 0.1) end)
					bConn(actBtn.MouseButton1Click, function() pcall(actionCallback, player) end)
				end
			end

			local thumbEntry = { cancelled = false }
			table.insert(pendingThumbs, thumbEntry)

			task.spawn(function()
				local ok, img = pcall(function()
					return pl:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
				end)
				if not thumbEntry.cancelled and ok and thumbImg and thumbImg.Parent then
					pcall(function() thumbImg.Image = img end)
				end
			end)
		end

		libRef:resize()
	end

	buildList()

	self._conn(refreshBtn.MouseEnter,        function() tween(refreshBtn, { BackgroundTransparency = 0.05, TextColor3 = Color3.fromRGB(200, 200, 200) }, 0.1) end)
	self._conn(refreshBtn.MouseLeave,        function() tween(refreshBtn, { BackgroundTransparency = 0.3,  TextColor3 = Color3.fromRGB(160, 160, 160) }, 0.1) end)
	self._conn(refreshBtn.MouseButton1Click, function() buildList() end)

	if self._activeTab then table.insert(self._activeTab.items, wrapper) end
	self:resize()

	return {
		refresh     = buildList,
		getSelected = function() return selectedPlayer end,
	}
end

function UILibrary:onClose(fn)
	table.insert(self._closeCallbacks, fn)
end

function UILibrary:addConnection(signal, fn)
	return self._conn(signal, fn)
end

function UILibrary:notify(title, subtitle, imageId, persistent, notifType)
	return sendNotif(title, subtitle, imageId, persistent, notifType)
end

function UILibrary:confirm(message, onConfirm, onCancel)
	showConfirmDialog(self.screenGui, message, onConfirm, onCancel)
end

return UILibrary
