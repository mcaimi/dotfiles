# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

# Aliases for commands. The keys of the given dictionary are the
# aliases, while the values are the commands they map to.
# Type: Dict
c.aliases = {'q': 'quit', 'w': 'session-save', 'wq': 'quit --save'}

# Load a restored tab as soon as it takes focus.
# Type: Bool
c.session.lazy_restore = True

# Backend to use to display websites. qutebrowser supports two different
# web rendering engines / backends, QtWebKit and QtWebEngine. QtWebKit
# was discontinued by the Qt project with Qt 5.6, but picked up as a
# well maintained fork: https://github.com/annulen/webkit/wiki -
# qutebrowser only supports the fork. QtWebEngine is Qt's official
# successor to QtWebKit. It's slightly more resource hungry than
# QtWebKit and has a couple of missing features in qutebrowser, but is
# generally the preferred choice.
# Type: String
# Valid values:
#   - webengine: Use QtWebEngine (based on Chromium).
#   - webkit: Use QtWebKit (based on WebKit, similar to Safari).
c.backend = 'webengine'

# Additional arguments to pass to Qt, without leading `--`. With
# QtWebEngine, some Chromium arguments (see
# https://peter.sh/experiments/chromium-command-line-switches/ for a
# list) will work.
# Type: List of String
c.qt.args = ['ppapi-widevine-path=/usr/lib/qt/plugins/ppapi/libwidevinecdmadapter.so']

# Force software rendering for QtWebEngine. This is needed for
# QtWebEngine to work with Nouveau drivers.
# Type: Bool
c.qt.force_software_rendering = "none"

# Always restore open sites when qutebrowser is reopened.
# Type: Bool
c.auto_save.session = True

# Limit fullscreen to the browser window (does not expand to fill the
# screen).
# Type: Bool
c.content.windowed_fullscreen = True

# Allow websites to request geolocations.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
c.content.geolocation = False

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'file://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Allow websites to record audio/video.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
c.content.media_capture = False

# Open new windows in private browsing mode which does not record
# visited pages.
# Type: Bool
c.content.private_browsing = False

# Duration (in milliseconds) to wait before removing finished downloads.
# If set to -1, downloads are never removed.
# Type: Int
c.downloads.remove_finished = 10000

# Editor (and arguments) to use for the `open-editor` command. The
# following placeholders are defined: * `{file}`: Filename of the file
# to be edited. * `{line}`: Line in which the caret is found in the
# text. * `{column}`: Column in which the caret is found in the text. *
# `{line0}`: Same as `{line}`, but starting from index 0. * `{column0}`:
# Same as `{column}`, but starting from index 0.
# Type: ShellCommand
c.editor.command = ['st', '-e', 'nvim', '{file}']

# Show a scrollbar.
# Type: Bool
c.scrolling.bar = True

# Enable smooth scrolling for web pages. Note smooth scrolling does not
# work with the `:scroll-px` command.
# Type: Bool
c.scrolling.smooth = True

# Hide the statusbar unless a message is shown.
# Type: Bool
c.statusbar.hide = False

# Position of the tab bar.
# Type: Position
# Valid values:
#   - top
#   - bottom
#   - left
#   - right
c.tabs.position = 'left'

# Format to use for the tab title. The following placeholders are
# defined:  * `{perc}`: Percentage as a string like `[10%]`. *
# `{perc_raw}`: Raw percentage, e.g. `10`. * `{title}`: Title of the
# current web page. * `{title_sep}`: The string ` - ` if a title is set,
# empty otherwise. * `{index}`: Index of this tab. * `{id}`: Internal
# tab ID of this tab. * `{scroll_pos}`: Page scroll position. *
# `{host}`: Host of the current web page. * `{backend}`: Either
# ''webkit'' or ''webengine'' * `{private}`: Indicates when private mode
# is enabled. * `{current_url}`: URL of the current web page. *
# `{protocol}`: Protocol (http/https/...) of the current web page.
# Type: FormatString
c.tabs.title.format = '{index}: {protocol} {title} {private}'

# Format to use for the tab title for pinned tabs. The same placeholders
# like for `tabs.title.format` are defined.
# Type: FormatString
c.tabs.title.format_pinned = '{index}'

# Width (in pixels or as percentage of the window) of the tab bar if
# it's vertical.
# Type: PercOrInt
c.tabs.width = '15%'

# Default monospace fonts. Whenever "monospace" is used in a font
# setting, it's replaced with the fonts listed here.
# Type: Font
c.fonts.monospace = '"Iosevka Term Medium", "xos4 Terminus", Terminus, Monospace, "DejaVu Sans Mono", Monaco, "Bitstream Vera Sans Mono", "Andale Mono", "Courier New", Courier, "Liberation Mono", monospace, Fixed, Consolas, Terminal'

# Font used in the completion widget.
# Type: Font
c.fonts.completion.entry = '11pt monospace'

# Font used in the completion categories.
# Type: Font
c.fonts.completion.category = 'bold 10pt monospace'

# Font used in the statusbar.
# Type: Font
c.fonts.statusbar = '11pt monospace'

# Font used in the tab bar.
# Type: QtFont
c.fonts.tabs = '12pt monospace'

# Font family for standard fonts.
# Type: FontFamily
c.fonts.web.family.standard = None
