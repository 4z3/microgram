{ mkDerivation, base, base-compat, base-orphans, generics-sop
, hspec, hspec-expectations, markdown-unlit, QuickCheck, silently
, stdenv, tagged
}:
mkDerivation {
  pname = "getopt-generics";
  version = "0.6.3";
  sha256 = "18d9cbk87gx31fk1bdylllicbnxj2xmb5xzss27amy8xcmlb3qds";
  buildDepends = [
    base base-compat base-orphans generics-sop tagged
  ];
  testDepends = [
    base base-compat base-orphans generics-sop hspec hspec-expectations
    markdown-unlit QuickCheck silently tagged
  ];
  description = "Simple command line argument parsing";
  license = stdenv.lib.licenses.bsd3;
}
