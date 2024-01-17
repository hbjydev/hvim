{ ... }:
{
  imports = [
    ./dashboard
    ./tree
    ./highlight.nix
  ];

  colorschemes.oxocarbon.enable = true;

  plugins.lualine = {
    enable = true;
    globalstatus = true;
  };
}
