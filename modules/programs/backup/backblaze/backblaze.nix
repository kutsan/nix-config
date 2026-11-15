{
  flake.modules.darwin.backblaze =
    { lib, pkgs, ... }:
    let
      excludedFolderPatterns = [
        "/node_modules/"
        "/.git/"
        "/Library/Application Support/com.docker.sandboxes/"
      ];

      excludeRulesFilePath = "/Library/Backblaze.bzpkg/bzdata/bzexcluderules_editable.xml";

      rulesRootXPath = "/bzexclusions";
      lastRuleXPath = "${rulesRootXPath}/excludefname_rule[last()]";
      ruleForFolderXPath =
        folderPattern: "${rulesRootXPath}/excludefname_rule[@contains_1='${folderPattern}']";

      addAttributeToLastRuleArguments = attributeName: attributeValue: [
        "--insert"
        lastRuleXPath
        "--type"
        "attr"
        "--name"
        attributeName
        "--value"
        attributeValue
      ];

      replaceRuleForFolderArguments =
        folderPattern:
        [
          "--delete"
          (ruleForFolderXPath folderPattern)
          "--subnode"
          rulesRootXPath
          "--type"
          "elem"
          "--name"
          "excludefname_rule"
        ]
        ++ addAttributeToLastRuleArguments "plat" "mac"
        ++ addAttributeToLastRuleArguments "osVers" "*"
        ++ addAttributeToLastRuleArguments "ruleIsOptional" "t"
        ++ addAttributeToLastRuleArguments "skipFirstCharThenStartsWith" "Users/"
        ++ addAttributeToLastRuleArguments "contains_1" folderPattern
        ++ addAttributeToLastRuleArguments "contains_2" "*"
        ++ addAttributeToLastRuleArguments "doesNotContain" "*"
        ++ addAttributeToLastRuleArguments "endsWith" "*"
        ++ addAttributeToLastRuleArguments "hasFileExtension" "*";

      xmlstarletEditArguments = lib.concatMap replaceRuleForFolderArguments excludedFolderPatterns;
    in
    {
      assertions = [
        {
          assertion = lib.all (folderPattern: !lib.hasInfix "'" folderPattern) excludedFolderPatterns;
          message = "A Backblaze excluded folder pattern can't contain a single quote.";
        }
      ];

      homebrew.casks = [
        "backblaze"
      ];

      system.activationScripts.postActivation.text = ''
        if [[ -f ${excludeRulesFilePath} ]]; then
          ${lib.getExe pkgs.xmlstarlet} edit --inplace ${lib.escapeShellArgs xmlstarletEditArguments} ${excludeRulesFilePath}
        fi
      '';
    };
}
