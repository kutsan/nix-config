local opt = vim.opt

local running_through_sudo = vim.env.SUDO_USER ~= nil

opt.modeline = false -- Ignore modelines in files.
opt.confirm = true -- Ask to save instead of failing when leaving a modified buffer.
opt.undolevels = 100000 -- Keep up to 100000 changes of undo history.
opt.undofile = not running_through_sudo -- Keep undo history after closing a file, except under sudo.
opt.swapfile = not running_through_sudo -- Write swap files, except under sudo.
opt.writebackup = not running_through_sudo -- Back up a file while overwriting it, except under sudo.

if running_through_sudo then
	vim.o.shada = '' -- Don't save history, marks or jumps under sudo.
else
	-- macOS stores /etc as /private/etc, which the default excludes, so exclude only its temporary folders.
	opt.shada:remove('r/private/')
	opt.shada:append({ 'r/private/tmp/', 'r/private/var/' })
end
