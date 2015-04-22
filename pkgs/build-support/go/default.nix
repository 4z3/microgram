# Experimental Go builder.
#
# (1) Non-deterministic:
#
# nix-build -E 'let pkgs = (import <nixpkgs> {}); in (import ./pkgs/build-support/go pkgs).mkDerivation (self: {
#   package = "github.com/tools/godep";
#   src = pkgs.fetchgit {
#     url = "https://${self.package}";
#     rev = "58d90f262c13357d3203e67a33c6f7a9382f9223";
#     sha256 = "831a1170d74143f699217625271727485c914fe65e6122f783d02ffb9b055acf";
#   };
# })'
#
# (2) Less deterministic:
#
# nix-build -E '(import ./pkgs/build-support/go (import <nixpkgs> {})).mkDerivation (self: { package = "github.com/tools/godep"; })'

{ lib, stdenv, go, git, mercurial, subversion, bazaar, cacert
, writeScript, ... }:

let
  inherit (lib) splitString last;
  packageToName = package: last (splitString "/" package);
in {
  mkDerivation = args: let
    defaults = self: {
      name = packageToName self.package;
      buildInputs = [ go cacert git mercurial subversion bazaar ];
      src = stdenv.mkDerivation {
        inherit (self) package buildInputs;
        name = (packageToName self.package) + "-workspace";
        builder = writeScript "go-builder" ''
          source $stdenv/setup; mkdir -p $out
          env SSL_CERT_FILE="${cacert}/etc/ca-bundle.crt" GOPATH="$PWD" go get -d ${self.package}
          cp -r "$PWD/src/${self.package}"/* $out
        '';
        __noChroot = true;
      };
      buildPhase = ''
        export GOPATH="$TMPDIR"
        mkdir -p "$GOPATH/src/$(dirname ${self.package})"
        ln -s $src "$GOPATH/src/${self.package}"
        export SSL_CERT_FILE="${cacert}/etc/ca-bundle.crt"
        go get -d; go build -o ${self.name}
      '';
      installPhase = ''
        mkdir -p $out/bin;
        cp ${self.name} $out/bin
      '';
      __noChroot = true;
    };
  in stdenv.mkDerivation (let super = defaults self // args self; self = super; in self);
}
