{
  lib,
  buildNpmPackage,
  fetchurl,
  jq,
}:
buildNpmPackage (finalAttrs: {
  pname = "gh-actions-language-server";
  version = "0.0.3";

  src = fetchurl {
    url = "https://registry.npmjs.org/gh-actions-language-server/-/gh-actions-language-server-${finalAttrs.version}.tgz";
    hash = "sha256-lgisfGIWGT/WCGqOfm/rqSXVeDWqSge2YJ+ZiBMmS48=";
  };

  postPatch = ''
    ${lib.getExe jq} 'del(.devDependencies)' package.json > package.json.tmp
    mv package.json.tmp package.json
    cp ${./package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-TSfhYqkABTt/4GUDv5Q2pzf8ZU0twD93cLyueoLKFgE=";

  dontNpmBuild = true;

  meta = {
    description = "Language server for GitHub Actions workflows";
    homepage = "https://github.com/lttb/gh-actions-language-server";
    license = lib.licenses.mit;
    mainProgram = "gh-actions-language-server";
  };
})
