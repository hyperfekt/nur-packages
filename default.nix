{ pkgs ? import (import ./nixpkgs.nix) {}}:
let
  all = pkgs:
    let
      inherit (pkgs) callPackage;
    in
      rec {
  };
in
  (all pkgs) // rec {
    nixpkgs = (import (import ./nixpkgs.nix) {});
    pinned = all nixpkgs;
  }
