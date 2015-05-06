{ mkDerivation, base, hspec, QuickCheck, stdenv, unix }:
mkDerivation {
  pname = "base-compat";
  version = "0.8.1.1";
  sha256 = "0j1k7yxahprbajzvfxvdfzz3frx8s8karq1kv8v02yh0lsw7hjki";
  buildDepends = [ base unix ];
  testDepends = [ base hspec QuickCheck ];
  description = "A compatibility layer for base";
  license = stdenv.lib.licenses.mit;
}
