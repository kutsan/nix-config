{
  lib,
  buildNpmPackage,
  fetchurl,
  jq,
}:
buildNpmPackage (finalAttrs: {
  pname = "stylelint-language-server";
  version = "1.2.0";

  src = fetchurl {
    url = "https://registry.npmjs.org/@stylelint/language-server/-/language-server-${finalAttrs.version}.tgz";
    hash = "sha256-JNeNE4PdqjbB39J54dLCBoUAMrh3YDPAE2w+OCIILqk=";
  };

  postPatch = ''
    ${lib.getExe jq} 'del(.devDependencies)' package.json > package.json.tmp
    mv package.json.tmp package.json
    cp ${./package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-JPBw0Q8COnI9Kzvsw/aEefZYQs4peh+lAdKSbFaNo88=";

  dontNpmBuild = true;

  # Packing would run its build script, while the published package is built already.
  npmPackFlags = [ "--ignore-scripts" ];

  meta = {
    description = "Official stylelint language server";
    homepage = "https://github.com/stylelint/vscode-stylelint";
    license = lib.licenses.mit;
    mainProgram = "stylelint-language-server";
  };
})
