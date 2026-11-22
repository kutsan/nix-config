local opt = vim.opt

opt.tabstop = 2 -- Show a tab as 2 columns wide.
opt.shiftwidth = 0 -- Indent by 'tabstop' columns, since 0 means use 'tabstop'.
opt.softtabstop = -1 -- Make Tab and Backspace move by 'shiftwidth' columns, since -1 means use 'shiftwidth'.
opt.expandtab = true -- Insert spaces instead of tab characters.
opt.shiftround = true -- Round indentation to a multiple of 'shiftwidth'.
