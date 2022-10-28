#!/usr/bin/env python
# ENABLED LAYOUTS

from libqtile import layout
from libqtile.config import Match
from components.config import layout_params

layout_def: list = [
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
floating_layout_def: layout.Floating = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class=["dosbox", "retroarch", "steam"]),  # emulators
        Match(wm_class=["lxappearance", "lightdm-gtk-greeter-setup"]),  # desktop management tools
        Match(wm_class=["vlc", "mpv", "quickmedia", "Spotify"]),  # media
        Match(wm_class=["keepassxc", "pavucontrol", "transmission-gtk"])  # tools
    ]
)
