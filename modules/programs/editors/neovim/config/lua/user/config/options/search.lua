local opt = vim.opt

opt.ignorecase = true -- Ignore case in searches.
opt.smartcase = true -- Match case when the search has an uppercase letter.
opt.hlsearch = false -- Don't highlight all matches.
opt.grepprg = 'grep ' -- Program and flags for :grep.
	.. '--line-number '
	.. '--binary-file="without-match" '
	.. '--no-messages '
	.. '--recursive '
	.. '--exclude-dir={.git,node_modules} '
	.. '--extended-regexp'
opt.grepformat = '%f:%l:%c:%m,%f:%l:%m' -- How to read the output of :grep.
