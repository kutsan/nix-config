-- Enable treesitter highlighting, folding, and indentation per filetype.
-- Parsers come from Nix, so filetypes without one keep the regular syntax.
vim.api.nvim_create_autocmd('FileType', {
	desc = 'Start treesitter for filetypes that have a parser.',
	group = vim.api.nvim_create_augroup(
		'user.treesitter.auto_start',
		{ clear = true }
	),
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(args.match) or args.match
		local buf = args.buf

		if not vim.treesitter.language.add(lang) then
			return
		end

		vim.treesitter.start(buf, lang)

		vim.wo[0][0].foldmethod = 'expr'
		vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
