{ pkgs ? import (import ./nixpkgs.nix) {}}:
let
  all = pkgs:
    let
      haskellset = haskellPackages: let
        callPackage = pkgs.newScope (pkgs // haskellPackages // pkgs.haskell.lib);
      in with pkgs.haskell.lib; rec {
        haskell-language-server = callPackage ./haskell-language-server/haskell-language-server.nix { inherit floskell ghcide ormolu ghc-check; };
          floskell = dontCheck (unmarkBroken (haskellPackages.floskell.override { inherit monad-dijkstra; }));
            monad-dijkstra = dontCheck (unmarkBroken haskellPackages.monad-dijkstra);
          ormolu = callPackage ./haskell-language-server/ormolu.nix { inherit ghc-lib-parser; };
            ghc-lib-parser = callPackage ./haskell-language-server/ghc-lib-parser.nix {};
          ghc-check = callPackage ./haskell-language-server/ghc-check.nix {};
          ghcide = callPackage ./haskell-language-server/ghcide.nix { inherit haskell-lsp haskell-lsp-types opentelemetry hie-bios ghc-check; };
            opentelemetry = callPackage ./haskell-language-server/opentelemetry.nix {};
            haskell-lsp = callPackage ./haskell-language-server/haskell-lsp.nix { inherit haskell-lsp-types; };
            haskell-lsp-types = callPackage ./haskell-language-server/haskell-lsp-types.nix {};
            hie-bios = callPackage ./haskell-language-server/hie-bios.nix {};
      };
    in
      {
        haskellPackages = haskellset pkgs.haskellPackages;
        haskell.packages = pkgs.lib.mapAttrs (n: v: haskellset v) pkgs.haskell.packages;
      };
in
  (all pkgs) // rec {
    nixpkgs = (import (import ./nixpkgs.nix) {});
    pinned = all nixpkgs;
  }
