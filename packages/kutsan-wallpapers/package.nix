{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "kutsan-wallpapers";
  version = "0-unstable-2026-09-28";

  src = fetchFromGitHub {
    owner = "kutsan";
    repo = "wallpapers";
    rev = "81f524db323d24a07d90cda1ce11b5478cf57e74";
    hash = "sha256-IDJehSVrKSGmTNoU6wEjpGg75WOEWxc1c8goRmX+IIQ=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/wallpapers
    cp -R images/. $out/share/wallpapers/

    runHook postInstall
  '';

  meta = {
    description = "Kutsan's wallpapers";
    homepage = "https://github.com/kutsan/wallpapers";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
