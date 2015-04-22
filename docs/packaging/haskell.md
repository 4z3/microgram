# Packaging Haskell apps

Start with [cabal2nix](https://github.com/NixOS/cabal2nix).

Assuming your cabal project is referenceable as '<package>', the workflow
roughly looks like:

```bash
$ cabal2nix $(nix-instantiate --eval -E '<package>') | awk '{ if ($0 ~ /^  src/) sub("=.*;", "= <package>;");print $0}' > ./package/default.nix
# now add to the packages attrset:
   package = pkgs.haskellPackages.callPackage ./package {};
```

You'll have to double-check if the dependencies inferred by `cabal2nix` actually exist
in your `pkgs` collection and if not, you have to repeat the procedure for it.
