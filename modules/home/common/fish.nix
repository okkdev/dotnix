{ pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "hydro";
        src = pkgs.fetchFromGitHub {
          owner = "okkdev";
          repo = "hydro";
          rev = "02994b1141f7";
          sha256 = "sha256-EFmH+NrDRGRS4006zN/y3fVPJfVjZBnyIPYa/ycKezc=";
        };
      }
    ];
    loginShellInit = "fish_add_path --move --prepend --path $HOME/.nix-profile/bin /nix/var/nix/profiles/default/bin";
    shellInit = # fish
      ''
        ${
          if pkgs.stdenv.isDarwin then
            #fish
            ''
              fish_add_path /opt/homebrew/sbin
              fish_add_path /opt/homebrew/bin

              if test -d (brew --prefix)"/share/fish/completions"
                  set -gx fish_complete_path (brew --prefix)/share/fish/completions $fish_complete_path 
              end

              if test -d (brew --prefix)"/share/fish/vendor_completions.d"
                  set -gx fish_complete_path (brew --prefix)/share/fish/vendor_completions.d $fish_complete_path 
              end
            ''
          else
            ""
        }

        fish_add_path $HOME/.ghcup/bin
        fish_add_path $HOME/.cabal/bin
        fish_add_path $HOME/.cargo/bin

        set -g hydro_symbol_prompt "$(shell_level)✨"
        set -U hydro_multiline true
      '';
    shellAbbrs = {
      npm = "pnpm";
      du = "dust";
      cat = "bat";
      man = "batman";
    };
    shellAliases = {
      ssh = lib.mkIf pkgs.stdenv.isDarwin "TERM=xterm-256color /usr/bin/ssh";
      llat = "lla -snew";
    };
    functions = {
      fish_greeting = {
        description = "Greeting to show when starting a fish shell";
        body = "echo 🐟";
      };
      shell_level = {
        description = "show the current shell level as icon";
        body = # fish
          ''
            switch (math "$SHLVL - ${if pkgs.stdenv.isDarwin then "1" else "2"}")
              case 0
                  echo " "
              case 1
                  echo ⋅
              case 2
                  echo ∶
              case 3
                  echo ∴
              case 4
                  echo ∷
              case '*'
                  echo (math "$SHLVL - 1")
            end
          '';
      };
      ns = {
        description = "nix shell shorthand";
        body = # fish
          ''
            if test (count $argv) -eq 0
                echo "Error: Please provide at least one package name"
                return 1
            end

            set nix_shell_cmd "nix shell"

            for pkg in $argv
                set nix_shell_cmd "$nix_shell_cmd nixpkgs#$pkg"
            end

            eval $nix_shell_cmd
          '';
      };
      nr = {
        description = "nix run shorthand";
        argumentNames = "pkg";
        body = # fish
          ''
            nix run nixpkgs#$pkg -- $argv[2..-1]
          '';
      };

      os_theme = pkgs.lib.mkIf pkgs.stdenv.isDarwin {
        description = "get the current appearance mode of the system";
        body = # fish
          ''
            if [ (defaults read -g AppleInterfaceStyle 2> /dev/null) ]
              echo "dark"
            else
              echo "light"
            end
          '';
      };
      switch_theme = pkgs.lib.mkIf pkgs.stdenv.isDarwin {
        argumentNames = "mode";
        description = "switches global theme";
        body = # fish
          ''
            set nvims "$TMPDIR"nvim."$USER"/*/nvim.*.0
            if [ "$mode" = "dark" ]
              osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = true" > /dev/null
              if count $nvims >/dev/null
                for i in (ls $nvims)
                  nvim --server $i --remote-send '<ESC>:DarkTheme<CR>'
                end
              end
              echo "Switched to Dark Theme"
            else if [ "$mode" = "light" ]
              osascript -l JavaScript -e "Application('System Events').appearancePreferences.darkMode = false" > /dev/null
              if count $nvims >/dev/null
                for i in (ls $nvims)
                  nvim --server $i --remote-send '<ESC>:LightTheme<CR>'
                end
              end
              echo "Switched to Light Theme"
            else
              if [ (os_theme) = "dark" ]
                switch_theme "light"
              else
                switch_theme "dark"
              end
            end
          '';
      };
    };
  };
}
