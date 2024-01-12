{ pkgs, ... }:
let
  inherit (pkgs) vimPlugins;
  inherit (vimPlugins) friendly-snippets nvim-colorizer-lua;

  vim-just = pkgs.vimUtils.buildVimPlugin {
    name = "vim-just";
    src = pkgs.fetchFromGitHub {
      owner = "NoahTheDuke";
      repo = "vim-just";
      rev = "927b41825b9cd07a40fc15b4c68635c4b36fa923";
      sha256 = "sha256-BmxYWUVBzTowH68eWNrQKV1fNN9d1hRuCnXqbEagRoY=";
    };
  };
in
{
  imports = [ ./copilot.nix ];

  config = {
    extraPlugins = [
      vim-just
      friendly-snippets
      nvim-colorizer-lua
    ];

    extraConfigLua = ''
      require("colorizer").setup {}
    '';

    plugins = {
      nix.enable = true;

      treesitter = {
        enable = true;
        indent = true;
        folding = true;
      };

      treesitter-context.enable = true;

      gitsigns = {
        enable = true;

        signs = {
          changedelete.text = "│";
        };
      };

      diffview.enable = true;

      comment-nvim.enable = true;
    };
  };
}
