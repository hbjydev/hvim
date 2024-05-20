{ ... }:
{
  config = {
    globals.mapleader = " ";

    opts = {
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
      background = "dark";
    };
  };
}
