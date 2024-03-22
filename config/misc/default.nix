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

      vim.api.nvim_create_user_command("Format", function(args)
        require("conform").format({ async = true, lsp_fallback = true })
      end, {})
    '';

    plugins = {
      direnv.enable = true;

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

        onAttach.function = ''
          function(bufnr)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'hs', '<cmd>Gitsigns stage_hunk<CR>', {})
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'hr', '<cmd>Gitsigns reset_hunk<CR>', {})
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'hS', '<cmd>Gitsigns stage_buffer<CR>', {})
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'hR', '<cmd>Gitsigns reset_buffer<CR>', {})
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'hd', '<cmd>Gitsigns diffthis<CR>', {})
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>]h', '<cmd>Gitsigns next_hunk<CR>', {})
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>[h', '<cmd>Gitsigns prev_hunk<CR>', {})
          end
        '';
      };

      diffview.enable = true;

      comment-nvim.enable = true;
      todo-comments.enable = true;
    };
  };
}
