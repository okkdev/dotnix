self: super: {
  next-ls = super.stdenv.mkDerivation rec {
    name = "next-ls-v${version}";
    version = "0.20.2";
    src = super.fetchurl {
      url = "https://github.com/elixir-tools/next-ls/releases/download/v${version}/next_ls_darwin_arm64";
      sha256 = "sha256-0HS/CMSj4bkvvvC1BNhvEu3W+OEW5FnguoQZ2bwrtkw=";
    };
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/next-ls
      chmod +x $out/bin/next-ls
    '';
  };
  lexical-lsp = super.stdenv.mkDerivation rec {
    name = "lexical-v${version}";
    version = "0.5.2";
    src = super.fetchurl {
      url = "https://github.com/lexical-lsp/lexical/releases/download/v${version}/lexical.zip";
      sha256 = "sha256-quOOkijw5byJKJAZ8Uq/HNjWeFsT04gvm+hDxncN3/k=";
    };
    buildInputs = [ super.unzip ];
    phases = [ "installPhase" ];
    installPhase =
      let
        activate_version_manager = super.writeScript "activate_version_manager.sh" ''
          true
        '';
      in
      ''
        mkdir -p $out/bin
        mkdir lexical
        unzip $src
        mv lexical/* $out
        rm "$out/bin/activate_version_manager.sh"
        ln -s ${activate_version_manager} "$out/bin/activate_version_manager.sh"
        chmod +x $out/bin/start_lexical.sh
        ln -s $out/bin/start_lexical.sh $out/bin/lexical
      '';
  };
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
    version = "1.6.1";
    src = super.fetchurl {
      url = "https://github.com/gleam-lang/gleam/releases/download/v${version}/gleam-v${version}-aarch64-apple-darwin.tar.gz";
      sha256 = "sha256-urJHumU+KsVJ4MeWWq3fkC7pVRCR71yLI0VA0H9Pi5s=";
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
    cmp-tailwind-colors = super.vimUtils.buildVimPlugin {
      pname = "cmp-tailwind-colors";
      version = "2024-11-04";
      src = super.fetchFromGitHub {
        owner = "js-everts";
        repo = "cmp-tailwind-colors";
        rev = "91b2621827ef19a374ad7d1e60d567dd2e4b3823";
        sha256 = "sha256-QBAvPtlfLJK+HWM390nQuJVvOEutNcLawaA/cW4tCyU=";
      };
    };
    # cmp-ai = super.vimUtils.buildVimPlugin {
    #   pname = "cmp-ai";
    #   version = "2024-05-30";
    #   src = super.fetchFromGitHub {
    #     owner = "tzachar";
    #     repo = "cmp-ai";
    #     rev = "b6c3fb81910fd0cef539c90db626f84581c06d26";
    #     sha256 = "sha256-1IGqxVOneRt20SiXOYu4aErg1UxjMaH1NTuuTyuGXLQ=";
    #   };
    # };
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
