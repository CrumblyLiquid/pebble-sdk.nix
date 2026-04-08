{
  lib,
  stdenv,
  python3Packages,
  fetchPypi,
  zlib,
  autoPatchelfHook,
}:
python3Packages.buildPythonPackage rec {
  pname = "stpyv8";
  version = "13.1.201.22";
  pyproject = false;

  src =
    let
      pyShortVersion = "cp" + builtins.replaceStrings [ "." ] [ "" ] python3Packages.python.pythonVersion;
    in
    fetchPypi {
      inherit pname version;
      format = "wheel";
      dist = pyShortVersion;
      python = pyShortVersion;
      abi = pyShortVersion;
      platform =
        {
          x86_64-linux = "manylinux_2_31_x86_64";
          # aarch64-linux is not present in the build artifacts
          # aarch64-linux = "manylinux_2_31_aarch64";
          x86_64-darwin = "macosx_13_0_x86_64";
          aarch64-darwin = "macosx_14_0_arm64";
        }
        .${stdenv.hostPlatform.system};
      hash =
        {
          x86_64-linux = "sha256-g0uXYbt/SdqLiHhHx2R0laLPbEX2niEkrg4/AkSTvBU=";
          # aarch64-linux = "sha256-g0uXYbt/SdqLiHhHx2R0laLPbEX2niEkrg4/AkSTvBU=";
          x86_64-darwin = "sha256-/CuVa/ryNTHEkIRe232A/JmP6K7hx88TNzF9rgEWkwc=";
          aarch64-darwin = "sha256-bcQLZWzqf+VB9r262DtrTtUeXq2YW1TBOTGacxJTpV4=";
        }
        .${stdenv.hostPlatform.system};
    };

  nativeBuildInputs = [
    python3Packages.pypaInstallHook
    python3Packages.wheelUnpackHook
  ]
  ++ (lib.optional stdenv.hostPlatform.isLinux autoPatchelfHook);

  buildInputs = [ zlib ];

  meta = {
    description = "Python 3 and JavaScript interoperability (successor to PyV8)";
    homepage = "https://github.com/cloudflare/stpyv8";
    license = lib.licenses.asl20;
  };
}
