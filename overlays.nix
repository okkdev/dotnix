self: super: {
  gleam = super.stdenvNoCC.mkDerivation rec {
    name = "gleam";
    version = "v1.14.0";
    # version = "nightly";
    src = super.fetchurl (
      if super.stdenv.isDarwin then
        {
          url = "https://github.com/gleam-lang/gleam/releases/download/${version}/gleam-${version}-aarch64-apple-darwin.tar.gz";
          sha256 = "sha256-I5jRoTCxu0Br20pcLOotyYZ8Z3z0iz1sResgCmU9uzY=";
        }
      else
        {
          url = "https://github.com/gleam-lang/gleam/releases/download/${version}/gleam-${version}-x86_64-unknown-linux-musl.tar.gz";
          sha256 = "sha256-XcZqu/PrgPIJ8cJh7PxE3BQE3YrFA+SDNp03GCpPzOg=";
        }
    );
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      tar -xvf $src -C $out/bin
      chmod +x $out/bin/gleam
    '';
  };

  expert-lsp = super.stdenvNoCC.mkDerivation rec {
    name = "expert-lsp";
    version = "nightly";
    src = super.fetchurl (
      if super.stdenv.isDarwin then
        {
          url = "https://github.com/elixir-lang/expert/releases/download/${version}/expert_darwin_arm64";
          sha256 = "sha256-Tq31CjLZOgg7r6MXrqxqIf5HDDGb/4pSB2BPkxx5zSI=";
        }
      else
        {
          url = "https://github.com/elixir-lang/expert/releases/download/${version}/expert_linux_amd64";
          sha256 = "sha256-OLYyQEqp2jhb7XCDTl2QqZtKJIWgcPIYYZtdq6QMoPA=";
        }
    );
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/expert
      chmod +x $out/bin/expert
    '';
  };

  claude-code-wrapped = super.writeShellApplication {
    name = "claude";

    runtimeInputs = with super; [
      claude-code
      bubblewrap
      git
    ];

    text = ''
      mkdir -p "$HOME/.claude"
      touch "$HOME/.claude.json"

      HIDE_BINDS=""
      if git rev-parse --git-dir > /dev/null 2>&1; then
        while IFS= read -r file; do
          [[ "$file" =~ ^\.claude(/|$) ]] && continue
          [[ -d "$PWD/$file" ]] && HIDE_BINDS+="--tmpfs $PWD/$file "
          [[ -f "$PWD/$file" ]] && HIDE_BINDS+="--ro-bind /dev/null $PWD/$file "
        done < <(git ls-files --ignored --exclude-standard --others --directory)
      fi

      # shellcheck disable=SC2086
      bwrap \
        --ro-bind /usr /usr \
        --ro-bind /bin /bin \
        --ro-bind-try /lib /lib \
        --ro-bind-try /lib64 /lib64 \
        --ro-bind-try /nix /nix \
        --ro-bind-try /etc/profiles /etc/profiles \
        --ro-bind-try /etc/static/profiles /etc/static/profiles \
        --ro-bind /etc/resolv.conf /etc/resolv.conf \
        --ro-bind /etc/hosts /etc/hosts \
        --ro-bind /etc/passwd /etc/passwd \
        --ro-bind /etc/group /etc/group \
        --ro-bind ${super.cacert}/etc/ssl/certs/ca-bundle.crt /etc/ssl/certs/ca-bundle.crt \
        --symlink /etc/ssl/certs/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt \
        --bind "$PWD" "$PWD" \
        --bind "$HOME/.claude" "$HOME/.claude" \
        --bind "$HOME/.claude.json" "$HOME/.claude.json" \
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
        $HIDE_BINDS \
        claude "$@"
    '';
  };

  # Vim Plugins
  vimPlugins = super.vimPlugins // rec {
    bg-nvim = super.vimUtils.buildVimPlugin {
      pname = "bg-nvim";
      version = "2025-05-18";
      src = super.fetchFromGitHub {
        owner = "typicode";
        repo = "bg.nvim";
        rev = "df916e4df2493ee302eea62185ed014ba7ca40d9";
        sha256 = "sha256-H+ZFX0hE9te6qo+fzUuWngHOEf0zGyHkEIQIYvyTzTI=";
      };
    };
    vclib-nvim = super.vimUtils.buildVimPlugin {
      pname = "vclib-nvim";
      version = "2025-09-19";
      src = super.fetchFromGitHub {
        owner = "algmyr";
        repo = "vclib.nvim";
        rev = "429bc13051b604c5f750913c57c0a07b11ddf94d";
        sha256 = "sha256-0Vhd+zyrDnXhM0q0HAbQWjlG7TP9RHIoOJP6FBedJCE=";
      };
    };
    vcmarkers-nvim = super.vimUtils.buildVimPlugin {
      dependencies = [ vclib-nvim ];
      pname = "vcmarkers-nvim";
      version = "2025-09-19";
      src = super.fetchFromGitHub {
        owner = "algmyr";
        repo = "vcmarkers.nvim";
        rev = "f5e540ac078fd0f7b2e08c3a3cc565bdb262f531";
        sha256 = "sha256-K8Vb+lErFJzYYQo9xJk/yGCLljn/r9wcILmLlWhmhm0=";
      };
    };
    everforest-nvim = super.vimUtils.buildVimPlugin {
      pname = "everforest-nvim";
      version = "2025-05-18";
      src = super.fetchFromGitHub {
        owner = "neanias";
        repo = "everforest-nvim";
        rev = "2eb7c348f880ba93de4d98cae049c9441f5d4d49";
        sha256 = "sha256-LMIGPDhKZVqriGuPR9ICVo55QdyByLXOoRK82KfsRxU=";
      };
    };
    uiua-vim = super.vimUtils.buildVimPlugin {
      pname = "uiua-vim";
      version = "2024-11-04";
      src = super.fetchFromGitHub {
        owner = "Apeiros-46B";
        repo = "uiua.vim";
        rev = "7088832aa53258a30ec50639193af8510f621f69";
        sha256 = "sha256-UERcpf+3kKKgJjWT6FSWu4BJOcKYOSzwqArJVWlocIE=";
      };
    };
    d2-vim = super.vimUtils.buildVimPlugin {
      pname = "d2-vim";
      version = "2025-03-27";
      src = super.fetchFromGitHub {
        owner = "terrastruct";
        repo = "d2-vim";
        rev = "981c87dccb63df2887cc41b96e84bf550f736c57";
        sha256 = "sha256-+mT4pEbtq7f9ZXhOop3Jnjr7ulxU32VtahffIwQqYF4=";
      };
    };
  };
}
