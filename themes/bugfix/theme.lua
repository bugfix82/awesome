-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
--    Customized by BuGfiX   --
-------------------------------

-- Alternative icon sets and widget icons:
--  * http://awesome.naquadah.org/wiki/Nice_Icons

theme_home = os.getenv("HOME") .. "/.config/awesome/themes/bugfix/"

-- {{{ Main
theme = {}
theme.wallpaper_cmd = { "awsetbg " .. theme_home .. "background.jpg" }
-- }}}

-- {{{ Styles
theme.font      = "sans 8"

-- {{{ Colors
theme.fg_normal = "#DCDCCC"	-- inactive tag and menu items font color
theme.fg_focus  = "#00FF00"	-- active tag and menu items font color
theme.fg_urgent = "#CC9393"	-- ??
theme.bg_normal = "#000000"	-- inactive tag and menu items background
theme.bg_focus  = "#1F1F1F"	-- active tag and menu items background
theme.bg_urgent = "#3F3F3F"	-- ??
-- }}}

-- {{{ Borders
theme.border_width  = "1"
theme.border_normal = "#3F3F3F"
theme.border_focus  = "#0000AA"
theme.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = "15"
theme.menu_width  = "100"
-- }}}

-- {{{ Icons

theme.icon_awesome	= theme_home .. "icons/awesome.png"
theme.icon_battery	= theme_home .. "icons/bat.png"
theme.icon_calendar	= theme_home .. "icons/cal.png"
theme.icon_chat		= theme_home .. "icons/chat.png"
theme.icon_cpu		= theme_home .. "icons/cpu.png"
theme.icon_crypto	= theme_home .. "icons/crypto.png"
theme.icon_disk		= theme_home .. "icons/disk.png"
theme.icon_down		= theme_home .. "icons/down.png"
theme.icon_info		= theme_home .. "icons/info.png"
theme.icon_mail		= theme_home .. "icons/mail.png"
theme.icon_memory	= theme_home .. "icons/mem.png"
theme.icon_music	= theme_home .. "icons/music.png"
theme.icon_pacman	= theme_home .. "icons/pacman.png"
theme.icon_phones	= theme_home .. "icons/phones.png"
theme.icon_power	= theme_home .. "icons/power.png"
theme.icon_rss		= theme_home .. "icons/rss.png"
theme.icon_sat		= theme_home .. "icons/sat.png"
theme.icon_separator	= theme_home .. "icons/separator.png"
theme.icon_sun		= theme_home .. "icons/sun.png"
theme.icon_temp		= theme_home .. "icons/temp.png"
theme.icon_time		= theme_home .. "icons/time.png"
theme.icon_up		= theme_home .. "icons/up.png"
theme.icon_volume	= theme_home .. "icons/vol.png"
theme.icon_wifi		= theme_home .. "icons/wifi.png"
theme.icon_flag_us	= theme_home .. "icons/us1.png"
theme.icon_flag_ru	= theme_home .. "icons/ru1.png"

-- {{{ Taglist
theme.taglist_squares_sel   = theme_home .. "icons/taglist/squarefz.png"
theme.taglist_squares_unsel = theme_home .. "icons/taglist/squarez.png"
theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.menu_submenu_icon      = "/usr/share/awesome/themes/default/submenu.png"
theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = theme_home .. "icons/layouts/tile.png"
theme.layout_tileleft   = theme_home .. "icons/layouts/tileleft.png"
theme.layout_tilebottom = theme_home .. "icons/layouts/tilebottom.png"
theme.layout_tiletop    = theme_home .. "icons/layouts/tiletop.png"
theme.layout_fairv      = theme_home .. "icons/layouts/fairv.png"
theme.layout_fairh      = theme_home .. "icons/layouts/fairh.png"
theme.layout_spiral     = theme_home .. "icons/layouts/spiral.png"
theme.layout_dwindle    = theme_home .. "icons/layouts/dwindle.png"
theme.layout_max        = theme_home .. "icons/layouts/max.png"
theme.layout_fullscreen = theme_home .. "icons/layouts/fullscreen.png"
theme.layout_magnifier  = theme_home .. "icons/layouts/magnifier.png"
theme.layout_floating   = theme_home .. "icons/layouts/floating.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = theme_home .. "icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme_home .. "icons/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = theme_home .. "icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = theme_home .. "icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = theme_home .. "icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme_home .. "icons/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = theme_home .. "icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = theme_home .. "icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = theme_home .. "icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme_home .. "icons/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = theme_home .. "icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = theme_home .. "icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = theme_home .. "icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme_home .. "icons/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = theme_home .. "icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = theme_home .. "icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme_home .. "icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme_home .. "icons/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme
