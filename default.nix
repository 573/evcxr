with import <nixpkgs> {};
with buildRustCrateHelpers;
let
  evcxr-src = fetchFromGitHub {
    owner = "google";
    repo = "evcxr";
    rev = "58ef3c7914ab0d958144fe8615a10c9653b217d0";
    sha256 = "08zsdl6pkg6dx7k0ns8cd070v7ydsxkscd2ms8wh9r68c08vwzcp";
  };

  cratesIO = callPackage ./crates-io.nix {};

  _crates = callPackage ./Cargo.nix { inherit cratesIO; };

  evcxr_jupyter = (_crates.evcxr_jupyter {}).override {
    crateOverrides = defaultCrateOverrides // {
      evcxr = attrs: { src = evcxr-src; };
      evcxr_jupyter = attrs: { src = evcxr-src; };
      zmq-sys = attrs: { buildInputs = [ zeromq pkgconfig ]; };
    };
  };
in
  evcxr_jupyter

