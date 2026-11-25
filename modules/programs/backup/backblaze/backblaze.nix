{
  flake.modules.darwin.backblaze = {
    homebrew.casks = [
      "backblaze"
    ];

    system.activationScripts.postActivation.text = ''
      if [[ -d /Library/Backblaze.bzpkg/bzdata ]]; then
        install --mode u=rw,g=r,o=r -- ${./exclusion-rules.xml} /Library/Backblaze.bzpkg/bzdata/bzexcluderules_editable.xml
      fi
    '';
  };
}
