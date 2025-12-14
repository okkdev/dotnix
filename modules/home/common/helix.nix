{ ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        line-number = "relative";
        cursorline = true;
        scrolloff = 8;
        color-modes = true;
        true-color = true;

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };
      keys.normal = {
        space.space = "file_picker";
      };
    };
    languages = {
      language = [
        {
          name = "elixir";
          auto-format = true;
        }
        {
          name = "rust";
          auto-format = true;
        }
      ];
    };
  };
}
