{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "ia-writer-fonts";
  version = "0-unstable-2026-10-02";

  src = fetchFromGitHub {
    owner = "iaolo";
    repo = "iA-Fonts";
    rev = "c6588670c71e9ac628acc27b72cde4bf12726b7f";
    hash = "sha256-E/PA5cqZmRbaBYKJ/99YYhF/lgN6Stl/QoqTNLRI9bw=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    for family in Duo Mono Quattro; do
      install -Dm644 -t $out/share/fonts/truetype "iA Writer $family"/{Static,Variable}/*.ttf
    done

    runHook postInstall
  '';

  meta = {
    description = "iA Writer Duo, Mono and Quattro typefaces";
    homepage = "https://github.com/iaolo/iA-Fonts";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
  };
}
