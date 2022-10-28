#!/usr/bin/env python
#
# Qtile mouse configuration
#

from libqtile.config import Click, Drag
from libqtile.lazy import lazy
from components.config import alt

# Drag floating layouts.
mouse_keydef: list = [
    Drag([alt], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([alt], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([alt], "Button2", lazy.window.toggle_floating()),
    Click([alt, "shift"], "Button2", lazy.window.bring_to_front()),
]
