{ ... }:

{
  programs.herdr = {
    enable = true;
    settings = {
      onboarding = false;
      keys.prefix = "ctrl+a";
      ui.agent_panel_sort = "spaces";
      theme.name = "terminal";
    };
  };
}
