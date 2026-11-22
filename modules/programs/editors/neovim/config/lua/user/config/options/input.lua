local opt = vim.opt

opt.mouse = table.concat({ -- Modes where the mouse works.
	'n', -- Normal mode.
	'v', -- Visual mode.
})
opt.timeoutlen = 500 -- Wait up to 500 ms for the rest of a mapped key sequence.
opt.ttimeoutlen = 0 -- Don't wait for the rest of a terminal key code.
opt.updatetime = 500 -- Write the swap file and fire CursorHold after 500 ms without typing.
opt.keymap = 'diacritic' -- Turn on the diacritic key mappings from the keymap folder.
