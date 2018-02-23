-- Lua helper functions
-- Requires Conky 1.7+

-- update module search path
userHome = os.getenv('HOME')
package.path = package.path .. ";" .. userHome .. "/.config/lualibs/?.lua"

-- require modules
color_ops = require 'rgb2hsl'
require 'conky_constants'

-- Colored CPU GHz output line
function conky_cpu_threshold_color(cpu_frequency, max_freq, base_color)
  -- Convert GHz frequency to MHz
  local cpu_mhz = cpu_frequency * 1000
  -- Local Variables
  local out_color = 0

  -- Color Components
  -- HSL components: Hue, Saturation and Luminosity values for the base color
  local h, s, l = color_ops.rgb2hsl((base_color >> 16) & 0xff, (base_color >> 8) & 0xff, (base_color & 0xff))

  -- frequency steps
  -- divide the hue value space in "max_freq" evenly distributed steps
  local cpu_step = h/max_freq

  -- Compute frequency dependent Hue value
  local hue = h - (cpu_mhz)*cpu_step

  -- compute RGB components for the out color...
  local red, green, blue = color_ops.hsl2rgb(hue,s,l)
  red, green, blue = color_ops.scalergb(red, green, blue)

  -- compute output color as 32bit integer
  out_color = ((red << 16) | (green << 8) | blue) & 0x00ffffff

  -- return conky color string
  return string.format("${color #%06x}", out_color)
end

--- Generate RGB value that follows the current CPU temperature value
function conky_cpu_temperature_color(temperature, hi_val, lo_val, base_color)
 -- output color value
  local out_color
  -- compute base color HSL values
  local h,s,l = rgb2hsl((base_color >> 16) & 0xff, (base_color >> 8) & 0xff, base_color & 0xff)

  -- compute rgb value based on current CPU temperature
  local function compute_rgb(temperature, threshold)
    local temp_step = h/hi_val
    local hue = h - temperature*temp_step
    return scalergb(hue, s, l)
  end

  -- compute color code based on low and high thresholds and cpu temperature value
  local r,g,b = 0,0,0
  if (temperature - lo_val) > 0 then
    r, g, b = compute_rgb()
    r, g, b = scalergb(r, g, b)
  end

  -- compute output color as 32bit integer
  out_color = ((red << 16) | (green << 8) | blue) & 0x00ffffff

  -- return color code
  return string.format("${color #%06x}", out_color)
end

--- Conky hook -> CPU Color by frequency
function conky_cpu_color()
  --- read input from conky script
  local freq = conky_parse('$freq_g')

  -- return color string
  return conky_cpu_threshold_color(freq, system_parms.max_cpu_mhz, xrdb_colors.lightgrey) .. freq
end

--- Conky hook -> CPU Color by die temperature
function conky_cpu_temp_color()
  -- read CPU thermal sensor value
  local temp = conky_parse('$acpitemp')

  -- return color code string
  return conky_cpu_temperature_color(temp, system_parms.hi_temp_c, system_parms.lo_temp_c, xrdb_colors.lightgrey) .. temp
end

-- EOF
