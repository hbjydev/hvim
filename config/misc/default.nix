{ pkgs, ... }:
let
  inherit (pkgs) vimPlugins;
  inherit (vimPlugins) friendly-snippets nvim-colorizer-lua vim-just vim-nickel;
in
{
  imports = [ ./copilot.nix ];

  extraPlugins = [
    vim-just
    vim-nickel
    friendly-snippets
    nvim-colorizer-lua
  ];

  extraConfigLua = ''
    require("colorizer").setup {}
  '';

  plugins = {
    direnv.enable = true;
    diffview.enable = true;
    nix.enable = true;
    comment.enable = true;
    todo-comments.enable = true;
    web-devicons.enable = true;

    treesitter = {
      enable = true;
      folding = true;
      settings = {
        indent.enable = true;
        highlight.enable = true;
      };
    };
    treesitter-context.enable = true;

    gitsigns = {
      enable = true;

      settings = {
        signs = {
          changedelete.text = "│";
        };

        onAttach.function = ''
          function(bufnr)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cs', '<cmd>Gitsigns stage_hunk<CR>', {})
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cr', '<cmd>Gitsigns reset_hunk<CR>', {})
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cS', '<cmd>Gitsigns stage_buffer<CR>', {})
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cR', '<cmd>Gitsigns reset_buffer<CR>', {})
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cd', '<cmd>Gitsigns diffthis<CR>', {})
            vim.api.nvim_buf_set_keymap(bufnr, 'n', ']c', '<cmd>Gitsigns next_hunk<CR>', {})
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '[c', '<cmd>Gitsigns prev_hunk<CR>', {})
          end
        '';
      };
    };
  };
}
