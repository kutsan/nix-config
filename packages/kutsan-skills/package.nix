{
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "kutsan-skills";
  version = "0-unstable-2026-10-19";

  src = fetchFromGitHub {
    owner = "kutsan";
    repo = "skills";
    rev = "409a71d67d858284ff3871c8a6b2a936641f6938";
    hash = "sha256-j7YkOOjzVfx4WFUvL8f5JcEVQgyK0K/OCvaqGx+Lba0=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/skills
    cp -R skills/. $out/share/skills/

    runHook postInstall
  '';

  meta = {
    description = "Kutsan's agent skills";
    homepage = "https://github.com/kutsan/skills";
  };
}
