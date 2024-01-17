{ ... }:
{
  config = {
    highlight = builtins.mapAttrs
      (_: opts: {
        fg.__raw = "require('oxocarbon').oxocarbon.${opts.fg} or null";
        bg.__raw = "require('oxocarbon').oxocarbon.${opts.bg} or null";
        bold = opts.bold or null;
        italic = opts.italic or null;
      })
      {
        Normal.bg = "none";
        LineNr = { fg = "base03"; bg = "none"; };
        SignColumn = { fg = "base02"; bg = "none"; };
        NormalNC.bg = "none";
        NormalFloat.bg = "none";
        FloatBorder = { fg = "base02"; bg = "none"; };
        VertSplit = { fg = "base01"; bg = "none"; };

        TelescopeBorder = { fg = "base03"; bg = "none"; };
        TelescopePromptBorder = { fg = "base03"; bg = "none"; };
        TelescopePromptNormal = { fg = "base05"; bg = "none"; };
        TelescopePromptPrefix = { fg = "base08"; bg = "none"; };
        TelescopeNormal = { fg = "none"; bg = "none"; };
        TelescopePreviewTitle = { fg = "base12"; bg = "none"; };
        TelescopePromptTitle = { fg = "base11"; bg = "none"; };
        TelescopeResultsTitle = { fg = "base14"; bg = "none"; };
        TelescopeSelection = { fg = "none"; bg = "base01"; };
        TelescopePreviewLine = { fg = "none"; bg = "none"; };
        TelescopeMatching = {
          fg = "base14"; bg = "none";
          bold = true; italic = true;
        };

        DiffAdd = { bg = "base13"; fg = "none"; };
        DiffAdded = { bg = "base13"; fg = "none"; };
        DiffChange = { bg = "base14"; fg = "none"; };
        DiffChanged = { bg = "base14"; fg = "none"; };
        DiffDelete = { bg = "base10"; fg = "none"; };
        DiffRemoved = { bg = "base10"; fg = "none"; };
        DiffText = { bg = "base02"; fg = "none"; };

        NeoTreeTitleBar = { fg = "base02"; bg = "none"; };
      };
  };
}
