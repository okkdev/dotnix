self: super: {
  elp = super.stdenv.mkDerivation rec {
    name = "elp";
    version = "2024-08-05";
    src = super.fetchurl {
      url = "https://github.com/WhatsApp/erlang-language-platform/releases/download/${version}/elp-macos-x86_64-apple-darwin-otp-26.2.tar.gz";
      sha256 = "sha256-mLh+aiW5WHuUCHuV0uPLemddnA25YpSRMLq8TdBTKJY=";
    };
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      tar -xvf $src -C $out/bin
      chmod +x $out/bin/elp
    '';
  };
  superhtml = super.stdenv.mkDerivation rec {
    name = "superhtml";
    version = "0.5.0";
    src = super.fetchurl {
      url = "https://github.com/kristoff-it/superhtml/releases/download/v${version}/aarch64-macos.tar.gz";
      sha256 = "sha256-w/iZ0UxsaY4PUU889Mf9MBkuofKdLilWfARRMnZEO8I=";
    };
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      tar -xvf $src
      mv aarch64-macos/superhtml $out/bin
      chmod +x $out/bin/superhtml
    '';
  };
  gleam = super.stdenv.mkDerivation rec {
    name = "gleam";
    version = "1.9.0-rc1";
    src = super.fetchurl {
      url = "https://github.com/gleam-lang/gleam/releases/download/v${version}/gleam-v${version}-aarch64-apple-darwin.tar.gz";
      sha256 = "sha256-oOevWHmv0y7kANsaFED9J58/gMV6Y1791ny4ToU/2WE=";
    };
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      tar -xvf $src -C $out/bin
      chmod +x $out/bin/gleam
    '';
  };

  # Vim Plugins
  vimPlugins = super.vimPlugins // {
    bg-nvim = super.vimUtils.buildVimPlugin {
      pname = "bg-nvim";
      version = "2024-05-10";
      src = super.fetchFromGitHub {
        owner = "typicode";
        repo = "bg.nvim";
        rev = "fe5d5c598c9f621dac315013f53108a307d8f03f";
        sha256 = "sha256-rjli3YfUTGVdTZF66kpcutj46IeXsSI9eKWNXEaqST4=";
      };
    };
    telescope-recent-files-nvim = super.vimUtils.buildVimPlugin {
      pname = "telescope-recent-files-nvim";
      version = "2024-08-14";
      src = super.fetchFromGitHub {
        owner = "mollerhoj";
        repo = "telescope-recent-files.nvim";
        rev = "23b29aa701cd07c723282b3094e1a4dfc231f557";
        sha256 = "sha256-nLy1WciLIjIqrD1az6JEXcx5EvaZSn8gBQ6HzQIhAp0=";
      };
    };
    kitty-scrollback-nvim = super.vimUtils.buildVimPlugin rec {
      pname = "kitty-scrollback-nvim";
      version = "5.0.1";
      src = super.fetchFromGitHub {
        owner = "mikesmithgh";
        repo = "kitty-scrollback.nvim";
        rev = "v${version}";
        sha256 = "sha256-6aU9lXfRtxJA/MYkaJ4iRQYAnpBBSGI1R6Ny048aJx8=";
      };
    };
    everforest-nvim = super.vimUtils.buildVimPlugin {
      pname = "everforest-nvim";
      version = "2024-11-04";
      src = super.fetchFromGitHub {
        owner = "neanias";
        repo = "everforest-nvim";
        rev = "7c57941d5ef5a150f307b9295c00a59e95d78587";
        sha256 = "sha256-qmRec0yFR+/nRsu+j/E7nrk70DIDN6EI2sCW6vjeyeo=";
      };
    };
    uiua-vim = super.vimUtils.buildVimPlugin {
      pname = "uiua-vim";
      version = "2024-11-04";
      src = super.fetchFromGitHub {
        owner = "Apeiros-46B";
        repo = "uiua.vim";
        rev = "0afe909cb98553e5aec886f5e13a0637dcb671bd";
        sha256 = "sha256-lmVcJgHj6y1emH2W5xrRvkQroed+fiws3o+KLVxQ24M=";
      };
    };

  };
}
