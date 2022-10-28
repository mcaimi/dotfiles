#!/usr/bin/env python
# Configuration data
#

from os import path
from libqtile import widget

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

common_gb_options: dict = dict(highlight_method='block',
                               hide_unused=False,
                               borderwidth=0,
                               rounded=True,
                               this_current_screen_border=highlight_color,
                               urgent_border=urgent_color,
                               inactive=unfocus_color)

internal_groupbox: widget.GroupBox = widget.GroupBox(**common_gb_options)
external_groupbox: widget.GroupBox = widget.GroupBox(visible_groups=['2', '5', '6', '7', '8'], **common_gb_options)
