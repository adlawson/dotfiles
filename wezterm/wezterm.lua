local wezterm = require "wezterm"
local config = wezterm.config_builder()

-- Window
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.native_macos_fullscreen_mode = true
config.color_scheme = "Dracula (Official)"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

-- Font
config.font_size = 16.0
config.dpi = 144.0
config.font = wezterm.font_with_fallback {
  { family = "JetBrains Mono", weight = "Medium" },
  { family = "Noto Color Emoji", assume_emoji_presentation = true },
}

-- Keyboard
local wa = wezterm.action
config.enable_kitty_keyboard = true
config.disable_default_key_bindings = true
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true
config.keys = {
  -- Window
  { key = "n", mods = "CMD", action = wa.SpawnWindow },
  { key = "Space", mods = "CMD | SHIFT", action = wa.ToggleFullScreen },
  { key = "/", mods = "CMD | SHIFT", action = wa.ShowDebugOverlay },
  { key = "m", mods = "CMD", action = wa.DisableDefaultAssignment },
  { key = "=", mods = "CTRL", action = wa.IncreaseFontSize },
  { key = "-", mods = "CTRL", action = wa.DecreaseFontSize },
  { key = "0", mods = "CTRL", action = wa.ResetFontSize },

  -- Clipboard
  { key = "c", mods = "CMD", action = wa.CopyTo "Clipboard" },
  { key = "v", mods = "CMD", action = wa.PasteFrom "Clipboard" },

  -- Panes
  { key = "Enter", mods = "CMD | SHIFT", action = wa.TogglePaneZoomState },
  { key = "d", mods = "CMD | SHIFT", action = wa.SplitPane { direction = "Down" } },
  { key = "n", mods = "CMD | SHIFT", action = wa.SplitPane { direction = "Left", size = { Percent = 33 } } },
  { key = "LeftArrow", mods = "CMD | ALT", action = wa.ActivatePaneDirection "Left" },
  { key = "LeftArrow", mods = "CMD | SHIFT", action = wa.ActivatePaneDirection "Left" },
  { key = "RightArrow", mods = "CMD | ALT", action = wa.ActivatePaneDirection "Right" },
  { key = "RightArrow", mods = "CMD | SHIFT", action = wa.ActivatePaneDirection "Right" },
  { key = "UpArrow", mods = "CMD | ALT", action = wa.ActivatePaneDirection "Up" },
  { key = "UpArrow", mods = "CMD | SHIFT", action = wa.ActivatePaneDirection "Up" },
  { key = "DownArrow", mods = "CMD | ALT", action = wa.ActivatePaneDirection "Down" },
  { key = "DownArrow", mods = "CMD | SHIFT", action = wa.ActivatePaneDirection "Down" },

  -- Tabs
  { key = "t", mods = "CMD | SHIFT", action = wa.SpawnTab "CurrentPaneDomain" },
  { key = "[", mods = "CMD | ALT", action = wa.ActivateTabRelative(-1) },
  { key = "[", mods = "CMD | SHIFT", action = wa.ActivateTabRelative(-1) },
  { key = "]", mods = "CMD | ALT", action = wa.ActivateTabRelative(1) },
  { key = "]", mods = "CMD | SHIFT", action = wa.ActivateTabRelative(1) },

  -- Emacs
  -- Send "M-x" to the terminal when pressing OPT-x
  { key = 'x', mods = 'OPT', action = wa.SendKey { key = 'x', mods = 'META' } },
}

-- Mouse
config.mouse_bindings = {
  -- Change the default click behavior to copy to and paste
  -- from the Clipboard rather than PrimarySelection
  { event = { Up = { streak = 1, button = "Left" } }, mods = "NONE", action = wa.CompleteSelectionOrOpenLinkAtMouseCursor "Clipboard" },
  { event = { Up = { streak = 1, button = "Left" } }, mods = "CMD", action = wa.CompleteSelectionOrOpenLinkAtMouseCursor "Clipboard" },
  { event = { Up = { streak = 1, button = "Right" } }, mods = "NONE", action = wa.PasteFrom "Clipboard" },
}

return config
