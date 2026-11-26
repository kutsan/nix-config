local opt = vim.opt

opt.number = true -- Show line numbers.
opt.cursorline = true -- Highlight the line the cursor is on.
opt.signcolumn = 'yes:1' -- Always show a sign column, one sign wide.
opt.statuscolumn = '%l%s' -- Show the line number, then the signs.
opt.laststatus = 0 -- Don't show a status line on the last window.
opt.statusline = ' ' -- Leave the status lines of other split windows blank.
opt.ruler = false -- Don't show the cursor position in the command line.
opt.showcmd = false -- Don't show partly typed commands in the last line.
opt.showmode = false -- Don't show the mode, like "-- INSERT --".
opt.cmdheight = 0 -- Hide the command line until it's needed.
opt.fillchars = { -- Characters that fill empty parts of the screen.
	fold = ' ', -- After the text of a closed fold.
	diff = ' ', -- Deleted lines in diff mode.
	eob = ' ', -- Empty lines after the end of the buffer.
}
opt.list = true -- Show invisible characters as set in 'listchars'.
opt.listchars = { -- How invisible characters are shown.
	-- 'multispace' and 'leadmultispace' are set per buffer from 'shiftwidth'
	-- by the `SyncMultiSpaceListchars` autocmd.
	tab = '▏ ', -- A tab, as a thin bar.
	nbsp = '␣', -- A non-breaking space.
	extends = '·', -- More text past the right edge, when 'wrap' is off.
	precedes = '·', -- More text past the left edge.
}
opt.wrap = false -- Don't wrap long lines.
opt.linebreak = true -- When wrapping, break lines at characters in 'breakat', like spaces.
opt.breakindent = true -- When wrapping, indent wrapped lines like the line they continue.
opt.shortmess = table.concat({ -- Shorten or hide messages.
	'l', -- "999L, 888B" instead of "999 lines, 888 bytes".
	'm', -- "[+]" instead of "[Modified]".
	'r', -- "[RO]" instead of "[readonly]".
	'w', -- "[w]" and "[a]" instead of "written" and "appended".
	'o', -- Replace the message for writing a file with the next message for reading one.
	'O', -- Let the message for reading a file replace any earlier message.
	's', -- No "search hit BOTTOM, continuing at TOP" messages.
	't', -- Cut long file messages at the start.
	'T', -- Cut other long messages in the middle.
	'I', -- No intro message on startup.
	'c', -- No messages from the completion menu.
	'F', -- No file info when editing a file.
	'W', -- No "written" or "[w]" when writing a file.
})
opt.report = 1000 -- Report changed lines only when more than 1000 change.
