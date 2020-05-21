local filesystem = require('gears.filesystem')
local gruvbox = require('theme.Gruvbox-theme.palette')
local mat_colors = require('theme.mat-colors')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local dpi = require('beautiful').xresources.apply_dpi

local theme = {}
theme.icons = theme_dir .. '/icons/'
theme.font = 'Roboto medium 10'

-- Colors Pallets

-- Primary
theme.primary = mat_colors.indigo
-- Accent
theme.accent = mat_colors.pink
-- Background
theme.background = mat_colors.blue_grey

local awesome_overrides = function(theme)

  theme.bg_normal = gruvbox.dark0
  theme.fg_normal = gruvbox.light0
  theme.accent_color = gruvbox.bright_red

  theme.border_focus = gruvbox.neutral_yellow

  theme.panel_bg = theme.bg_normal
  theme.panel_fg = theme.fg_normal
  theme.panel_bg_selected = gruvbox.dark3

  theme.taglist_bg_empty = theme.panel_bg
  theme.taglist_bg_occupied = gruvbox.dark1

  theme.taglist_bg_focus =
    'linear:0,0:' ..  dpi(48) ..
      ',0:0,' .. theme.accent_color .. 
      ':0.08,' .. theme.accent_color .. 
      ':0.08,' .. theme.panel_bg

  theme.tasklist_bg_normal = theme.bg_normal

  theme.tasklist_bg_focus =
    'linear:0,0:0,' ..
    dpi(48) ..
      ':0,' .. theme.panel_bg ..
      ':0.92,' .. theme.panel_bg ..
      ':0.92,' .. theme.accent_color
     
      
end

return {
  theme = theme,
  awesome_overrides = awesome_overrides
}
