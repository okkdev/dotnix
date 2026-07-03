self: super: {
  gleam = super.stdenvNoCC.mkDerivation rec {
    name = "gleam";
    version = "v1.15.2";
    # version = "nightly";
    src = super.fetchurl (
      if super.stdenv.isDarwin then
        {
          url = "https://github.com/gleam-lang/gleam/releases/download/${version}/gleam-${version}-aarch64-apple-darwin.tar.gz";
          sha256 = "sha256-ib8VVmCL/9DgL9dBw3FuasIO+1ohRjGFPic/L66kTZQ=";
        }
      else
        {
          url = "https://github.com/gleam-lang/gleam/releases/download/${version}/gleam-${version}-x86_64-unknown-linux-musl.tar.gz";
          sha256 = "sha256-uc+CAZgfWMEi/E+VPYXyeOftqib6oPOFMpnKv+G3ydw=";
        }
    );
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      tar -xvf $src -C $out/bin
      chmod +x $out/bin/gleam
    '';
  };

  # Node 24 detects `import.meta.url` in the bundled CommonJS servers and loads
  # them as ES modules, which breaks every `require` call. Rewrite it to a
  # CJS-safe equivalent so the servers start again.
  vscode-langservers-extracted = super.vscode-langservers-extracted.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      find "$out" -name '*ServerMain.js' -exec \
        sed -i 's#import\.meta\.url#require("url").pathToFileURL(__filename).href#g' {} +
    '';
  });

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
    mdx-nvim = super.vimUtils.buildVimPlugin {
      pname = "mdx-nvim";
      version = "2026-03-30";
      src = super.fetchFromGitHub {
        owner = "davidmh";
        repo = "mdx.nvim";
        rev = "c2644328587bbd58eede41b2cd0c1ccc99175661";
        sha256 = "sha256-1yFasKL2UKRd/j9nn8mjiFZOs9sR2GKomoCejtL1XIs=";
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
