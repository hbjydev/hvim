{ pkgs, ... }:
{
  plugins.dap = {
    enable = true;
    extensions = {
      dap-go.enable = true;
      dap-ui.enable = true;
      dap-virtual-text.enable = true;
    };

    adapters = {
      executables = {
        lldb = {
          command = "${pkgs.lldb_18}/bin/lldb-vscode";
        };
      };
    };
  };
}
