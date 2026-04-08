{
  description = "An alternative flake to pebble.nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      # Let's start small for now
      supportedSystems = [
        "x86_64-linux"
        # "x86_64-darwin"
        # "aarch64-linux"
        # "aarch64-darwin"
      ];
      systemsAttr = nixpkgs.lib.genAttrs supportedSystems;
      forSupportedSystems = (
        function: systemsAttr (system: function (import nixpkgs { inherit system; }))
      );
    in
    {
      packages = forSupportedSystems (pkgs: rec {
        sourcemap = pkgs.callPackage ./dependencies/sourcemap { };
        pygeoip = pkgs.callPackage ./dependencies/pygeoip { };
        stpyv8 = pkgs.callPackage ./dependencies/stpyv8 { };

        libpebble2 = pkgs.callPackage ./libpebble2 { };
        pypkjs = pkgs.callPackage ./pypkjs { inherit libpebble2 pygeoip stpyv8; };
        pebble-tool = pkgs.callPackage ./pebble-tool { inherit libpebble2 pypkjs sourcemap; };
        qemu-pebble = pkgs.callPackage ./qemu-pebble { };
        default = pebble-tool;
      });

      # TODO: Add correct packages
      devShells = forSupportedSystems (pkgs: {
        default = pkgs.mkShellNoCC { };
      });

      formatter = forSupportedSystems (pkgs: pkgs.alejandra);
    };
}
