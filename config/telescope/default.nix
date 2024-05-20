{ ... }:
{
  plugins = {
    telescope = {
      enable = true;
      keymaps = {
        "<leader>pf" = "find_files";
        "<leader>ps" = "live_grep";
        "<leader>pg" = "git_files";
        "<C-p>" = "git_files";
        "<leader><space>" = "buffers";
        "<leader>ds" = "lsp_document_symbols";
        "<leader>rr" = "lsp_references";
      };

      settings.defaults = {
        prompt_prefix = "   ";
        selection_caret = "  ";
        entry_prefix = "  ";
        sorting_strategy = "ascending";

        layout_strategy = "flex";
        layout_config = {
          horizontal = {
            prompt_position = "top";
            preview_width = 0.55;
          };
          vertical.mirror = false;
          width = 0.87;
          height = 0.8;
          preview_cutoff = 120;
        };

        dynamic_preview_title = true;

        set_env = {
          COLORTERM = "truecolor";
        };

        file_ignore_patterns = [
          "node_modules"
          ".direnv"
          "venv"
          "vendor"
        ];
      };
    };
  };
}
