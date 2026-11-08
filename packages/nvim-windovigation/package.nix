{
  lib,
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "nvim-windovigation";
  version = "0-unstable-2025-04-01";

  src = fetchFromGitHub {
    owner = "volskaya";
    repo = "windovigation.nvim";
    rev = "16d7331153236e1e196331c6a7c81b2db019fab8";
    hash = "sha256-TSi7TWTvtNLW9a4d/OKrD2HOYNcDkHuT3rohRhxmCFo=";
  };

  meta = {
    description = "Scope Neovim buffers to window splits instead of a global buffer list";
    homepage = "https://github.com/volskaya/windovigation.nvim";
    license = lib.licenses.asl20;
  };
}
