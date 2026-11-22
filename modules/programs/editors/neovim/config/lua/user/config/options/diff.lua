local opt = vim.opt

opt.diffopt = { -- How diff mode compares and shows files.
	'filler', -- Show filler lines to keep both sides aligned.
	'vertical', -- Start diff mode with vertical splits.
	'hiddenoff', -- Turn diff mode off for a buffer when it becomes hidden.
	'foldcolumn:0', -- Don't show a fold column in diff mode.
	'algorithm:histogram', -- Use the histogram diff algorithm.
	'internal', -- Use the built-in diff library.
	'closeoff', -- When one of two diff windows closes, turn diff mode off in the other.
	'indent-heuristic', -- Use the indent heuristic of the built-in diff library.
	'linematch:60', -- Align similar changed lines, in changes up to 60 lines long.
}
