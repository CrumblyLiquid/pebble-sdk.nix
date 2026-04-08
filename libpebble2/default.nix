{
  lib,
  python3Packages,
  fetchFromGitHub,
}:
python3Packages.buildPythonPackage rec {
  pname = "libpebble2";
  version = "0.0.31";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "pebble-dev";
    repo = "libpebble2";
    tag = "v${version}";
    hash = "sha256-4waUs0QeMI0dWL5Dk1HwL/5pK2uOfCFyJaK1MuRkuBw=";
  };

  propagatedBuildInputs = with python3Packages; [
    pyserial
    six
    websocket-client
    # TODO: Some packages in `requirements.txt` are not here
    # but it seems to work? :D
  ];

  build-system = [
    python3Packages.setuptools
  ];

  # TODO: Possibly run tests?

  meta = {
    description = "Python library for interacting with Pebble devices";
    homepage = "https://github.com/pebble-dev/libpebble2";
    license = lib.licenses.mit;
  };
}
