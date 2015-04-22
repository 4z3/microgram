{ stdenv, pythonPackages, ... }:

pythonPackages.buildPythonPackage {
  name = "python2nix";
  src = ./.;
  propagatedBuildInputs = with pythonPackages; [
    pip
    requests
    setuptools
  ];
}
