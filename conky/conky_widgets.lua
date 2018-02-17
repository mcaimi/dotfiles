-- Cairo Widgets 
-- Requires Conky 1.7+

-- Conky HUD widgets drawing functions. requires cairo-lua

-- add local load path
userHome = os.getenv('HOME')
package.path = package.path .. ";" .. userHome .. "/.conky/?.lua"

-- require libraries
require 'cairo'
require 'conky_constants'

-- cairo defaults
cs,cr = nil

-- WIDGET FUNCTIONS
-- draw cpu arcs
function conky_draw_cpu_widget()
  -- get width and height
  local width = cairo_xlib_surface_get_width(cs)
  local height = cairo_xlib_surface_get_height(cs)

  -- compute left-side anchor points
  local anchor_y = height/2
  local anchor_x = cpu_frequency_ring['radius'] + cpu_frequency_ring['centerx']

  -- collect data
  local cpufreq_ghz = 0
  cpufreq_ghz = conky_parse("$freq_g")
  local cpu1load = 0 
  cpu1load = conky_parse("${cpu cpu1}")
  local thread1load = 0
  thread1load = conky_parse("${cpu cpu3}")
  local cpu2load = 0
  cpu2load = conky_parse("${cpu cpu2}")
  local thread2load = 0
  thread2load = conky_parse("${cpu cpu4}")

  -- draw CPU Freq background arc
  conky_arc_draw(cr,
      cpu_frequency_ring['radius'],
      anchor_x, anchor_y,
      (cpu_frequency_ring['angle0'] + CPU_DISPLACEMENT) * RAD_CONVERSION_FACTOR,
      (cpu_frequency_ring['anglef'] + CPU_DISPLACEMENT) * RAD_CONVERSION_FACTOR,
      cpu_load_ring['bgcolor'], cpu_frequency_ring['bgthickness'])

  conky_arc_draw(cr,
      cpu_frequency_ring['radius'] + cpu_frequency_ring['bgthickness']/2,
      anchor_x, anchor_y,
      (cpu_frequency_ring['angle0'] + CPU_DISPLACEMENT) * RAD_CONVERSION_FACTOR,
      (cpu_frequency_ring['anglef'] + CPU_DISPLACEMENT) * RAD_CONVERSION_FACTOR,
      0xffffff, 3.0)

  -- draw current cpu frequency arc
  conky_arc_draw(cr,
    cpu_frequency_ring['radius'],
    anchor_x, anchor_y,
    (cpu_frequency_ring['angle0'] + CPU_DISPLACEMENT) * RAD_CONVERSION_FACTOR,
    (cpu_frequency_ring['angle0'] + CPU_DISPLACEMENT + (cpufreq_ghz*cpu_frequency_ring['anglef'])/3.30) * RAD_CONVERSION_FACTOR,
    cpu_frequency_ring['fgcolor3'], cpu_frequency_ring['fgthickness'])

  -- draw Core0 load background arcs
  -- conky_text_write(cr, 40, 140, "Core 0")
  conky_arc_draw(cr,
      cpu_load_ring['radius'],
      anchor_x, anchor_y,
      (cpu_load_ring['angle0'] + LOAD_DISPLACEMENT) * RAD_CONVERSION_FACTOR,
      (cpu_load_ring['anglef'] + LOAD_DISPLACEMENT) * RAD_CONVERSION_FACTOR,
      cpu_load_ring['bgcolor'], cpu_load_ring['bgthickness'])

  -- draw Core1 background load arc
  -- conky_text_write(cr, 40, 140, "Core 1")
  conky_arc_draw(cr, 
      cpu_load_ring['inner_radius'], 
      anchor_x, anchor_y, 
      (cpu_load_ring['angle0'] + LOAD_DISPLACEMENT + DISPLACEMENT/2) * RAD_CONVERSION_FACTOR, 
      (cpu_load_ring['anglef'] + LOAD_DISPLACEMENT + DISPLACEMENT/2) * RAD_CONVERSION_FACTOR, 
      cpu_load_ring['bgcolor'], cpu_load_ring['bgthickness'])

  -- draw Core0 load arc
  --conky_text_write(cr, anchor_x - 40, anchor_y + 80, "Core0: Thread1: "..cpu1load.."%".." - Thread2: "..thread1load.."%", 10)
  conky_arc_draw(cr, 
      cpu_load_ring['radius'], 
      anchor_x, anchor_y, 
      (cpu_load_ring['angle0'] + LOAD_DISPLACEMENT) * RAD_CONVERSION_FACTOR, 
      ((cpu_load_ring['angle0'] + ((cpu1load * 100.0) / 90.0)) + LOAD_DISPLACEMENT) * RAD_CONVERSION_FACTOR, 
      cpu_load_ring['fgcolor'], cpu_load_ring['fgthickness'])

  conky_arc_draw(cr, 
      cpu_load_ring['radius'], 
      anchor_x, anchor_y, 
      (cpu_load_ring['angle0'] + LOAD_DISPLACEMENT) * RAD_CONVERSION_FACTOR, 
      ((cpu_load_ring['angle0'] + ((thread1load * 100.0) / 90.0)) + LOAD_DISPLACEMENT) * RAD_CONVERSION_FACTOR, 
      cpu_load_ring['fgcolor'] / 2, cpu_load_ring['fgthickness'] / 2)

  -- draw Core1 load arc
  --conky_text_write(cr, anchor_x - 32, anchor_y + 65, "Core1: Thread1: "..cpu2load.."%".." - Thread2: "..thread2load.."%", 10)
  conky_arc_draw(cr, 
      cpu_load_ring['inner_radius'], 
      anchor_x, anchor_y, 
      (cpu_load_ring['angle0'] + LOAD_DISPLACEMENT + DISPLACEMENT/2) * RAD_CONVERSION_FACTOR, 
      ((cpu_load_ring['angle0'] + ((cpu2load * 100.0) / 90.0)) + LOAD_DISPLACEMENT + DISPLACEMENT/2) * RAD_CONVERSION_FACTOR, 
      cpu_load_ring['fgcolor'], cpu_load_ring['fgthickness'])

  conky_arc_draw(cr, 
      cpu_load_ring['inner_radius'], 
      anchor_x, anchor_y, 
      (cpu_load_ring['angle0'] + LOAD_DISPLACEMENT + DISPLACEMENT/2) * RAD_CONVERSION_FACTOR, 
      ((cpu_load_ring['angle0'] + ((thread2load * 100.0) / 90.0)) + LOAD_DISPLACEMENT + DISPLACEMENT/2) * RAD_CONVERSION_FACTOR, 
      cpu_load_ring['fgcolor'] / 2, cpu_load_ring['fgthickness'] / 2)

  -- draw last arcs
  conky_arc_draw(cr, 
      cpu_load_ring['radius'] + cpu_load_ring['bgthickness']/2, 
      anchor_x, anchor_y, 
      (cpu_load_ring['angle0'] + LOAD_DISPLACEMENT) * RAD_CONVERSION_FACTOR, 
      (cpu_load_ring['anglef'] + LOAD_DISPLACEMENT) * RAD_CONVERSION_FACTOR, 
      0xffffff, 0.8)
  conky_arc_draw(cr, 
      cpu_load_ring['inner_radius'] + cpu_load_ring['bgthickness']/2, 
      anchor_x, anchor_y, 
      (cpu_load_ring['angle0'] + LOAD_DISPLACEMENT + DISPLACEMENT/2) * RAD_CONVERSION_FACTOR, 
      (cpu_load_ring['anglef'] + LOAD_DISPLACEMENT + DISPLACEMENT/2) * RAD_CONVERSION_FACTOR, 
      0xffffff, 0.6)

  -- draw Widget labels
  conky_text_write_custom(cr, anchor_x + cpu_frequency_ring['radius'] + 8, anchor_y + cpu_frequency_ring['radius'], 
      "Intel Corei7 CPU", font_properties['size'], 0xffff00, 1.0)
  conky_text_write_custom(cr, anchor_x + cpu_frequency_ring['radius'] + 10, anchor_y + cpu_frequency_ring['radius'] + 15,
       " - Current CPU Frequency:  ".. cpufreq_ghz .." GHz", font_properties['size'], 0xffffff, 1.0)
  conky_text_write_custom(cr, anchor_x + cpu_frequency_ring['radius'] + 10, anchor_y + cpu_frequency_ring['radius'] + 30,
       " - Core0 Load:  ".. cpu1load .." % (HyperThread 0: " .. thread1load .. "%)", font_properties['size'], 0xffffff, 1.0)
  conky_text_write_custom(cr, anchor_x + cpu_frequency_ring['radius'] + 10, anchor_y + cpu_frequency_ring['radius'] + 45,
       " - Core1 Load:  ".. cpu2load .." % (HyperThread 1: " .. thread2load .. "%)", font_properties['size'], 0xffffff, 1.0)
end

-- draw HUD lines
function conky_draw_hud()
  -- get width and height
  local width = cairo_xlib_surface_get_width(cs)
  local height = cairo_xlib_surface_get_height(cs)

  -- compute left-side anchor points
  local anchor_y = height/2
  local anchor_x = cpu_frequency_ring['radius'] + cpu_frequency_ring['centerx']

  -- draw center point
  conky_arc_draw(cr, 2, anchor_x, anchor_y, 0, 360, 0xffffff, 4)
  -- draw HUD lines
  conky_draw_line(cr, anchor_x, anchor_y, (width - 40), anchor_y, 0.6, 0xffffff, 1.0)
  conky_draw_line(cr, (width - 40), anchor_y, (width - 40), (anchor_y - 40), 0.6, 0xffffff, 1.0)
  -- draw end point
  conky_arc_draw(cr, 2, (width - 40), (anchor_y - 40), 0, 360, 0xffffff, 4)

  conky_arc_draw(cr, 20, anchor_x, anchor_y, 0.8, 360, 0xffffff, 2.0)

  -- draw bells and whistles (CPU FREQUENCY)
  conky_draw_line(cr, anchor_x + 40, anchor_y + 40, anchor_x + cpu_frequency_ring['radius'], 
      (anchor_y + cpu_frequency_ring['radius']), 0.8, 0xffffff, 1.5)

  conky_arc_draw(cr, 2, anchor_x + 40, anchor_y + 40, 0.8, 360, 0xffffff, 4)
  conky_arc_draw(cr, 2, anchor_x + cpu_frequency_ring['radius'], anchor_y + cpu_frequency_ring['radius'], 0, 360, 0xffffff, 4)

  conky_draw_line(cr, anchor_x + cpu_frequency_ring['radius'], anchor_y + cpu_frequency_ring['radius'] - 15, 
      anchor_x + cpu_frequency_ring['radius'], 
      (anchor_y + cpu_frequency_ring['radius']) + 80, 1.0, 0xffffff, 2.0)

  conky_draw_line(cr, anchor_x, anchor_y,
      (anchor_x + (cpu_load_ring['inner_radius']*math.cos(LOAD_DISPLACEMENT + DISPLACEMENT/2))), 
      (anchor_y - (cpu_load_ring['inner_radius']*math.sin(LOAD_DISPLACEMENT + DISPLACEMENT/2))), 
      1.0, 0xffffff, 2.0)

  conky_arc_draw(cr, 2, (anchor_x + (cpu_load_ring['inner_radius']*math.cos(LOAD_DISPLACEMENT + DISPLACEMENT/2))),
      (anchor_y - (cpu_load_ring['inner_radius']*math.sin(LOAD_DISPLACEMENT + DISPLACEMENT/2))),
      0.8, 360, 0xffffff, 4)
end

-- draw filesystem usage widget
function conky_draw_filesystem_widget(filesystem)
  -- get width and height
  local width = cairo_xlib_surface_get_width(cs)
  local height = cairo_xlib_surface_get_height(cs)

  -- compute left-side anchor points
  local anchor_y = height/2
  local anchor_x = cpu_frequency_ring['radius'] + cpu_frequency_ring['centerx']

  -- parse and get filesystem data
  local size_tot, _ns = string.gsub(conky_parse('${fs_size '..filesystem..'}'), "GiB", "")
  local used_size, _ns = string.gsub(conky_parse('${fs_used '..filesystem..'}'), "GiB", "")
  local fs_perc = conky_parse('${fs_free_perc '..filesystem..'}')

  conky_text_write_custom(cr, width - 100, anchor_y + 45,
       "Filesystem", font_properties['size'], 0xffffff, 1.0)
end

-- draw lines
function conky_draw_line(context, xo, yo, xf, yf, line_width, color, alpha)
  -- select color
  cairo_set_source_rgba(context, rgb_to_r_g_b(color, alpha))
  -- select line thickness
  cairo_set_line_width(context, line_width)
  -- move origin
  cairo_move_to(context, xo, yo)
  --draw line
  cairo_line_to(context, xf, yf)
  -- swap buffers
  cairo_stroke(context)
end

-- write strings using cairo
function conky_text_write(context, x, y, text_string, size)
  -- select color
  cairo_set_source_rgba(context, rgb_to_r_g_b(font_properties['color'], font_properties['alpha']))
  -- select font
  cairo_select_font_face(context, font_properties['font'], font_properties['slant'], font_properties['weight'])
  -- set font size
  cairo_set_font_size(context, size)
  -- move to desired place
  cairo_move_to(context, x, y)
  -- write
  -- cairo_set_operator(context, CAIRO_OPERATOR_CLEAR)
  cairo_show_text(context, text_string)
  cairo_stroke(context)
end

-- write strings using cairo
function conky_text_write_custom(context, x, y, text_string, size, color, alpha)
  -- select color
  cairo_set_source_rgba(context, rgb_to_r_g_b(color, alpha))
  -- select font
  cairo_select_font_face(context, font_properties['font'], font_properties['slant'], font_properties['weight'])
  -- set font size
  cairo_set_font_size(context, size)
  -- move to desired place
  cairo_move_to(context, x, y)
  -- write
  -- cairo_set_operator(context, CAIRO_OPERATOR_CLEAR)
  cairo_show_text(context, text_string)
  cairo_stroke(context)
end

-- draw rectangle
function conky_rectangle_draw(context, xo, yo, width, height, color, alpha, line_width)
  
  -- draw a rectangle
  cairo_rectangle(context, xo, yo, width, height)
  -- select color for all drawing operations
  cairo_set_source_rgba(context, rgb_to_r_g_b(color, 1.0))
  -- set line width
  cairo_set_line_width(context, line_width)
  -- draw object 
  cairo_stroke(context)
end

-- draw an arc
function conky_arc_draw(context, radius, xc, yc, angle1, angle2, color, line_width)
  -- prepare arc
  cairo_arc(context, xc, yc, radius, angle1, angle2)
  -- set color
  cairo_set_source_rgba(context, rgb_to_r_g_b(color, 1.0))
  -- set line width
  cairo_set_line_width(context, line_width)
  -- draw
  cairo_stroke(context)
end

-- draw a negative arc
function conky_arc_draw_negative(context, radius, xc, yc, angle1, angle2, color, line_width)
  -- set color
  cairo_set_source_rgba(context, rgb_to_r_g_b(color, 1.0))
  -- prepare negative arc
  cairo_arc_negative(context, xc, yc, radius, angle1, angle2)
  -- set line width
  cairo_set_line_width(context, line_width)
  -- draw
  cairo_stroke(context)
end

-- HELPER FUNCTIONS
-- convert RGB value into r, g, b single color channels
function rgb_to_r_g_b(colour,alpha)
  return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

-- MAIN FUNCTIONS
-- Main HUD drawing callback function
function conky_cairo_draw_hud()
  -- check conky instance
  if conky_window == nil then return end
  
  -- create surface
  conky_cairo_initialize()
  
  -- draw CPU rings
  conky_draw_cpu_widget()
  
  -- draw HUD Lines
  conky_draw_hud()
  
  -- draw filesystem bars
  -- conky_draw_filesystem_widget('/')
  
  -- cleanup
  conky_cairo_cleanup()
end

-- Filesystems HUD panel drawing function
function conky_cairo_draw_filesystem_hud()
  -- check conky instance
  if conky_window == nil then return end
  
  -- create surface
  conky_cairo_initialize()
  
  -- draw filesystem bars
  conky_draw_filesystem_widget('/')
  
  -- cleanup
  conky_cairo_cleanup()
end

-- initialize cairo surface
function conky_cairo_initialize()
  -- check cairo surface 
  -- and regenerate it
  if cs == nil or cairo_xlib_surface_get_width(cs) ~= conky_window.width or cairo_xlib_surface_get_height(cs) ~= conky_window.height then
    -- create a new surface to draw on
    if cs then cairo_surface_destroy(cs) end
    cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
  end
  
  -- create cairo context from surface
  if cr then cairo_destroy(cr) end
  cr = cairo_create(cs)
end

-- destroy cairo surface
function conky_cairo_cleanup()
  -- cleanup context
  if cr then cairo_destroy(cr) end
  cr=nil

  -- cleanup surface
  if cs then
    cairo_surface_destroy(cs)
    cs=nil
  else
    cs=nil
    return
  end
end

-- EOF
