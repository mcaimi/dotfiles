-- Widget Constants
-- Requires Conky 1.7+
-- Dictionaries of constants used by my conky scripts

-- constants
RAD_CONVERSION_FACTOR = math.pi/180.0
DISPLACEMENT = 120.0
CPU_DISPLACEMENT = 120.0

-- widget parameters
cpu_frequency_ring = {
  bgthickness = 14,
  fgthickness = 12,
  centerx = 40,
  centery = 170,
  radius = 100,
  angle0 = 0,
  anglef = 120,
  bgcolor = 0x38403a,
  bgalpha = 0.8,
  fgcolor1 = 0xee0010,
  fgcolor2 = 0x10e80f,
  fgcolor3 = 0x1000ee,
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
  anglef = 120,
  bgcolor = 0x38403a,
  bgalpha = 0.8,
  fgcolor = 0xee0010,
  fgalpha = 1.0
}

font_properties = {
  font = "Iosevka Term Medium",
  weight = CAIRO_FONT_WEIGHT_NORMAL,
  slant = CAIRO_FONT_SLANT_NORMAL,
  size = 11, --default
  color = 0xffffff,
  alpha = 1.0
}

bg_rectangle = {
  line_width = 2,
  rgbcolor = 0x38403a,
  x_origin = 130,
  y_origin = 103,
  width = 180,
  height = 15,
  alpha = 1.0
}
