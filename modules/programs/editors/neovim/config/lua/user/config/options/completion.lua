local opt = vim.opt

opt.completeopt = { -- How insert mode completion works.
	'menu', -- Show matches in a popup menu.
	'menuone', -- Show the menu even when there's only one match.
	'noinsert', -- Don't insert a match until it's selected.
}
opt.pumheight = 10 -- Show at most 10 items in the popup menu.
