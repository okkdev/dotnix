{ inputs, pkgs, ... }:
let
  # not in nixpkgs
  semble = pkgs.writeShellScriptBin "semble" ''
    exec ${pkgs.uv}/bin/uvx semble@0.7.3 "$@"
  '';

  ast-grep-mcp = pkgs.writeShellApplication {
    name = "ast-grep-mcp";
    runtimeInputs = with pkgs; [
      ast-grep
      jq
    ];
    text = "exec ${pkgs.runtimeShell} ${./ast-grep-mcp.sh}";
  };

  maki-claude = pkgs.fetchFromGitHub {
    owner = "bzzimmy";
    repo = "maki-claude";
    rev = "679fd1b9cdb608f1f99c82733ce0504a62b80e7d"; # 2026-11-18
    hash = "sha256-u1nYEzg/r8hlqFwhLzTDO/iRVJl45EfxkN8I6DslimQ=";
  };

  maki = inputs.maki.packages.${pkgs.stdenv.hostPlatform.system}.default;

  maki-wrapped = pkgs.writeShellApplication {
    name = "maki";

    runtimeInputs = [
      maki
      pkgs.bubblewrap
      pkgs.git
      pkgs.openssl # maki-claude login
    ];

    text = ''
      RO_PATHS=(
        /usr
        /bin
        /lib
        /lib64
        /nix
        /etc/nix
        /etc/profiles
        /etc/static/profiles
        /run/current-system
        /etc/resolv.conf
        /etc/hosts
        /etc/passwd
        /etc/group
        /etc/ssl/certs/ca-bundle.crt
        /etc/ssl/certs/ca-certificates.crt
        /etc/localtime
        "$HOME/.config/git"
        "$HOME/.config/jj"
        "$HOME/.rustup"
        "$HOME/.cargo"
        "$HOME/.mix"
      )

      RO_BINDS=()
      for path in "''${RO_PATHS[@]}"; do
        RO_BINDS+=(--ro-bind-try "$path" "$path")
      done

      # maki state + uv/huggingface caches for semble
      RW_DIRS=(
        "$HOME/.config/maki"
        "$HOME/.local/state/maki"
        "$HOME/.local/share/maki"
        "$HOME/.local/logs/maki"
        "$HOME/.cache/maki"
        "$HOME/.cache/uv"
        "$HOME/.local/share/uv"
        "$HOME/.cache/huggingface"
      )

      RW_BINDS=()
      for dir in "''${RW_DIRS[@]}"; do
        mkdir -p "$dir"
        RW_BINDS+=(--bind "$dir" "$dir")
      done

      HIDE_BINDS=()
      if git rev-parse --git-dir > /dev/null 2>&1; then
        while IFS= read -r file; do
          [[ "$file" =~ ^\.maki(/|$) ]] && continue
          [[ "$file" =~ (^|/)(AGENTS(\.local)?|CLAUDE)\.md$ ]] && continue
          [[ "$file" =~ (^|/)(node_modules|vendor|build|target|\.venv|\.jj)(/|$) ]] && continue
          if [[ -L "$file" ]]; then
            continue
          elif [[ -d "$file" ]]; then
            HIDE_BINDS+=(--tmpfs "$PWD/$file")
          elif [[ -f "$file" ]]; then
            HIDE_BINDS+=(--ro-bind /dev/null "$PWD/$file")
          fi
        done < <(git ls-files --ignored --exclude-standard --others --directory)
      fi

      exec bwrap \
        "''${RO_BINDS[@]}" \
        --bind "$PWD" "$PWD" \
        "''${RW_BINDS[@]}" \
        --setenv HOME "$HOME" \
        --setenv USER "$USER" \
        --setenv PATH "$PATH" \
        --setenv SSL_CERT_FILE /etc/ssl/certs/ca-bundle.crt \
        --tmpfs /tmp \
        --proc /proc \
        --dev /dev \
        --share-net \
        --unshare-pid \
        --die-with-parent \
        --chdir "$PWD" \
        "''${HIDE_BINDS[@]}" \
        maki "$@"
    '';
  };
in
{
  home.packages = [
    (if pkgs.stdenv.hostPlatform.isDarwin then maki else maki-wrapped)
    semble
  ];

  xdg.configFile = {
    "maki" = {
      source = ./config;
      recursive = true;
    };

    # read-only: /mcp toggles won't persist
    "maki/mcp.toml".text = ''
      [mcp.ast-grep]
      command = ["${ast-grep-mcp}/bin/ast-grep-mcp"]
    '';
  };

  # Packages
  xdg.dataFile."maki/site/pack/nix/start/maki-claude".source = maki-claude;
}
