{
  flake.modules.homeManager.less =
    let
      escapeCharacter = builtins.fromJSON ''"\u001b"'';
    in
    {
      programs.less = {
        enable = true;

        config = ''
          #command
          h left-scroll
          l right-scroll
        '';
      };

      home.sessionVariables = {
        PAGER = "less";
        LESS = "--ignore-case --tilde --chop-long-lines --status-column --LONG-PROMPT --jump-target=10 --RAW-CONTROL-CHARS --clear-screen --tabs=4 --shift=5";
        LESSHISTFILE = "-";

        LESS_TERMCAP_md = "${escapeCharacter}[01;34m";
        LESS_TERMCAP_me = "${escapeCharacter}[0m";
        LESS_TERMCAP_mh = "${escapeCharacter}[2m";
        LESS_TERMCAP_mr = "${escapeCharacter}[7m";
        LESS_TERMCAP_se = "${escapeCharacter}[27;0m";
        LESS_TERMCAP_so = "${escapeCharacter}[1;33m";
        LESS_TERMCAP_ue = "${escapeCharacter}[24;0m";
        LESS_TERMCAP_us = "${escapeCharacter}[4;1;38;5;250m";
      };
    };
}
