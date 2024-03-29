{ ... }:
{
  plugins.neo-tree = {
    enable = true;
    enableGitStatus = true;
    enableRefreshOnWrite = true;

    defaultComponentConfigs = {
      indent = {
        withExpanders = true;
        expanderCollapsed = "";
        expanderExpanded = "";
        expanderHighlight = "NeoTreeExpander";
      };
    };

    window = {
      position = "float";
    };

    filesystem = {
      filteredItems = {
        hideDotfiles = false;
        alwaysShow = [ ".gitignore" "flake.nix" ];
        hideByPattern = [ "*/.git" ];
      };
    };
  };
}
