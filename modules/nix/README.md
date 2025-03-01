# Nix

> https://nixos.org

## devenv

- https://devenv.sh/
- https://github.com/cachix/devenv

```sh
# install cachix
nix-env -iA cachix -f https://cachix.org/api/v1/install
cachix use devenv

# install devenv with flakes profiles
nix-env -if https://github.com/cachix/devenv/tarball/latest
```

Advanced setup:

```sh
# install cachix
nix profile install nixpkgs#cachix
cachix use devenv

# install devenv with flakes profiles
nix profile install --accept-flake-config github:cachix/devenv/latest
```
