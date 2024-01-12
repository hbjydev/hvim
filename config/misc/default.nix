{ pkgs, ... }:
let
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
    extraPlugins = with pkgs.vimPlugins; [
      vim-just
      friendly-snippets
    ];

    plugins = {
      nix.enable = true;

      treesitter = {
        enable = true;
        indent = true;
        folding = true;
      };

      treesitter-context.enable = true;

      gitsigns.enable = true;
      diffview.enable = true;

      comment-nvim.enable = true;
    };
  };
}
