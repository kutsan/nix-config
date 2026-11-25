{
  lib,
  stdenv,
  swiftPackages,
}:
let
  inherit (stdenv.hostPlatform) darwinArch darwinMinVersion;
in
swiftPackages.stdenv.mkDerivation {
  name = "macos-next-calendar-event";

  src = ./next-calendar-event.swift;
  dontUnpack = true;

  nativeBuildInputs = [ swiftPackages.swift ];

  buildPhase = ''
    runHook preBuild

    swiftc -O -target ${darwinArch}-apple-macosx${darwinMinVersion} \
      -o next-calendar-event "$src"

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -D --target-directory="$out/bin" -- next-calendar-event

    runHook postInstall
  '';

  meta = {
    description = "Print the minutes until the next macOS Calendar event and its title";
    mainProgram = "next-calendar-event";
    platforms = lib.platforms.darwin;
  };
}
