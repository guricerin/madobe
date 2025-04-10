-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- カスタムモジュール
local keybinds = require 'keybinds'
local mousebinds = require 'mousebinds'
require 'status'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.default_prog = { 'pwsh.exe', '-NoLogo' }
  config.launch_menu = {
    {
      label = 'PowerShell',
      args = { 'pwsh.exe', '-NoLogo' },
    },
  }
-- unix系の場合は設定されているログインシェルを起動
end

-- Ctrl + c でのコピーや Ctrl + v でのペーストを有効にする
config.swallow_mouse_click_on_window_focus = true

config.mouse_bindings = mousebinds

-- カーソルを点滅させる
config.default_cursor_style = 'BlinkingBlock'

-- keys
config.leader = { key = 's', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = keybinds.keys
config.key_tables = keybinds.key_tables

-- colors
config.color_scheme = 'Catppuccin Mocha'
config.window_background_opacity = 0.85

-- font
config.font = wezterm.font('HackGenNerd', { weight = 'Regular', stretch = 'Normal', style = 'Normal' })
config.font_size = 13.0

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  local index = ''
  if #tabs > 1 then
    index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs)
  end

  return index .. 'wezterm'
end)

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local index = tab.tab_index + 1
  local pane = tab.active_pane
  local cwd = basename(pane.current_working_dir.file_path)
  local process_name = basename(pane.foreground_process_name)

  -- e.g. 1: project_dir | zsh
  local title = index .. ': '  .. cwd .. ' | ' .. process_name
  return {
    { Text = ' ' .. title .. ' ' },
  }
end)

-- and finally, return the configuration to wezterm
return config
