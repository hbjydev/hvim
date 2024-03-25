{ ... }:
{
  config = {
    extraConfigLuaPre = ''
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
    '';

    plugins = {
      cmp = {
        enable = true;
        autoEnableSources = true;

        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";

          sources = [
            { name = "nvim_lsp"; }
            { name = "nvim_lsp_document_symbol"; }
            { name = "nvim_lsp_signature_help"; }
            { name = "luasnip"; }
            { name = "path"; }
          ];

          window = {
            documentation.maxHeight = "math.floor(40 * (40 / vim.o.lines))";
            completion = {
              colOffset = -3;
              sidePadding = 0;
            };
          };

          mapping = {
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-n>" = "cmp.mapping.select_next_item()";

            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";

            "<C-Space>" = "cmp.mapping.complete({})";
            "<C-e>" = "cmp.mapping.close()";

            "<C-y>" = "cmp.mapping.confirm()";

            "<Tab>" = ''
              cmp.mapping(
                function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif require("luasnip").expand_or_locally_jumpable() then
                    require("luasnip").expand_or_jump()
                  elseif has_words_before() then
                    cmp.complete()
                  else
                    fallback()
                  end
                end,
                { 'i', 's' }
              )
            '';

            "<S-Tab>" = ''
              cmp.mapping(
                function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif require("luasnip").jumpable(-1) then
                    require("luasnip").jump(-1)
                  else
                    fallback()
                  end
                end,
                { 'i', 's' }
              )
            '';
          };

          formatting = {
            fields = [ "kind" "abbr" "menu" ];
            format = ''
              function(_, vim_item)
                local icons = {
                  Text = "  ",
                  Method = "  ",
                  Function = "  ",
                  Constructor = "  ",
                  Field = "  ",
                  Variable = "  ",
                  Class = "  ",
                  Interface = "  ",
                  Module = "  ",
                  Property = "  ",
                  Unit = "  ",
                  Value = "  ",
                  Enum = "  ",
                  Keyword = "  ",
                  Snippet = "  ",
                  Color = "  ",
                  File = "  ",
                  Reference = "  ",
                  Folder = "  ",
                  EnumMember = "  ",
                  Constant = "  ",
                  Struct = "  ",
                  Event = "  ",
                  Operator = "  ",
                  TypeParameter = "  ",
                }

                vim_item.menu = vim_item.kind
                vim_item.kind = icons[vim_item.kind]
                return vim_item
              end
            '';
          };
        };
      };
    };
  };
}
