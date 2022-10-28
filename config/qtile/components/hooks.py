#!/usr/bin/env python
#
# WM HOOKS
#

from subprocess import Popen
from libqtile import qtile
from libqtile.hook import subscribe
from components.functions import set_wallpaper, load_xinput_settings
from components.config import qtile_config_path, internal_groupbox


@subscribe.startup_once
def exec_qtile_environment() -> None:
    Popen([qtile_config_path + "scripts/xsession_setup.sh"])
    Popen([qtile_config_path + "scripts/setup_environment.sh"])
    Popen([qtile_config_path + "scripts/start_applets.sh"])
    load_xinput_settings()


@subscribe.screens_reconfigured
async def _() -> None:
    if len(qtile.screens) > 1:
        internal_groupbox.visible_groups = ['1', '3', '4', '9', '0']
    else:
        internal_groupbox.visible_groups = ['%s' % x for x in range(1, 10)]
    if hasattr(internal_groupbox, 'bar'):
        internal_groupbox.bar.draw()


@subscribe.startup
def exec_startup_configuration() -> None:
    set_wallpaper(qtile_config_path + "wallpapers/wallpaper")
