-- TODO
-- get touchpad state same as mixer state (do not use flag)
-- something with battery
-- xrandr by Fn+F8 - switch screens layout
-- common path for icons (do not use full path per icon) - see awful.geticonpath
-- volume indicator color must be RED when muted, then - remove note symbol

-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
require("awful.remote")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Widgets library
require("vicious")

-- {{{ Variable definitions
home = os.getenv("HOME")

-- Themes define colours, icons, and wallpapers
beautiful.init( home .. "/.config/awesome/themes/bugfix/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

local custom = {
    touchpad = {
	on = false,
	icon = "/usr/share/icons/gnome/32x32/devices/input-touchpad.png",
	enable = "synclient TouchpadOff=0",
	disable = "synclient TouchpadOff=1",
    },
    screen_lock = {
	enable = "xlock -mode blank",
    },
    battery_indicator = {
	on = false,
	enable = "osdbattery",
	disable = "pkill -U " .. os.getenv("USER") .. " osdbattery",
    },
    mixer = {
	inc = "amixer -q set Master 2%+",
	dec = "amixer -q set Master 2%-",
	toggle = "amixer -q sset Master toggle",
	get = "amixer sget Master",
	icon = {
	    muted = "/usr/share/icons/oxygen/32x32/status/audio-volume-muted.png",
	    unmuted = "/usr/share/icons/oxygen/32x32/status/audio-volume-medium.png",
	}
    }
}

naughty.config.default_preset.timeout          = 4
naughty.config.default_preset.screen           = 1
naughty.config.default_preset.position         = "top_right"
naughty.config.default_preset.margin           = 4
naughty.config.default_preset.height           = 36
naughty.config.default_preset.width            = 200
naughty.config.default_preset.gap              = 1
naughty.config.default_preset.ontop            = true
naughty.config.default_preset.font             = beautiful.font or "Verdana 8"
naughty.config.default_preset.icon             = nil
naughty.config.default_preset.icon_size        = 32
naughty.config.default_preset.fg               = '#ffffff'
naughty.config.default_preset.bg               = '#535d6c'
naughty.config.presets.normal.border_color     = '#535d6c'
naughty.config.default_preset.border_width     = 1
naughty.config.default_preset.hover_timeout    = nil

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
tags = {
	names  = { "console", "im", "browser", "mail", "music", "misc" },
	layout = { layouts[4], layouts[4], layouts[1], layouts[4], layouts[12], layouts[12] },
}

for s = 1, screen.count() do
	tags[s] = awful.tag(tags.names, s, tags.layout)
end

-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.icon_awesome },
				    { "Firefox", "firefox" },
				    { "Seamonkey", "seamonkey" },
				    { "Audacious", "audacious" },
				    { "LinPhone", "linphone" },
                                    { "Terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.icon_awesome),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox

separator = widget({type = "imagebox"})
separator.image = image(beautiful.icon_separator)

spaceseparator = widget({type = "textbox"})
spaceseparator.text = " "

clock_icon = widget({type = "imagebox"})
clock_icon.image = image(beautiful.icon_time)

bat_icon = widget({type = "imagebox"})
bat_icon.image = image(beautiful.icon_battery)

bat_text = widget({type = "textbox"})
vicious.register(bat_text, vicious.widgets.bat, "$2% $3", 60, "BAT0");

im_icon = widget({type = "imagebox"})
im_icon.image = image(beautiful.icon_chat)

im_text = widget({type = "textbox"})
im_text.text = "0"

volume = widget({type = "textbox"})
vicious.register(volume, vicious.widgets.volume,
    function(widget, args)
	local label = { ["♫"] = "♫", ["♩"] = "M" }
	return args[1] .. "% " .. label[args[2]]
    end, 10, "Master")

volume_icon = widget({type = "imagebox"})
volume_icon.image = image(beautiful.icon_volume)

gmail_icon = widget({ type = "imagebox" })
gmail_icon.image = image(beautiful.icon_mail)

mygmail = widget({ type = "textbox" })
gmail_t = awful.tooltip({ objects = { mygmail },})
vicious.register(mygmail, vicious.widgets.gmail,
		function (widget, args)
		    gmail_t:set_text(args["{subject}"])
		    gmail_t:add_to_object(gmail_icon)
		    return args["{count}"]
		end, 1800)

kbd_icon = widget({type = "imagebox"})
kbd_icon.image = image(beautiful.icon_flag_us)

dbus.request_name("session", "ru.gentoo.kbdd")
dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'")
dbus.add_signal("ru.gentoo.kbdd", function(...)
    local data = {...}
    local layout = data[2]
    if layout == 1
	then
	    kbd_icon.image = image(beautiful.icon_flag_ru)
	else
	    kbd_icon.image = image(beautiful.icon_flag_us)
	end
    end
)

-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
top_panel = {}
bot_panel = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wiboxes
    -- top:
    top_panel[s] = awful.wibox({ position = "top", screen = s, height = 18 })
    -- bottom:
    bot_panel[s] = awful.wibox({ position = "bottom", screen = s, height = 18 })

    -- Add widgets to the wibox - order matters
    top_panel[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
	separator,
	kbd_icon,
	separator,
        mytextclock,
	clock_icon,
	separator,
	spaceseparator,
	bat_text,
	bat_icon,
	separator,
	im_text,
	im_icon,
	separator,
	volume,
	volume_icon,
	separator,
	mygmail,
	gmail_icon,
	separator,
        s == 1 and mysystray or nil,
        layout = awful.widget.layout.horizontal.rightleft
    }

    bot_panel[s].widgets = {
	mytasklist[s],
	layout = awful.widget.layout.horizontal.leftright
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- lenovo x220 multimedia keys
    awful.key({                   }, "XF86ScreenSaver", function () awful.util.spawn ( custom.screen_lock.enable ) end),
    awful.key({                   }, "XF86AudioMute",
	function ()
	    awful.util.spawn ( custom.mixer.toggle )
	    vicious.force({volume})
	    local fd = io.popen(custom.mixer.get)
	    local status = fd:read("*all")
	    fd:close()
	    status = string.match(status, "%[(o[^%]]*)%]")
	    if string.find(status, "on", 1, true)
	    then
		naughty.notify ({title = "System", text = "Sound is ON", icon = custom.mixer.icon.unmuted})
	    else
		naughty.notify ({title = "System", text = "Sound is OFF", icon = custom.mixer.icon.muted})
	    end
	end),
    awful.key({                   }, "XF86AudioLowerVolume",
	function ()
	    awful.util.spawn ( custom.mixer.dec )
	    vicious.force({volume})
	end),
    awful.key({                   }, "XF86AudioRaiseVolume",
	function ()
	    awful.util.spawn ( custom.mixer.inc )
	    vicious.force({volume})
	end),
    awful.key({                   }, "XF86TouchpadToggle",
	function ()
	    custom.touchpad.on = not custom.touchpad.on
	    if custom.touchpad.on then
		awful.util.spawn ( custom.touchpad.enable )
		naughty.notify ({title = "System", text = "Touchpad is ON", icon = custom.touchpad.icon})
	    else
		awful.util.spawn ( custom.touchpad.disable )
		naughty.notify ({title = "System", text = "Touchpad is OFF", icon = custom.touchpad.icon})
	    end
	end),
    awful.key({                   }, "XF86Battery",
	function ()
	    custom.battery_indicator.on = not custom.battery_indicator.on
	    if custom.battery_indicator.on then
		awful.util.spawn ( custom.battery_indicator.enable )
	    else
		awful.util.spawn ( custom.battery_indicator.disable )
	    end
	end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
		     size_hints_honor = false } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    { rule = { class = "Audacious" },
      properties = { tag = tags[1][5] } },
    { rule = { class = "Firefox" },
      properties = { tag = tags[1][3] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Autostart
awful.util.spawn("run_once /usr/bin/synclient TouchpadOff=1")
awful.util.spawn("run_once /usr/libexec/polkit-gnome-authentication-agent-1")
awful.util.spawn("run_once /usr/bin/nm-applet")
awful.util.spawn("run_once /usr/bin/kbdd")
awful.util.spawn("run_once /usr/bin/urxvtd -q -f")
-- }}}
