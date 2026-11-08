{
  lib,
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "nvim-ts-error-translator";
  version = "0-unstable-2026-01-03";

  src = fetchFromGitHub {
    owner = "dmmulroy";
    repo = "ts-error-translator.nvim";
    rev = "558abff11b9e8f4cefc0de09df780c56841c7a4b";
    hash = "sha256-kjZwfvb0B7GC4dBBSdgC/zRmCUCfCm4H5J+8SFzANJ4=";
  };

  meta = {
    description = "Translate TypeScript errors into plain English in Neovim";
    homepage = "https://github.com/dmmulroy/ts-error-translator.nvim";
    license = lib.licenses.mit;
  };
}
