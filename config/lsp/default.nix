{ ... }:
{
  imports = [ ./cmp.nix ./dap.nix ./formatter.nix ];

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
        denols = {
          enable = true;
          rootDir = "require('lspconfig').util.root_pattern('deno.json', 'deno.jsonc')";
        };
        dockerls.enable = true;
        gopls.enable = true;
        html.enable = true;
        jsonls.enable = true;
        jsonnet_ls.enable = true;
        lua_ls.enable = true;
        nixd.enable = true;
        nickel_ls.enable = true;
        pyright = {
          enable = true;
          settings = {
            pyright.disableOrganizeImports = true;
          };
        };
        ruff.enable = true;
        terraformls.enable = true;
        ts_ls = {
          enable = true;
          rootDir = "require('lspconfig').util.root_pattern('package.json')";
          extraOptions.single_file_support = false;
        };
        volar.enable = true;
        yamlls.enable = true;
        zls.enable = true;
      };
    };

    fidget.enable = true;

    rustaceanvim = {
      enable = true;
      settings.tools.enable_clippy = true;
    };
  };

  autoGroups.lsp_attach_disable_ruff_hover.clear = true;
  autoCmd = [
    {
      event = "LspAttach";
      group = "lsp_attach_disable_ruff_hover";
      callback.__raw = ''
        function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil then
            return
          end
          if client.name == 'ruff' then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
        end
      '';
      desc = "LSP: Disable hover capability from Ruff";
    }
  ];
}
