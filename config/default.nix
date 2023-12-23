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
  imports = [ ./keymaps.nix ./ui ./lsp ./misc ./telescope ./snippets ];

  config = {
    colorschemes.oxocarbon.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      vim-just
      friendly-snippets
    ];

    plugins = {
      treesitter = {
        enable = true;
        indent = true;
        folding = true;
      };

      treesitter-context.enable = true;
    };

    globals.mapleader = " ";
    options = {
      # numbering
      number = true;
      relativenumber = true;

      # indentation
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smartindent = true;

      # swap, backup, undo
      swapfile = false;
      backup = false;
      undofile = false;

      # search
      incsearch = true;
      hlsearch = true;

      # code folding
      foldcolumn = "0";
      foldlevel = 99;
      foldlevelstart = 99;
      foldenable = true;

      # misc
      wrap = false;
      termguicolors = true;
      scrolloff = 8;
      colorcolumn = "80";
      cursorline = true;
      completeopt = "menu,menuone,noselect";
    };
  };
}
