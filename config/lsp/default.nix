{ ... }:
{
  imports = [ ./nvim-cmp.nix ];

  config = {
    plugins = {
      lsp = {
        enable = true;
        keymaps = {
          silent = true;

          diagnostic = {
            "<leader>do" = "open_float";
            "[d" = "goto_prev";
            "]d" = "goto_next";
          };

          lspBuf = {
            "gd" = "definition";
            "gt" = "type_definition";
            "K" = "hover";
            "<leader>ca" = "code_action";
            "<leader>rn" = "rename";
          };
        };

        servers = {
          astro.enable = true;
          bashls.enable = true;
          cssls.enable = true;
          dockerls.enable = true;
          gopls.enable = true;
          html.enable = true;
          jsonls.enable = true;
          lua-ls.enable = true;
          nixd.enable = true;

          pylsp = {
            enable = false;
            settings.plugins = {
              flake8.enabled = false;
              pycodestyle.enabled = false;
              pylsp_mypy.report_progress = true;
              isort.enabled = true;
              black.enabled = true;
              ruff.enabled = false;
            };
          };
          pyright.enable = true;

          terraformls.enable = true;
          tsserver.enable = true;
          yamlls.enable = true;
        };
      };

      fidget.enable = true;
      rust-tools.enable = true;

      conform-nvim = {
        enable = true;
        formattersByFt = {
          lua = [ "stylua" ];
          python = [ "isort" "black" ];
          javascript = [ "prettierd" ];
          nix = [ "nixpkgs_fmt" ];
          tf = [ "terraform_fmt" ];
          "_" = [ "trim_whitespace" ];
        };
      };
    };
  };
}
