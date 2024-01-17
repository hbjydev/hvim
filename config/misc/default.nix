{ pkgs, ... }:
let
  inherit (pkgs) vimPlugins;
  inherit (vimPlugins) friendly-snippets nvim-colorizer-lua vim-just;
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
