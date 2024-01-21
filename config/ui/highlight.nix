{ lib, ... }:
{
  config = {
    highlight = builtins.mapAttrs
      (_: opts@{ fg ? null, bg ? null, ... }:
        opts //
          (lib.optionalAttrs (fg != null) {
            fg.__raw = "require('oxocarbon').oxocarbon.${fg} or null";
          }) //
          (lib.optionalAttrs (bg != null) {
            bg.__raw = "require('oxocarbon').oxocarbon.${bg} or null";
          })
      )

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

        DiffAdd = { fg = "base13"; bg = "none"; };
        DiffAdded = { fg = "base13"; bg = "none"; };
        DiffChange = { fg = "base14"; bg = "none"; };
        DiffChanged = { fg = "base14"; bg = "none"; };
        DiffDelete = { fg = "base10"; bg = "none"; };
        DiffRemoved = { fg = "base10"; bg = "none"; };
        DiffText = { fg = "base02"; bg = "none"; };

        NeoTreeTitleBar = { fg = "base02"; bg = "none"; };
      };
  };
}
