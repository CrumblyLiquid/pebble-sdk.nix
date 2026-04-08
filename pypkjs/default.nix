{
  lib,
  stdenv,
  makeWrapper,
  python3Packages,
  fetchFromGitHub,
  fetchPypi,
  autoPatchelfHook,
  zlib,
  libpebble2,
  pygeoip,
  stpyv8,
}:
python3Packages.buildPythonPackage {
  pname = "pypkjs";
  version = "2.0.7";

  src = fetchFromGitHub {
    owner = "coredevices";
    repo = "pypkjs";
    rev = "ca96f2f53e1db209c09edf115face6c25fb3b8a0";
    hash = "sha256-IL/8ELmEOHiCLOaD1LFk6Pc/W/25AzG83aU4UOr3BOA=";
  };

  build-system = [
    python3Packages.setuptools
  ];
  pyproject = true;

  nativeBuildInputs = [ makeWrapper ];

  propagatedBuildInputs = with python3Packages; [
    gevent
    gevent-websocket
    greenlet
    peewee
    pygeoip
    pypng
    python-dateutil
    requests
    sh
    six
    websocket-client
    libpebble2
    netaddr
    stpyv8
  ];

  postFixup = ''
    wrapProgram $out/bin/pypkjs \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ stdenv.cc.cc.lib ]}
  '';

  meta = {
    homepage = "https://github.com/coredevices/pypkjs";
    description = "Python implementation of PebbleKit JS";
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
    license = lib.licenses.mit;
  };
}
