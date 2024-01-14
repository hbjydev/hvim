{ ... }:
{
  imports = [
    ./dashboard
    ./tree
  ];

  colorschemes.oxocarbon.enable = true;

  plugins.lualine = {
    enable = true;
  };

  extraConfigLua = ''
    ${builtins.readFile ./oxocarbon-contrib.lua}
  '';
}
