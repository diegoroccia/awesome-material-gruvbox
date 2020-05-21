local filesystem = require('gears.filesystem')
local with_dpi = require('beautiful').xresources.apply_dpi
local get_dpi = require('beautiful').xresources.get_dpi

return {
  -- List of apps to start by default on some actions
  default = {
    terminal = 'urxvtc',
    editor = 'code',
    rofi = 'rofi -dpi ' .. get_dpi() .. ' -width ' .. with_dpi(400) .. ' -show drun -theme ' .. filesystem.get_configuration_dir() .. '/configuration/rofi.rasi',
    lock = 'screenlock'
  },
  -- List of apps to start once on start-up
  run_on_start_up = {
    --'picom --config ' .. filesystem.get_configuration_dir() .. '/configuration/compton.conf',
    "urxvtd",
    "unclutter -root",
    "/usr/local/bin/picom --shadow-exclude '!focused' ", 
    "/usr/bin/xsettingsd", 
    "/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1", 
    "xautolock -time 5 -locker screenlock",
    --"/usr/bin/conky"
  }
}
