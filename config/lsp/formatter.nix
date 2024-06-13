{ pkgs, ... }:
let
  inherit (pkgs)
    gofumpt
    stylua
    ruff
    prettierd
    nixpkgs-fmt
    terraform;
in
{
  extraPackages = [
    gofumpt
    stylua
    ruff
    prettierd
    nixpkgs-fmt
    terraform
  ];

  extraConfigLua = ''
    vim.api.nvim_create_user_command("Format", function(args)
      require("conform").format({ async = true, lsp_fallback = true })
    end, {})
  '';

  plugins.conform-nvim = {
    enable = true;
    formattersByFt = {
      go = [ "gofumpt" ];
      lua = [ "stylua" ];
      python = [ "ruff_format" "ruff_fix" "isort" "black" ];
      javascript = [ "prettierd" ];
      typescript = [ "prettierd" ];
      nix = [ "nixpkgs_fmt" ];
      tf = [ "terraform_fmt" ];
      "_" = [ "trim_whitespace" ];
      jsonnet = [ "jsonnetfmt" ];
    };
  };
}
