# Custom QTile configuration file
# https://docs.qtile.org/en/latest/manual/
#

from typing import Callable
from libqtile import layout

# qtile config imports
import components.hooks
from components.keybindings import group_def, key_def
from components.layouts import layout_def, floating_layout_def
from components.screens import screens_def
from components.mouse import mouse_keydef

# qtile sections
groups: list = group_def
keys: list = key_def
layouts: list = layout_def
floating_layout: layout.Floating = floating_layout_def
screens: list = screens_def
mouse: list = mouse_keydef

# WM SETTINGS
follow_mouse_focus: bool = True
bring_front_click: bool = False
cursor_warp: bool = False
auto_fullscreen: bool = False
focus_on_window_activation: str = "smart"
reconfigure_screens: bool = True
auto_minimize: bool = True
wmname: str = "LG3D"

# dynamic groups, not yet configured
dgroups_key_binder: Callable = None
dgroups_app_rules: list = []
