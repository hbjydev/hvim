{ ... }:
{
  imports = [ ./copilot.nix ];

  config = {
    plugins = {
      nix.enable = true;

      gitsigns.enable = true;
      diffview.enable = true;

      indent-blankline = {
        enable = true;
        indent = {
          highlight = "FoldColumn";
          smartIndentCap = true;
        };
        scope = {
          highlight = "NvimTreeIndentMarker";
        };
      };

      comment-nvim.enable = true;
    };

    extraConfigLua = ''
      ${builtins.readFile ../statusline.lua}
    '';
  };
}
