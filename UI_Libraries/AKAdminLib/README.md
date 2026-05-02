# 🧩 AK Admin Library (Archived)

> [!IMPORTANT]
> **This is an archived preservation.** I do not own this library. I have modified the source code ONLY to ensure asset longevity and functional loading from this repository.

### 👤 Original Creator Information
*   **Developer:** [Absent](https://absent.wtf/me/)
*   **Official Documentation:** [AK Admin Library Docs](https://absent.wtf/AKADMINLIB/)

---

# AK Admin Library Documentation

A lightweight, high-performance admin UI library for Roblox. Build floating windows with tabs, toggles, sliders, dropdowns, and player lists—loaded in a single line.

## 01 — Installation

Load the library with `loadstring` in a LocalScript or executor. It attempts to parent to `CoreGui` first, then falls back to `PlayerGui` if access is denied.

```lua
local lb = loadstring(game:HttpGet("https://raw.githubusercontent.com/ofcWilliam/rbxscript-public-archive/refs/heads/main/UI_Libraries/AKAdminLib/source.lua"))()
```

---

## 02 — Quick Start

### The Tab Rule
Every element you add goes into whichever tab is currently active. The active tab is controlled entirely by `win:switchTab(tab)`. You must call `switchTab` before adding elements to any tab.

**The correct pattern:**
1. Create all tabs first using `win:addTab()`.
2. Call `win:switchTab(tabVar)` to make a tab active.
3. Add elements to that tab.
4. Repeat for other tabs.
5. Finally, call `win:switchTab(firstTab)` to set the default visible tab.

### Example Implementation
```lua
local lb  = loadstring(game:HttpGet("[https://absent.wtf/AKADMINLIB/LIB.lua](https://raw.githubusercontent.com/ofcWilliam/rbxscript-public-archive/refs/heads/main/UI_Libraries/AKAdminLib/source.lua)"))()
local win = lb.new("My Script")

local mainTab     = win:addTab("Main")
local settingsTab = win:addTab("Settings")

win:switchTab(mainTab)
win:addSection("Combat")
win:addToggle("ESP", false, function(v) print(v) end)
win:addSlider("Speed", 16, 100, 16, 1, function(v) print(v) end)

win:switchTab(settingsTab)
win:addSection("Preferences")
win:addToggle("Dark Mode", true, function(v) print(v) end)

-- Set the default tab
win:switchTab(mainTab)
```

---

## 03 — Window API

### `lb.new(title)`
Creates a new floating window. If a window with the same title exists, it is destroyed first.
* **title** (optional string): Shown as `AK ADMIN • title`.
* **Returns**: Window Object.

> [!IMPORTANT]
> **RightShift** is hardcoded to toggle the window's visibility.

### `win:minimize()`
Toggles between collapsed (title bar only) and expanded states.

### `win:onClose(callback)`
Registers a function to run when the window's X button is pressed. Use this to clean up your script state.

---

## 04 — Elements

### `win:addTab(name)`
Registers a new tab and returns a reference.
* **name** (string): The label shown on the tab button.

### `win:switchTab(tabRef)`
Sets the active insertion target for new elements.

### `win:addButton(name, callback)`
Adds a clickable button that triggers the callback on click.

### `win:addToggle(name, default, callback)`
Adds an animated pill-style toggle.
* **Returns**: Control object with `set(bool)`, `get()`, and `.Value`.

### `win:addSlider(name, min, max, default, step, callback)`
Adds a draggable slider with a live readout.
* **step** (optional): Snap increment (e.g., `1`, `0.1`, `5`).

### `win:addTextBox(name, placeholder, maxLength, callback)`
Adds a text input. The callback fires only when **Enter** is pressed.

### `win:addDropdown(name, options, default, callback)`
* **options**: Array of strings.
* **Returns**: Control with `refresh(newOptions)` and `set(str)`.

### `win:addKeybind(name, default, callback)`
Clicking enters listening mode for a new key.
* **default**: `Enum.KeyCode`.

### `win:addHoldButton(name, keyCode, holdDuration, onActive, onInactive)`
Active only while the key or mouse is held down. Includes a cosmetic progress bar.

### `win:addPlayerList(labelOrCallback, callback)`
* **Action Mode**: Pass a string label and a function. A button appears next to players.
* **Select Mode**: Pass just a function. Clicking a player card selects them.

---

## 05 — Layout & Misc

### `win:addSection(name)`
A horizontal rule with centered text for grouping elements.

### `win:addSeparator()`
A thin horizontal line.

### `win:addLabel(text)`
Read-only text row. Use `ctrl:set(newText)` to update the display.

### `win:addStatus(name, initialValue)`
Two-column row (Label | Value). Use `ctrl:set(text, color)` to update.

### `win:notify(title, body, imageId, persistent)`
Slides a toast notification from the right side of the screen.
* **imageId**: Plain number ID (no rbxassetid prefix).
* **persistent**: If true, does not auto-dismiss (default is 6s).

### `win:addConnection(signal, callback)`
Connects a signal (like `Heartbeat`) that is **automatically disconnected** when the window is closed.

---
## 🛡️ Audit Path
To view the 100% untouched original source or the full repository backup, navigate to:
*   [Original Source Code](./Original/source_raw.lua)

## 📜 License
N/A
