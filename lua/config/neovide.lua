-- Make neovide backgroud transparent
vim.g.neovide_transparency = 0.8

-- Default font
seto('guifont', CONSTANTS.IS_MACOS and 'Sarasa Mono J:h18' or 'Sarasa Mono J:h10')

-- Double width font
seto('guifontwide', CONSTANTS.IS_MACOS and 'Sarasa UI J:h18' or 'Sarasa UI J:h10')

-- Make floating windows have a blur
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0

-- Scroll animation
vim.g.neovide_scroll_animation_length = 0.3

-- For fun, make the cursor sparkle
vim.g.neovide_cursor_vfx_mode = 'pixiedust'

-- More sparkles!
vim.g.neovide_cursor_vfx_particle_density = 21
