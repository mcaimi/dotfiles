#!/usr/bin/env python
# define global keybindings
# trying to emulate my previous i3 desktop

from libqtile.lazy import lazy
from libqtile import extension
from libqtile.config import Key, KeyChord
from components.config import qtile_config_path, mod, terminal, workspaces
from components.functions import gen_workspaces, multimon_group_manage

# define groups
group_def: list = list(map(gen_workspaces, workspaces))

# keybindings
key_def: list = [
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
             Key([], "l", lazy.spawn("dm-tool lock"), desc="Lock the Desktop"),
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
for i in group_def:
    key_def.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.function(multimon_group_manage(i.name)),
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
