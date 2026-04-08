{
  lib,
  python3Packages,
  fetchFromGitHub,
}:
python3Packages.buildPythonPackage rec {
  pname = "sourcemap";
  version = "0.2.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "mattrobenolt";
    repo = "python-sourcemap";
    tag = version;
    hash = "sha256-xVVBtwYPAsScYitINnKhj3XOgapXzQnXvmuF0B4Kuac=";
  };

  build-system = [
    python3Packages.setuptools
  ];

  # TODO: Possibly run tests?

  meta = {
    description = "Parse JavaScript source maps";
    homepage = "https://github.com/mattrobenolt/python-sourcemap";
    license = lib.licenses.bsd2;
  };
}
