-- vim configuration main settings file
-- this is a direct port of some of my old vimrc settings

-- utils module
local u = require("utils.utils")

-- global namespace
local g = vim.g
-- global options
local o = vim.o
-- window options
local wo = vim.wo
-- buffer options
local bo = vim.bo

-- The following are commented out as they cause vim to behave a lot
-- differently from regular Vi. They are highly recommended though.
o.showcmd = true            -- Show (partial) command in status line.
o.showmatch = true          -- Show matching brackets.
o.incsearch = true          -- Incremental search
o.autowrite = true          -- Automatically save before commands like :next and :make
o.hidden = true             -- Hide buffers when they are abandoned
o.mouse = 'a'               -- Enable mouse usage (all modes) in terminals
o.number = true             -- show line numbers
o.showmode = true           -- Show current mode.
o.ruler = true              -- Show the line and column numbers of the cursor.
o.number = true             -- Show the line numbers on the left side.
o.formatoptions = o.formatoptions .. ',o'        -- Continue comment marker in new lines.
o.textwidth = 0             -- Hard-wrap long lines as you type them.
o.expandtab = true          -- Insert spaces when TAB is pressed.
o.tabstop = 2               -- Render TABs using this many spaces.
o.shiftwidth = 2            -- Indentation amount for < and > commands.
o.errorbells = false        -- No beeps.
o.modeline = true           -- Enable modeline.
o.linespace = 0             -- o.line-spacing to minimum.
o.joinspaces = false        -- Prevents inserting two spaces after punctuation on a join (J)
o.showmode = false          -- Prevents showing current editing mode. It's already embedded in lightline--
o.cursorcolumn = true       -- Highlight the text column under the cursor--
o.startofline = false       -- Do not jump to first character with page commands.
o.ignorecase = true         -- Make searching case insensitive
o.smartcase = true          -- ... unless the query has capital letters.
o.gdefault = true           -- Use 'g' flag by default with :s/foo/bar/.
o.magic = true              -- Use 'magic' patterns (extended regular expressions).
o.list = true               -- Show problematic characters.
o.rnu = true                -- Set relative numbers for line numbering
o.updatetime = 500

-- More natural splits
o.splitbelow = true         -- Horizontal split below current.
o.splitright = true         -- Vertical split to right of current.

-- buffer scroll settings
o.scrolloff = 3             -- Show next 3 lines while scrolling.
o.sidescrolloff = 5         -- Show next 5 columns while side-scrolling.

-- completion options
o.completeopt = 'menuone,noinsert,noselect'
o.shortmess = 'c'

-- config options for neovide
if g.neovide then
  -- theme settings
  o.termguicolors = true
  vim.cmd [[colorscheme kanagawa-dragon]]

  o.guifont = "Spleen 32x64:h14"
  o.linespace = 1
  g.neovide_padding_top = 1
  g.neovide_padding_bottom = 1
  g.neovide_padding_right = 1
  g.neovide_padding_left = 1

  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  g.neovide_transparency = 0.9
  g.transparency = 0.9
  g.neovide_transparency = "#3d3d3d" .. u.alpha(g.transparency)
  g.neovide_window_blurred = true
  g.neovide_floating_blur_amount_x = 2.0
  g.neovide_floating_blur_amount_y = 2.0

else
  require('ayu').setup({
    mirage = true,
    overrides = {
      Normal = { bg = "None" },
      ColorColumn = { bg = "None" },
      SignColumn = { bg = "None" },
      Folded = { bg = "None" },
      FoldColumn = { bg = "None" },
      CursorLine = { bg = "None" },
      CursorColumn = { bg = "None" },
      WhichKeyFloat = { bg = "None" },
      VertSplit = { bg = "None" },
    },
  })
  require('ayu').colorscheme()
end
