{
  lib,
  buildNpmPackage,
  fetchurl,
  jq,
}:
buildNpmPackage (finalAttrs: {
  pname = "cssmodules-language-server";
  version = "1.5.2";

  src = fetchurl {
    url = "https://registry.npmjs.org/cssmodules-language-server/-/cssmodules-language-server-${finalAttrs.version}.tgz";
    hash = "sha256-joXAPsDIf+sa1FAMzpXVbGKbTL0bdc6LWxy1l2KqljI=";
  };

  postPatch = ''
    ${lib.getExe jq} 'del(.devDependencies)' package.json > package.json.tmp
    mv package.json.tmp package.json
    cp ${./package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-PFUVQlzDuGWPpBT1wM6XC89UAl5dqOBSeydZ3j6ohfc=";

  dontNpmBuild = true;

  meta = {
    description = "Language server with completion and go-to-definition for CSS modules";
    homepage = "https://github.com/antonk52/cssmodules-language-server";
    license = lib.licenses.mit;
    mainProgram = "cssmodules-language-server";
  };
})
