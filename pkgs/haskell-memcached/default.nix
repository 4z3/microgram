{ mkDerivation, base, bytestring, fetchgit, network, stdenv
, utf8-light
}:
mkDerivation {
  pname = "memcached";
  version = "0.2.1";
  src = fetchgit {
    url = "https://github.com/zalora/haskell-memcached.git";
    sha256 = "3cc002462fd7859afaaf8bcdb83c314ba61f23457dbb3d0e339f26a845126bf2";
    rev = "11c21503aa940c6d07f67d1b9dac375078e39983";
  };
  buildDepends = [ base bytestring network utf8-light ];
  homepage = "http://github.com/olegkat/haskell-memcached";
  description = "haskell bindings for memcached";
  license = "unknown";
}
