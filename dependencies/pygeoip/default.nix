{
  lib,
  python3Packages,
  fetchFromGitHub,
}:
python3Packages.buildPythonPackage rec {
  pname = "pygeoip";
  version = "0.3.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "appliedsec";
    repo = "pygeoip";
    tag = "v${version}";
    hash = "sha256-D058c3o+2rTMQJpgwvFKd5Qwt2j7u4+GFpQHjO7lOVQ=";
  };

  build-system = [
    python3Packages.setuptools
  ];

  meta = {
    description = "Pure Python API for Maxmind's binary GeoIP databases";
    homepage = "https://github.com/appliedsec/pygeoip";
    license = lib.licenses.lgpl3;
  };
}
