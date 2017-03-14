-- Lua helper functions
-- Requires Conky 1.7+
-- Color computations are made in the HSL color space then converted to RGB.

-- checks if value is in range
function value_in_range(x, min, max)
  if (x>=min and x<=max) then
    return true
  else
    return false
  end
end

-- scales RGB values from values in range [0,1] to values in range [0,255]
function scalergb(r, g, b)
  return math.floor(r*0xff), math.floor(g*0xff), math.floor(b*0xff)
end

-- RGB to HSL
function conky_rgb2hsl(r,g,b)
  -- values need to be in the [0,1] range
  local function normalize_value(v)
    return v/255.0
  end
  local nr, ng, nb = 0,0,0
  -- normalize r g b values
  if not (value_in_range(r, 0, 1) and value_in_range(g, 0, 1) and value_in_range(b, 0, 1)) then
    nr = normalize_value(r)
    ng = normalize_value(g)
    nb = normalize_value(b)
  end

  -- local varuables on which we do computations
  local M,m,chroma = 0, 0, 0
  local L,S,H = 0, 0, 0

  -- Given these definitions:
  -- M = max(r,g,b)
  -- m = min(r,g,b)
  -- Chroma = (M-m)

  -- HSL Components are defined as:
  -- L = (M+m)/2
  -- S = 0 : L=1 ? C/(1 - |2L-1|)
  -- H is:
  --- (G-B)/C if M=r
  --- (B-R)/C +2 if M=g
  --- (R-G)/C +4 if M=b
  --- undefined otherwise
  -- http://en.wikipedia.com/wiki/HSL_and_HSV
  M = math.max(nr,ng,nb)
  m = math.min(nr,ng,nb)
  chroma = (M-m)

  -- Luminance
  L = (M+m)/2

  -- Saturation
  if (L==1) then
    S = 0 -- Achromatic
  else
    S = chroma/(1- math.abs(2*L - 1))
  end

  -- Hue (in range [0,360))
  if (M==nr) then
    H = 60*((ng-nb)/chroma)
  elseif (M==ng) then
    H = 60*((nb-nr)/chroma + 2)
  elseif (M==nb) then
    H = 60*((nr-ng)/chroma + 4)
  else
    H = 0 -- for commodity
  end

  -- return hue saturation and luminance values
  return H,S,L
end

-- HSL to RGB inverse transform
function conky_hsl2rgb(h,s,l)
  -- H is in range [0,360), S and L are in range [0,1]
  -- sanity check
  if not (value_in_range(s, 0, 1) and value_in_range(l, 0, 1)) then
    return 0,0,0
  end
  -- check h value
  if not value_in_range(h, 0, 360) then
    return 0,0,0
  end

  -- according to the wikipedia (https://en.wikipedia.org/wiki/HSL_and_HSV):
  -- Given these definitions:
  -- chroma = (1 - |2*L - 1|) * S
  -- normalizedH = H/60
  -- X = C * (1- |normalizedH mod 2 - 1|)
  -- RGB are computed as follows:
  -- R1,G1,B1 are
  -- (0,0,0) if H is undefined (-nan)
  -- (C,X,0) if 0<=X<1
  -- (X,C,0) if 1<=X<2
  -- (0,C,X) if 2<=X<3
  -- (0,X,C) if 3<=X<4
  -- (X,0,C) if 4<=X<5
  -- (C,0,X) if 5<=X<6
  --
  -- m = L - C/2 (lightness corrections)
  -- R,G,B = (R1+m, G1+m, B1+m)
  local chroma, normalizedH, X, R1, G1, B1, m, r, g, b = 0,0,0,0,0,0,0,0,0,0

  -- compute intermediate results
  chroma = s * (1 - math.abs(2*l - 1))
  normalizedH = h/60
  X = chroma * (1 - math.abs(math.fmod(normalizedH,2) - 1))
  m = l - chroma/2

  -- compute intermediate RGB values
  if (value_in_range(X, 0, 1)) then
    R1,G1,B1 = chroma, X, 0
  elseif (value_in_range(X, 1, 2)) then
    R1,G1,B1 = X, chroma, 0
  elseif (value_in_range(X, 2, 3)) then
    R1,G1,B1 = 0, chroma, X
  elseif (value_in_range(X, 3, 4)) then
    R1,G1,B1 = 0, X, chroma
  elseif (value_in_range(X, 4, 5)) then
    R1,G1,B1 = X, 0, chroma
  elseif (value_in_range(X, 5, 6)) then
    R1,G1,B1 = chroma, 0, X
  end

  -- return values
  return R1+m, G1+m, B1+m
end

-- Colored CPU GHz output line
function conky_cpu_threshold_color(cpu_frequency, max_freq, base_color)
  -- Convert GHz frequency to MHz
  local cpu_mhz = cpu_frequency * 1000
  -- Local Variables
  local out_color = 0

  -- Color Components
  -- HSL components: Hue, Saturation and Luminosity values for the base color
  local h, s, l = conky_rgb2hsl((base_color >> 16) & 0xff, (base_color >> 8) & 0xff, (base_color & 0xff))

  -- frequency steps
  -- divide the hue value space in "max_freq" evenly distributed steps
  local cpu_step = h/max_freq

  -- Compute frequency dependent Hue value
  local hue = h - (cpu_mhz)*cpu_step

  -- compute RGB components for the out color...
  local red, green, blue = conky_hsl2rgb(hue,s,l)
  red, green, blue = scalergb(red, green, blue)

  -- compute output color as 32bit integet
  out_color = ((red << 16) | (green << 8) | blue) & 0x00ffffff

  -- return conky color string
  return string.format("${color #%06x}", out_color)
end

--- Generate RGB value that follows the current CPU temperature value
function conky_cpu_temperature_color(temperature, hi_val, lo_val, base_color)
 -- output color value
  local out_color
  -- compute base color HSL values
  local h,s,l = conky_rgb2hsl((base_color >> 16) & 0xff, (base_color >> 8) & 0xff, base_color & 0xff)

  -- compute rgb value based on current CPU temperature
  local function compute_rgb(temperature, threshold)
    local temp_step = h/hi_val
    local hue = h - temperature*temp_step
    return conky_hsl2rgb(hue, s, l)
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
  return conky_cpu_threshold_color(freq, 2200, 0xd3) .. freq
end

--- Conky hook -> CPU Color by die temperature
function conky_cpu_temp_color()
  -- read CPU thermal sensor value
  local temp = conky_parse('$acpitemp')

  -- return color code string
  return conky_cpu_temperature_color(temp, 90, 38, 0xd3) .. temp
end

-- EOF
