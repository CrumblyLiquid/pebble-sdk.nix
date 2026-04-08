{
  lib,
  stdenv,
  fetchFromGitHub,
  gnumake,
  python3,
  pkg-config,
  zlib,
  glib,
  pixman,
  dtc,
}:
let
  libraries = [
    zlib
    glib
    pixman
    dtc
    stdenv.cc.cc.lib
  ];
  rpath = lib.makeLibraryPath libraries;
in
stdenv.mkDerivation {
  pname = "qemu-pebble";
  version = "73b3a52";

  src = fetchFromGitHub {
    owner = "coredevices";
    repo = "qemu";
    rev = "73b3a52e8077adcfaf2005adb768e8f4e8a7bc74";
    hash = "sha256-HX/q09yB40fJzm4bxAOgNBsfwgroFPejSqOr/lVlzgs=";
  };

  enableParallelBuilding = true;

  nativeBuildInputs = [
    gnumake
    python3
    pkg-config
  ]
  ++ libraries;

  LD_LIBRARY_PATH = rpath;

  patches = [
    # Removes the need for Python 2
    # (it was only used in the build system)
    ./move-to-python3.patch
  ];

  configureFlags = [
    "--disable-werror"
    "--enable-debug"
    "--target-list=arm-softmmu"
    "--extra-cflags=-DSTM32_UART_NO_BAUD_DELAY"
  ];

  # TODO: Is this really needed?
  postFixup = ''
    patchelf --set-rpath "${rpath}" $out/bin/qemu-system-arm
  '';

  postInstall = ''
    ln -s $out/bin/qemu-system-arm $out/bin/qemu-pebble
  '';

  meta = {
    homepage = "https://github.com/coredevices/qemu";
    description = "Fork of QEMU for Pebble watches";
    mainProgram = "qemu-pebble";
    platforms = lib.platforms.linux ++ lib.platforms.darwin;
  };
}
