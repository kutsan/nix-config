local opt = vim.opt

opt.foldmethod = 'indent' -- Fold by indentation level.
opt.foldnestmax = 4 -- Nest folds at most 4 levels deep.
opt.foldlevelstart = 99 -- Open every file with all folds open.
opt.foldopen = { -- Commands that open a closed fold under the cursor.
	'hor', -- Horizontal movements, like l, w and fx.
	'mark', -- Jumping to a mark, like 'm and Ctrl-O.
	'percent', -- The % key.
	'quickfix', -- Quickfix commands, like :cn and :make.
	'tag', -- Jumping to a tag, like :ta and Ctrl-T.
	'undo', -- Undo and redo.
}
opt.foldtext =
	"v:lua.require('user.api.options.generate_foldtext').generate_foldtext()" -- Show closed folds with custom text.
