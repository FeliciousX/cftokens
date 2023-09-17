{
  description = "Rust Template";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    flake-utils.url = github:numtide/flake-utils;

    rust-overlay.url = github:oxalica/rust-overlay;
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        box = pkgs.callPackage ./commandbox.nix { };
      in
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            pkgs.rust-bin.stable.latest.default
            pkgs.rust-analyzer
            box
          ];

          buildInputs = with pkgs; [ ];

          shellHook = ''
            export TERM=xterm-256color
          '';
        };

        packages.default = pkgs.rustPlatform.buildRustPackage rec {
          name = "cftokens";

          src = ./.;

          cargoLock = {
            lockFile = ./Cargo.lock;
          };
        };
      }
    );
}

