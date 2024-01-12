{ ... }:
{
  imports = [
    ./dashboard
    ./tree
  ];

  colorschemes.oxocarbon.enable = true;

  extraConfigLua = ''
    ${builtins.readFile ./oxocarbon-contrib.lua}
  '';
}
