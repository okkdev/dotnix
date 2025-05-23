self: super: {
  gleam = super.stdenv.mkDerivation rec {
    name = "gleam";
    version = "1.10.0";
    src = super.fetchurl {
      url = "https://github.com/gleam-lang/gleam/releases/download/v${version}/gleam-v${version}-aarch64-apple-darwin.tar.gz";
      sha256 = "sha256-kNhxdQXxS5JYeUMuF3cIVQpd0pyaYg4IXyHwrXU8wZo=";
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
    # remove once >0.3.0 is released
    nui-nvim = super.vimUtils.buildVimPlugin {
      pname = "nui-nvim";
      version = "2025-04-01";
      src = super.fetchFromGitHub {
        owner = "MunifTanjim";
        repo = "nui.nvim";
        rev = "8d3bce9764e627b62b07424e0df77f680d47ffdb";
        sha256 = "sha256-BYTY2ezYuxsneAl/yQbwL1aQvVWKSsN3IVqzTlrBSEU=";
      };
    };
  };
}
