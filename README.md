# pebble-sdk.nix

This is a simple alternative to
the (at the time of writing) slightly
outdated an very complicated
[pebble.nix](https://github.com/pebble-dev/pebble.nix) flake.

Note: This is very much a work in progress!
You probably shouldn't rely on this for
real projects :)

This flake borrows mainly from
[pebble.nix](https://github.com/pebble-dev/pebble.nix)
and [pebble-flake](https://git.spoodythe.one/spoody/pebble-flake).

## Features

Packages:
- `qemu-pebble`
- `pebble-tool`
- `libpebble2`
- `pypkjs`

All of this without the need
for Python 2!

The goal is to have a simple flake
without many dependencies that have
to be defined manually.
