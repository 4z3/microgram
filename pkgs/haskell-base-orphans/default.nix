{ mkDerivation, base, ghc-prim, hspec, stdenv }:
mkDerivation {
  pname = "base-orphans";
  version = "0.3.0";
  sha256 = "19cqh95kpd34wf550b9j417v8z4gzczqiv0ghq9fp3wwd7j5qcmw";
  buildDepends = [ base ghc-prim ];
  testDepends = [ base hspec ];
  homepage = "https://github.com/haskell-compat/base-orphans#readme";
  description = "Backwards-compatible orphan instances for base";
  license = stdenv.lib.licenses.mit;
}
