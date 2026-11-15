{
  lib,
  buildNpmPackage,
  fetchurl,
  jq,
}:
buildNpmPackage (finalAttrs: {
  pname = "lua-3p-language-servers";
  version = "1.0.2";

  src = fetchurl {
    url = "https://registry.npmjs.org/lua-3p-language-servers/-/lua-3p-language-servers-${finalAttrs.version}.tgz";
    hash = "sha256-tQgE3Szd+gzkIsx2cqzrc0ck3VHDltlOA9DroG00l4U=";
  };

  postPatch = ''
    ${lib.getExe jq} 'del(.devDependencies)' package.json > package.json.tmp
    mv package.json.tmp package.json
    cp ${./package-lock.json} package-lock.json
  '';

  npmDepsHash = "sha256-1WjFpESfP93ZbGHkLZZNrjSw/mcPW6Xd0RMcf9Agh64=";

  dontNpmBuild = true;

  meta = {
    description = "Language servers for the selene linter and the stylua formatter";
    homepage = "https://github.com/antonk52/lua-3p-language-servers";
    license = lib.licenses.mit;
    mainProgram = "selene-3p-language-server";
  };
})
