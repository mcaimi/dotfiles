-- Widget Constants
-- Requires Conky 1.7+
-- Dictionaries of constants used by my conky scripts

-- add local load path
userHome = os.getenv('HOME')
package.path = package.path .. ";" .. userHome .. "/.config/lualibs/?.lua"

-- load xrdb module
xres = require 'xrdb'

-- constants
RAD_CONVERSION_FACTOR = math.pi/180.0
DISPLACEMENT = 90.0
CPU_DISPLACEMENT = 45.0
ANGULAR_COEFF_45_DEG = math.tan(45.0)
LOAD_DISPLACEMENT = (DISPLACEMENT - DISPLACEMENT/3)
ANGULAR_COEFF_LOAD_DISPLACEMENT = math.tan(LOAD_DISPLACEMENT)

-- xrdb colors
xrdb_colors = {
  -- Black + DarkGrey
  black = xres.parse_string_resource("color0"),
  darkgrey = xres.parse_string_resource("color8"),
  -- DarkRed + Red
  darkred = xres.parse_string_resource("color1"),
  red = xres.parse_string_resource("color9"),
  -- DarkGreen + Green
  darkgreen = xres.parse_string_resource("color2"),
  green = xres.parse_string_resource("color10"),
  -- DarkYellow + Yellow
  darkyellow = xres.parse_string_resource("color3"),
  yellow = xres.parse_string_resource("color11"),
  -- DarkBlue + Blue
  darkblue = xres.parse_string_resource("color4"),
  blue = xres.parse_string_resource("color12"),
  -- DarkMagenta + Magenta
  darkmagenta = xres.parse_string_resource("color5"),
  magenta = xres.parse_string_resource("color13"),
  -- DarkCyan + Cyan (both not tango)
  darkcyan = xres.parse_string_resource("color6"),
  cyan = xres.parse_string_resource("color14"),
  -- LightGrey + White
  lightgrey = xres.parse_string_resource("color7"),
  white = xres.parse_string_resource("color15"),
  -- background + foreground
  background = xres.parse_string_resource("background"),
  foreground = xres.parse_string_resource("foreground"),
  cursorcolor = xres.parse_string_resource("cursorColor"),
}

system_parms = {
  max_cpu_mhz = 2200,
  hi_temp_c = 90,
  lo_temp_c = 30,
}

-- widget parameters
cpu_frequency_ring = {
  bgthickness = 14,
  fgthickness = 12,
  centerx = 40,
  centery = 170,
  radius = 100,
  angle0 = 0,
  anglef = 270,
  bgcolor = xrdb_colors.background,
  bgalpha = 0.8,
  fgcolor1 = xrdb_colors.red,
  fgcolor2 = xrdb_colors.green,
  fgcolor3 = xrdb_colors.blue,
  fgalpha = 1.0
}

cpu_load_ring = {
  bgthickness = 12,
  fgthickness = 10,
  centerx = 40,
  centery = 170,
  radius = 85,
  inner_radius = 70,
  angle0 = 0,
  anglef = 180,
  bgcolor = xrdb_colors.background,
  bgalpha = 0.8,
  fgcolor = xrdb_colors.cyan,
  fgalpha = 1.0
}

font_properties = {
  font = "Iosevka Term Medium",
  weight = CAIRO_FONT_WEIGHT_NORMAL,
  slant = CAIRO_FONT_SLANT_NORMAL,
  size = 11, --default
  color = xrdb_colors.white,
  alpha = 1.0
}

bg_rectangle = {
  line_width = 2,
  rgbcolor = xrdb_colors.background,
  x_origin = 130,
  y_origin = 103,
  width = 180,
  height = 15,
  alpha = 1.0
}


