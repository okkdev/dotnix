self: super: {
  vimPlugins = super.vimPlugins // {
    tangerine-nvim = super.vimUtils.buildVimPlugin rec {
      pname = "tangerine-nvim";
      version = "v2.8";
      src = super.fetchFromGitHub {
        owner = "udayvir-singh";
        repo = "tangerine.nvim";
        rev = version;
        sha256 = "sha256-gviY9oltZiOWJR9vWSIgWGd7uVvfcTPNUScmaWjVCm8=";
      };
    };
    tailwindcss-colorizer-cmp = super.vimUtils.buildVimPlugin {
      pname = "tailwindcss-colorizer-cmp";
      version = "main";
      src = super.fetchFromGitHub {
        owner = "roobert";
        repo = "tailwindcss-colorizer-cmp.nvim";
        rev = "bc25c56083939f274edcfe395c6ff7de23b67c50";
        sha256 = "sha256-4wt4J6pENX7QRG7N1GzE9L6pM5E88tnHbv4NQa5JqSI=";
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
      version = "v4.2.0";
      src = super.fetchFromGitHub {
        owner = "mikesmithgh";
        repo = "kitty-scrollback.nvim";
        rev = version;
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
  };
}
