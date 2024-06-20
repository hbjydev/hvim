update:
  nix flake update

build package="default":
  nix build --no-link --json --print-build-logs ".#{{package}}"

run package="default":
  nix run ".#{{package}}"

cache-build package="default":
  attic push hayden $(nix build --no-link --json --print-build-logs ".#{{package}}" | jq -r .[].outputs.out)
