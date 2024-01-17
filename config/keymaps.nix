{ ... }:
let
  mkKeymap = mode: key: action: {
    inherit mode key action;
    options = {
      silent = true;
    };
  };

  mkNormap = key: action: (mkKeymap "n" key action);
  mkInsmap = key: action: (mkKeymap "i" key action);
in
{
  config = {
    keymaps = [
      (mkNormap "Y" "yg$")
      (mkNormap "J" "mzJ`z")
      (mkNormap "<C-d>" "<C-d>zz")
      (mkNormap "<C-u>" "<C-u>zz")
      (mkNormap "n" "nzzzv")
      (mkNormap "N" "Nzzzv")

      (mkNormap "<leader>b]" "<cmd>bn<cr>")
      (mkNormap "<leader>b[" "<cmd>bp<cr>")
      (mkNormap "<leader>bd" "<cmd>bd<cr>")

      (mkKeymap "x" "<leader>p" "\"_dP")

      (mkKeymap [ "n" "v" ] "<leader>y" "\"+y")
      (mkNormap "<leader>Y" "\"+Y")

      (mkKeymap [ "n" "v" ] "<leader>d" "\"_d")

      (mkInsmap "<C-c>" "<Esc>")

      (mkNormap "Q" "<Nop>")

      (mkNormap "<C-k>" "<cmd>cnext<CR>zz")
      (mkNormap "<C-j>" "<cmd>cprev<CR>zz")
      (mkNormap "<leader>j" "<cmd>lnext<CR>zz")
      (mkNormap "<leader>k" "<cmd>lprev<CR>zz")

      (mkNormap "<leader>pv" ":Neotree toggle<CR>")

      (mkNormap "<leader>F" ":lua require('conform').format {}<CR>")
    ];
  };
}
