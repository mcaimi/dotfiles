#!/usr/bin/env python
# X11 Screens

from libqtile import bar, widget
from libqtile.config import Screen
from components.config import color_theme, foreground_color, background_color, internal_groupbox, external_groupbox
from components.functions import pad, glyph

# XRANDR screens, in order
screens_def: list = [
    Screen(
        top=bar.Bar(
            [
                glyph(unicode_glyph="\uf303", foreground=foreground_color, background=background_color),
                pad(len=2, color=background_color),
                internal_groupbox,
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
    Screen(
        top=bar.Bar(
            [
                glyph(unicode_glyph="\uf4a9", foreground=foreground_color, background=background_color),
                external_groupbox,
            ],
            24,
            margin=1,
            border_width=[1, 1, 1, 1],
            background=background_color,
            foreground=foreground_color,
        ),
    ),
]
