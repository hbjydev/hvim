{ ... }:
{
  config = {
    plugins.neo-tree = {
      enable = true;
      enableGitStatus = true;
      enableRefreshOnWrite = true;
      window = {
        position = "float";
      };
    };
  };
}
