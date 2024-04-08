self: super: {
  next-ls = super.stdenv.mkDerivation rec {
    name = "next-ls-v${version}";
    version = "0.20.2";
    src = super.fetchurl {
      url =
        "https://github.com/elixir-tools/next-ls/releases/download/v${version}/next_ls_darwin_arm64";
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
      url =
        "https://github.com/lexical-lsp/lexical/releases/download/v${version}/lexical.zip";
      sha256 = "sha256-quOOkijw5byJKJAZ8Uq/HNjWeFsT04gvm+hDxncN3/k=";
    };
    buildInputs = [ super.unzip ];
    phases = [ "installPhase" ];
    installPhase = let
      activate_version_manager =
        super.writeScript "activate_version_manager.sh" ''
          true
        '';
    in ''
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
  vimPlugins = super.vimPlugins // {
    cmp-tailwind-colors = super.vimUtils.buildVimPlugin {
      pname = "cmp-tailwind-colors";
      version = "main";
      src = super.fetchFromGitHub {
        owner = "js-everts";
        repo = "cmp-tailwind-colors";
        rev = "8ad13923316e2b5ca00420c171268fc23f32c01d";
        sha256 = "sha256-JdMrbHG5hgrY8HMRkGMXyc7ZFKQi7bSEv4ZPVMlVR24=";
      };
    };
    bg-nvim = super.vimUtils.buildVimPlugin {
      pname = "bg-nvim";
      version = "main";
      src = super.fetchFromGitHub {
        owner = "typicode";
        repo = "bg.nvim";
        rev = "1c95261cc5e3062e3b277fc5c15d180d51a40f62";
        sha256 = "sha256-ZocdEdw7m6gVQap0MFr1uymIkHnX9ewjWmR7fYVR9Ko=";
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
    profile-nvim = super.vimUtils.buildVimPlugin {
      pname = "profile-nvim";
      version = "main";
      src = super.fetchFromGitHub {
        owner = "stevearc";
        repo = "profile.nvim";
        rev = "3c5aaf2f8b2e4c2bc48d2cde396a55892e0267ad";
        sha256 = "sha256-0HnzEq2IEVLMtkHJZ8NXLimJJ8DAL8gtpyWvsUDG1ao=";
      };
    };
    everforest-nvim = super.vimUtils.buildVimPlugin {
      pname = "everforest-nvim";
      version = "main";
      src = super.fetchFromGitHub {
        owner = "neanias";
        repo = "everforest-nvim";
        rev = "eedb19079c6bf9d162f74a5c48a6d2759f38cc76";
        sha256 = "sha256-/k6VBzXuap8FTqMij7EQCh32TWaDPR9vAvEHw20fMCo=";
      };
    };
  };
}
