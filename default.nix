{ pkgs ? import <nixpkgs> { config = {}; } }:
let cargo_nix = pkgs.callPackage ./Cargo.nix {};
in cargo_nix.workspaceMembers."evcxr".build
