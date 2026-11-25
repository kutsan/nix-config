{
  lib,
  rustPlatform,
  fetchFromGitHub,
  gitMinimal,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "codediff-watcher";
  version = "0.23.2";

  src = fetchFromGitHub {
    owner = "esmuellert";
    repo = "codediff";
    tag = "v${finalAttrs.version}";
    hash = "sha256-YiDCNp5buIYQhnquC/1hjLGBjGtzSMu6BAgHtcYCt5o=";
  };

  cargoHash = "sha256-wiyDnyYop2lbmUVt5H4SiizaE4Kl5pAkBn5r8c3M9UI=";

  cargoBuildFlags = [
    "--package"
    "watcher"
    "--bin"
    "codediff-watcher"
  ];

  nativeCheckInputs = [ gitMinimal ];

  cargoTestFlags = [
    "--package"
    "watcher"
  ];

  meta = {
    description = "Git repository watcher that tells codediff.nvim what to refresh";
    homepage = "https://github.com/esmuellert/codediff";
    license = lib.licenses.mit;
    mainProgram = "codediff-watcher";
  };
})
