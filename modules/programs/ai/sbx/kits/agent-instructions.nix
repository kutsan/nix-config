{
  flake.modules.homeManager.sbx = {
    sbx.kits.agent-instructions = {
      displayName = "Agent instructions";
      description = "Personal instructions for the coding agent, whichever agent the sandbox runs";

      capabilities = [
        {
          type = "com.docker.sandbox/agent-context@2";
          config.content = builtins.readFile ../../../../system/settings/agents/AGENTS.md;
        }
      ];
    };
  };
}
