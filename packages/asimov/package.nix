{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "asimov";
  version = "0.12.0";

  src = fetchFromGitHub {
    owner = "AsimovMac";
    repo = "asimov";
    tag = "v${finalAttrs.version}";
    hash = "sha256-w3mmSu56vtiqoet6P2OFWcUVCdME2ckMTj3k7PRzw8I=";
  };

  dontBuild = true;
  dontPatchShebangs = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 bin/asimov $out/bin/asimov
    mkdir -p $out/libexec $out/share/asimov
    cp -R lib/asimov $out/libexec/asimov
    cp data/* $out/share/asimov/

    runHook postInstall
  '';

  meta = {
    description = "Automatically exclude development dependencies from Time Machine backups";
    homepage = "https://github.com/AsimovMac/asimov";
    changelog = "https://github.com/AsimovMac/asimov/blob/v${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.mit;
    platforms = lib.platforms.darwin;
    mainProgram = "asimov";
  };
})
