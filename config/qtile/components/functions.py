#!/usr/bin/env python
# CUSTOM FUNCTIONS
#

from subprocess import run
from typing import Callable
from libqtile.core.manager import Qtile
from libqtile import widget
from libqtile.config import Group, Match
from components.config import qtile_config_path


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


def multimon_group_manage(name: str) -> Callable:
    def _inner(qtile: Qtile) -> None:
        if len(qtile.screens) == 1:
            qtile.groups_map[name].cmd_toscreen()
            return

        # handle groups on multiple (2) monitors
        if name in '13490':
            qtile.focus_screen(0)
            qtile.groups_map[name].cmd_toscreen()
        else:
            qtile.focus_screen(1)
            qtile.groups_map[name].cmd_toscreen()

    return _inner


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
