{
  flake.modules.homeManager.sbx = {
    sbx.kits.agent-instructions.descriptor = {
      displayName = "Agent instructions";
      description = "Personal instructions for the coding agent, whichever agent the sandbox runs";

      capabilities = [
        {
          type = "com.docker.sandbox/agent-context@2";
          config.content = builtins.readFile ./AGENTS.md;
        }
      ];
    };
  };
}
