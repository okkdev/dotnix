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
  gleam = super.stdenv.mkDerivation rec {
    name = "gleam";
    version = "1.4.1";
    src = super.fetchurl {
      url = "https://github.com/gleam-lang/gleam/releases/download/v${version}/gleam-v${version}-aarch64-apple-darwin.tar.gz";
      sha256 = "sha256-z1svlWBWA41aI9bxe7WrF/+rRg8Hov6wL50wfjiPdVc=";
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
      version = "2024-01-18";
      src = super.fetchFromGitHub {
        owner = "js-everts";
        repo = "cmp-tailwind-colors";
        rev = "8ad13923316e2b5ca00420c171268fc23f32c01d";
        sha256 = "sha256-JdMrbHG5hgrY8HMRkGMXyc7ZFKQi7bSEv4ZPVMlVR24=";
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
      version = "4.2.0";
      src = super.fetchFromGitHub {
        owner = "mikesmithgh";
        repo = "kitty-scrollback.nvim";
        rev = "v${version}";
        sha256 = "sha256-pMdvavw+t/xiJ6SRPflG+1s1N6HkHJiqktM+eNsCjUQ=";
      };
    };
    everforest-nvim = super.vimUtils.buildVimPlugin {
      pname = "everforest-nvim";
      version = "2024-05-20";
      src = super.fetchFromGitHub {
        owner = "neanias";
        repo = "everforest-nvim";
        rev = "ed4ba26c911696d69cfda26014ec740861d324e1";
        sha256 = "sha256-kVn6rUc26PtoqzKW/MNuks85sTLYx1lEE/l+7W0bDfg=";
      };
    };
  };
}
