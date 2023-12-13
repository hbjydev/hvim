update:
  nix flake update

build package="default":
  nix build --no-link --json --print-build-logs ".#{{package}}"

run package="default":
  nix run ".#{{package}}"
