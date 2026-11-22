local opt = vim.opt

opt.scrolloff = 5 -- Keep 5 lines visible above and below the cursor.
opt.sidescroll = 5 -- Scroll at least 5 columns sideways when the cursor leaves the screen.
opt.sidescrolloff = 5 -- Keep 5 columns visible left and right of the cursor when 'wrap' is off.
opt.startofline = true -- Move to the first non-blank character on commands like G, gg and Ctrl-D.
opt.jumpoptions = { -- How the jump list works.
	'stack', -- Jumping somewhere new after going back drops the newer entries.
	'view', -- Restore the scroll position when jumping back.
	'clean', -- Remove unloaded buffers from the jump list.
}
