{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin {
  pname = "nvim-color-converter";
  version = "0-unstable-2025-02-11";

  src = fetchFromGitHub {
    owner = "NTBBloodbath";
    repo = "color-converter.nvim";
    rev = "5888e92cbccf0de202d2b617f6a8f3011a43bd52";
    hash = "sha256-gQDSHeQnfMteZjr0Ji8wsTzo6alK/dgcVL3YSRVshyc=";
  };

  meta = {
    description = "Convert CSS colors between formats without leaving Neovim";
    homepage = "https://github.com/NTBBloodbath/color-converter.nvim";
  };
}
