local awful = require('awful')
require('awful.autofocus')
local beautiful = require('beautiful')
local hotkeys_popup = require('awful.hotkeys_popup').widget

local modkey = require('configuration.keys.mod').modKey
local altkey = require('configuration.keys.mod').altKey
local apps = require('configuration.apps')
-- Key bindings
local globalKeys = awful.util.table.join(
  -- Hotkeys
    awful.key({modkey}, 'F1', hotkeys_popup.show_help, {description = 'show help', group = 'awesome'}),
    awful.key({ modkey }, "x", 
        function ()
            os.execute("rofi -show ")
        end,
        {description = "show rofi", group = "launcher"}),
  -- Tag browsing
    awful.key({modkey}, 'w', awful.tag.viewprev, {description = 'view previous', group = 'tag'}),
    awful.key({modkey}, 's', awful.tag.viewnext, {description = 'view next', group = 'tag'}),
    awful.key({modkey}, 'Escape', awful.tag.history.restore, {description = 'go back', group = 'tag'}),

  -- Default client focus
    awful.key({modkey}, 'e',
      function()
        _G.screen.primary.left_panel:toggle(true)
      end,
      {description = 'show main menu', group = 'awesome'}
    ),
    awful.key({modkey}, 'u', 
        awful.client.urgent.jumpto, 
        {description = 'jump to urgent client', group = 'client'}
    ),
    awful.key({modkey}, 'Tab',
      function()
        awful.client.focus.history.previous()
        if _G.client.focus then
          _G.client.focus:raise()
        end
      end,
      {description = 'go back', group = 'client'}
    ),


 -- By direction client focus
     awful.key({ modkey }, "j",
         function()
             awful.client.focus.global_bydirection("down")
             if client.focus then client.focus:raise() end
         end,
         {description = "focus down", group = "client"}),
     awful.key({ modkey }, "k",
         function()
             awful.client.focus.global_bydirection("up")
             if client.focus then client.focus:raise() end
         end,
         {description = "focus up", group = "client"}),
     awful.key({ modkey }, "h",
         function()
             awful.client.focus.global_bydirection("left")
             if client.focus then client.focus:raise() end
         end,
         {description = "focus left", group = "client"}),
     awful.key({ modkey }, "l",
         function()
             awful.client.focus.global_bydirection("right")
             if client.focus then client.focus:raise() end
         end,
         {description = "focus right", group = "client"}),


  -- Layout manipulation
  awful.key({ modkey, "Shift"   }, "j", 
      function () 
          awful.client.swap.byidx(  1)
      end,
      {description = "swap with next client by index", group = "client"}),
  awful.key({ modkey, "Shift"   }, "k", 
      function () 
          awful.client.swap.byidx( -1)
      end,
      {description = "swap with previous client by index", group = "client"}),
  awful.key({ modkey, "Control" }, "j", 
      function () 
          awful.screen.focus_relative( 1) 
      end,
      {description = "focus the next screen", group = "screen"}),

  awful.key({ modkey, "Control" }, "Return", 
      function () 
          c = _G.client.focus
          c:swap(awful.client.getmaster())
      end,
			{description = "move to master", group = "client"}),

   awful.key({ modkey,           }, "o",
       function () 
           c = _G.client.focus
           c:move_to_screen()
       end,
       {description = "move to screen", group = "client"}),
 
  awful.key({ modkey, "Control" }, "k", 
      function () 
          awful.screen.focus_relative(-1) 
      end,
      {description = "focus the previous screen", group = "screen"}),
  awful.key({ modkey,           }, "n",
      function ()
          -- The client currently has the input focus, so it cannot be
          -- minimized, since minimized clients can't have the focus.
          c.minimized = true
      end ,
      {description = "minimize", group = "client"}),

  awful.key({ modkey,           }, "m",
      function ()
          c = _G.client.focus
          c.maximized = not c.maximized
          c:raise()
      end ,
      {description = "maximize", group = "client"}),

  -- Programms
  awful.key(
    {modkey, 'Control'},
    'l',
    function()
      awful.spawn(apps.default.lock)
    end
  ),
  
  --Screenshot
  awful.key(
    {"Shift"},
    'Print',
    function()
      awful.util.spawn_with_shell('maim -s | xclip -selection clipboard -t image/png')
    end
  ),

  awful.key(
    {},
    'Print',
    function()
      awful.util.spawn_with_shell('maim | xclip -selection clipboard -t image/png')
    end
  ),

  awful.key(
    {'Control'},
    'Print',
    function()
      awful.util.spawn_with_shell('maim -B -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png')
    end
  ),

  -- Standard program
  awful.key(
    {modkey},
    'Return',
    function()
      awful.spawn(apps.default.terminal)
    end,
    {description = 'open a terminal', group = 'launcher'}
  ),
  awful.key({modkey, 'Control'}, 'r', _G.awesome.restart, {description = 'reload awesome', group = 'awesome'}),
  awful.key({modkey, 'Control'}, 'q', _G.awesome.quit, {description = 'quit awesome', group = 'awesome'}),
  awful.key(
    {altkey, 'Shift'},
    'l',
    function()
      awful.tag.incmwfact(0.05)
    end,
    {description = 'increase master width factor', group = 'layout'}
  ),
  awful.key(
    {altkey, 'Shift'},
    'h',
    function()
      awful.tag.incmwfact(-0.05)
    end,
    {description = 'decrease master width factor', group = 'layout'}
  ),
  awful.key(
    {modkey, 'Shift'},
    'h',
    function()
      awful.tag.incnmaster(1, nil, true)
    end,
    {description = 'increase the number of master clients', group = 'layout'}
  ),
  awful.key(
    {modkey, 'Shift'},
    'l',
    function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    {description = 'decrease the number of master clients', group = 'layout'}
  ),
  awful.key(
    {altkey, 'Shift'},
    'k',
    function()
      awful.tag.incncol(1, nil, true)
    end,
    {description = 'increase the number of columns', group = 'layout'}
  ),
  awful.key(
    {altkey, 'Shift'},
    'j',
    function()
      awful.tag.incncol(-1, nil, true)
    end,
    {description = 'decrease the number of columns', group = 'layout'}
  ),
  awful.key(
    {modkey},
    'space',
    function()
      awful.layout.inc(1)
    end,
    {description = 'select next', group = 'layout'}
  ),
  awful.key(
    {modkey, 'Shift'},
    'space',
    function()
      awful.layout.inc(-1)
    end,
    {description = 'select previous', group = 'layout'}
  ),
  awful.key(
    {modkey, 'Control'},
    'n',
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        _G.client.focus = c
        c:raise()
      end
    end,
    {description = 'restore minimized', group = 'client'}
  ),
  -- Dropdown application
  awful.key(
    {modkey},
    '`',
    function()
      _G.toggle_quake()
    end,
    {description = 'dropdown application', group = 'launcher'}
  ),
  -- Widgets popups
  awful.key(
    {altkey},
    'h',
    function()
      if beautiful.fs then
        beautiful.fs.show(7)
      end
    end,
    {description = 'show filesystem', group = 'widgets'}
  ),
  awful.key(
    {altkey},
    'w',
    function()
      if beautiful.weather then
        beautiful.weather.show(7)
      end
    end,
    {description = 'show weather', group = 'widgets'}
  ),
  -- Brightness
  awful.key(
    {},
    'XF86MonBrightnessUp',
    function()
      awful.spawn('brightnessctl set 100+')
    end,
    {description = '+10%', group = 'hotkeys'}
  ),
  awful.key(
    {},
    'XF86MonBrightnessDown',
    function()
      awful.spawn('brightnessctl set 100-')
    end,
    {description = '-10%', group = 'hotkeys'}
  ),
  -- ALSA volume control
  awful.key(
    {},
    'XF86AudioRaiseVolume',
    function()
      awful.spawn('amixer -D pulse sset Master 5%+')
    end,
    {description = 'volume up', group = 'hotkeys'}
  ),
  awful.key(
    {},
    'XF86AudioLowerVolume',
    function()
      awful.spawn('amixer -D pulse sset Master 5%-')
    end,
    {description = 'volume down', group = 'hotkeys'}
  ),
  awful.key(
    {},
    'XF86AudioMute',
    function()
      awful.spawn('amixer -D pulse set Master 1+ toggle')
    end,
    {description = 'toggle mute', group = 'hotkeys'}
  ),
  awful.key(
    {},
    'XF86AudioNext',
    function()
      --
    end,
    {description = 'toggle mute', group = 'hotkeys'}
  ),
  awful.key(
    {},
    'XF86PowerDown',
    function()
      --
    end,
    {description = 'toggle mute', group = 'hotkeys'}
  ),
  awful.key(
    {},
    'XF86PowerOff',
    function()
      _G.exit_screen_show()
    end,
    {description = 'toggle mute', group = 'hotkeys'}
  )

)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
  local descr_view, descr_toggle, descr_move, descr_toggle_focus
  if i == 1 or i == 9 then
    descr_view = {description = 'view tag #', group = 'tag'}
    descr_toggle = {description = 'toggle tag #', group = 'tag'}
    descr_move = {description = 'move focused client to tag #', group = 'tag'}
    descr_toggle_focus = {description = 'toggle focused client on tag #', group = 'tag'}
  end
  globalKeys =
    awful.util.table.join(
    globalKeys,
    -- View tag only.
    awful.key(
      {modkey},
      '#' .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      descr_view
    ),
    -- Toggle tag display.
    awful.key(
      {modkey, 'Control'},
      '#' .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      descr_toggle
    ),
    -- Move client to tag.
    awful.key(
      {modkey, 'Shift'},
      '#' .. i + 9,
      function()
        if _G.client.focus then
          local tag = _G.client.focus.screen.tags[i]
          if tag then
            _G.client.focus:move_to_tag(tag)
          end
        end
      end,
      descr_move
    ),
    -- Toggle tag on focused client.
    awful.key(
      {modkey, 'Control', 'Shift'},
      '#' .. i + 9,
      function()
        if _G.client.focus then
          local tag = _G.client.focus.screen.tags[i]
          if tag then
            _G.client.focus:toggle_tag(tag)
          end
        end
      end,
      descr_toggle_focus
    )
  )
end

return globalKeys
