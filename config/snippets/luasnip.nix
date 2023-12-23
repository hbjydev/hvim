{ ... }:
{
  config.plugins.luasnip = {
    enable = true;
    fromVscode = [
      {}
      { paths = ./json; }
    ];
  };
}
