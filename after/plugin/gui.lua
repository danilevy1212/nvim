local g = vim.g
--- NOTE  For now, we only consider neovide as a GUI
if not g.neovide then
    return
end

local opt = vim.opt

-- Make neovide backgroud transparent
g.neovide_transparency = 0.8

-- Default font
opt.guifont = 'Sarasa Mono J:h10'

-- Double width font
opt.guifontwide = 'Sarasa UI J:h10'

-- Activate floating window blend
opt.winblend = 15

-- Activate pop-up menus blend
opt.pumblend = 15

-- Make floating windows have a blur
g.neovide_floating_blur_amount_x = 2.0
g.neovide_floating_blur_amount_y = 2.0

-- Scroll animation
g.neovide_scroll_animation_length = 0.3

-- For fun, make the cursor sparkle
g.neovide_cursor_vfx_mode = 'pixiedust'

-- More sparkles!
g.neovide_cursor_vfx_particle_density = 21
