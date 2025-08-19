self: super: {
  gleam = super.stdenv.mkDerivation rec {
    name = "gleam";
    version = "v1.12.0";
    # version = "nightly";
    src = super.fetchurl {
      url = "https://github.com/gleam-lang/gleam/releases/download/${version}/gleam-${version}-aarch64-apple-darwin.tar.gz";
      sha256 = "sha256-iFOW6EX7vAFCU92V2kk0ObeFZBAi+5LEVleyuTbPMX8=";
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
      version = "2025-05-18";
      src = super.fetchFromGitHub {
        owner = "typicode";
        repo = "bg.nvim";
        rev = "df916e4df2493ee302eea62185ed014ba7ca40d9";
        sha256 = "sha256-H+ZFX0hE9te6qo+fzUuWngHOEf0zGyHkEIQIYvyTzTI=";
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
  };
}
