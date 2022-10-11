# Custom QTile configuration file
# https://docs.qtile.org/en/latest/manual/
#

from os import path
from subprocess import Popen, run
from typing import Callable
from libqtile import bar, layout, widget, extension
from libqtile.config import Click, Drag, Group, Key, Match, Screen, KeyChord
from libqtile.lazy import lazy
from libqtile.hook import subscribe

qtile_config_path: str = path.expanduser("~") + "/.config/qtile/"
mod: str = "mod4"
alt: str = "mod1"
terminal: str = "st -e tmux"

color_theme: dict = dict(
    background="#1e2127",
    foreground="#abb2bf",
    black="#5c6370",
    red="#e06c75",
    green="#98c379",
    yellow="#d19a66",
    blue="#61afef",
    magenta="#c678dd",
    cyan="#56b6c2",
    white="#828791"
)
highlight_color: str = color_theme.get("cyan")
unfocus_color: str = color_theme.get("black")
urgent_color: str = color_theme.get("red")
foreground_color: str = color_theme.get("foreground")
background_color: str = color_theme.get("background")

widget_defaults: dict = dict(
    font="Iosevka Term Medium",
    fontsize=14,
    padding=3,
)
extension_defaults: dict = widget_defaults.copy()

layout_params: dict = dict(
    border_width=1,
    margin=2,
    border_focus=highlight_color,
    border_normal=unfocus_color,
    background=background_color,
    foreground=foreground_color,
)

workspaces: list = [
    ["1", "\uf120", [{"class": ["st"]}]],
    ["2", "\uf269", [{"class": ["firefox", "chromium"]}]],
    ["3", "\ue61e", [{"class": ["vscodium", "iaito", "imhex"]}]],
    ["4", "\uf886", [{"class": ["Spotify"]}]],
    ["5", "\uf16e", [{"class": ["gimp", "darktable", "rawtherapee"]}]],
    ["6", "\uf15c", [{"class": ["zathura", "obsidian"]}]],
    ["7", "\uf17a", [{"class": ["dosbox", "retroarch", "virt-viewer", "virt-manager", "xfreerdp"]}]],
    ["8", "\uf27a", [{"class": ["signal", "telegramdesktop"]}]],
    ["9", "\uf07b", [{"class": ["nemo"]}]],
    ["0", "\uf22d", [{"class": ["Proton Mail Bridge"]}]]
]


# CUSTOM FUNCTIONS
def gen_workspaces(data: list) -> Group:
    name, label, rules = data
    matches = [Match(wm_class=x.get("class")) for x in rules]
    return Group(name=name, label=label, matches=matches)


def load_xinput_settings() -> None:
    with open(qtile_config_path + "xinputrc") as xinput_config:
        for comm in xinput_config.readlines():
            run("xinput %s" % comm, shell=True)


def set_wallpaper(wallpaper_path: str) -> None:
    run("feh --bg-center %s" % wallpaper_path, shell=True)


glyph: widget.TextBox = lambda unicode_glyph, foreground, background: widget.TextBox(
    text=unicode_glyph,
    foreground=foreground,
    background=background,
    font="Iosevka",
    fontsize=14
)

pad: widget.Sep = lambda len, color: widget.Sep(
    linewidth=len,
    foreground=color,
    background=color,
)

# WM SETTINGS
follow_mouse_focus: bool = True
bring_front_click: bool = False
cursor_warp: bool = False
auto_fullscreen: bool = False
focus_on_window_activation: str = "smart"
reconfigure_screens: bool = True
auto_minimize: bool = True
wmname: str = "LG3D"

# define groups
groups: list = list(map(gen_workspaces, workspaces))

# define global keybindings
# trying to emulate my previous i3 desktop
keys: list = [
    # BASE LAYER
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "d", lazy.run_extension(extension.DmenuRun(
        dmenu_prompt="DMENU >",
        dmenu_command="dmenu_run -bw 2",
        dmenu_height=24,
        font="Iosevka Term Medium",
        fontsize=11
    )), desc="Launch Dmenu"),
    # Toggle between split and unsplit sides of stack.
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),

    # SHIFT LAYER
    KeyChord([mod], "s",
             [Key([], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
             Key([], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
             Key([], "j", lazy.layout.shuffle_down(), desc="Move window down"),
             Key([], "k", lazy.layout.shuffle_up(), desc="Move window up")],
             mode=True,
             name="Shift Layer"),

    # CONTROL LAYER
    KeyChord([mod], "c",
             [Key([], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
             Key([], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
             Key([], "j", lazy.layout.grow_down(), desc="Grow window down"),
             Key([], "k", lazy.layout.grow_up(), desc="Grow window up"),
             Key([], "r", lazy.reload_config(), desc="Reload QTile Config"),
             Key([], "n", lazy.layout.normalize(), desc="Reset all window sizes")],
             mode=True,
             name="Control Layer"),

    # TOOLS LAYER
    KeyChord([mod], "t",
             [Key([], "t", lazy.spawn(qtile_config_path + "scripts/totp.sh"), desc="Launch OTP"),
              Key([], "s", lazy.spawn(qtile_config_path + "scripts/screenshot.sh"), desc="Launch Screen Grab"),
              Key([], "m", lazy.spawn(qtile_config_path + "scripts/multimon-rofi.sh"), desc="Launch Multimon Tool")],
             mode=True,
             name="Tools Layer"),

    # POWER LAYER
    KeyChord([mod], "e",
             [Key([], "r", lazy.spawn("systemctl reboot"), desc="Reboot System"),
             Key([], "s", lazy.spawn("systemctl poweroff"), desc="Power System Off"),
             Key([], "e", lazy.shutdown(), desc="Shutdown QTile")],
             mode=True,
             name="Power Layer"),

    # Audio
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pulsemixer --change-volume +5"), desc="Increase Audio Volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pulsemixer --change-volume -5"), desc="Decrease Audio Volume"),

    # Brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn("xbacklight +10"), desc="Increase LCD Brightness"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("xbacklight -10"), desc="Decrease LCD Brightness"),

]


# GROUPS CALLBACKS
for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )


# ENABLED LAYOUTS
layouts: list = [
    layout.Columns(**layout_params),
    layout.Max(**layout_params),
    layout.Bsp(**layout_params),
    layout.MonadWide(**layout_params),
    layout.Tile(**layout_params),
    # layout.Stack(num_stacks=2),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.RatioTile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]


# FLOATING RULES
floating_layout: layout.Floating = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class=["dosbox", "retroarch", "steam"]),  # emulators
        Match(wm_class=["lxappearance", "lightdm-gtk-greeter-setup"]),  # desktop management tools
        Match(wm_class=["vlc", "mpv", "quickmedia", "Spotify"]),  # media
        Match(wm_class=["keepassxc", "pavucontrol", "transmission-gtk"])  # tools
    ]
)

# X11 Screens
screens: list = [
    Screen(
        top=bar.Bar(
            [
                glyph(unicode_glyph="\uf303", foreground=foreground_color, background=background_color),
                pad(len=2, color=background_color),
                widget.GroupBox(highlight_method='block',
                                hide_unused=False,
                                borderwidth=0,
                                rounded=True,
                                this_current_screen_border=highlight_color,
                                urgent_border=urgent_color,
                                inactive=unfocus_color,
                                ),
                pad(len=2, color=background_color),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": (background_color, foreground_color),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                glyph(unicode_glyph="\uf248", foreground=color_theme.get("blue"), background=background_color),
                widget.CurrentLayout(foreground=color_theme.get("blue")),
                pad(len=2, color=background_color),
                glyph(unicode_glyph="\uf578", foreground=color_theme.get("magenta"), background=background_color),
                widget.Battery(foreground=color_theme.get("magenta"),
                               background=background_color,
                               charge_char="\uf55c",
                               discharge_char="\uf544"),
                pad(len=2, color=background_color),
                glyph(unicode_glyph="\uf028", foreground=color_theme.get("yellow"), background=background_color),
                widget.PulseVolume(
                    foreground=color_theme.get("yellow"),
                    limit_max_volume=True,
                    get_volume_command="pulsemixer --get-volume",
                    mute_command="pulsemixer --toggle-mute",
                    volume_up_command="pulsemixer --change-volume +5",
                    volume_down_command="pulsemixer --change-volume -5"),
                pad(len=2, color=background_color),
                glyph(unicode_glyph="\uf5de", foreground=color_theme.get("green"), background=background_color),
                widget.Backlight(backlight_name="intel_backlight", foreground=color_theme.get("green")),
                pad(len=2, color=background_color),
                widget.Clock(format="%a %I:%M %p"),
                pad(len=2, color=background_color),
                widget.WidgetBox(widgets=[widget.Systray(), widget.QuickExit()], close_button_location="left",
                                 text_open="\uf0da",
                                 text_closed="\uf46a"),
            ],
            24,
            opacity=0.85,
            margin=1,
            border_width=[1, 1, 1, 1],  # bar borders
            background=background_color,
            foreground=foreground_color
        ),
    ),
]

# Drag floating layouts.
mouse: list = [
    Drag([alt], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([alt], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([alt], "Button2", lazy.window.bring_to_front()),
]

# dynamic groups, not yet configured
dgroups_key_binder: Callable = None
dgroups_app_rules: list = []


# HOOKS
@subscribe.startup_once
def exec_qtile_environment() -> None:
    Popen([qtile_config_path + "scripts/xsession_setup.sh"])
    Popen([qtile_config_path + "scripts/setup_environment.sh"])
    Popen([qtile_config_path + "scripts/start_applets.sh"])
    load_xinput_settings()


@subscribe.startup
def exec_startup_configuration() -> None:
    set_wallpaper(qtile_config_path + "wallpapers/wallpaper")
