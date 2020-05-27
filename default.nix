{ pkgs ? import (import ./nixpkgs.nix) {}}:
let
  all = pkgs:
    let
      haskellset = haskellPackages: let
        callPackage = pkgs.newScope (pkgs // haskellPackages // pkgs.haskell.lib);
      in with pkgs.haskell.lib; rec {
        haskell-language-server = callPackage ./haskell-language-server/haskell-language-server.nix { inherit floskell haskell-lsp haskell-lsp-types ormolu ghcide lsp-test hie-bios; };
          floskell = dontCheck (unmarkBroken (haskellPackages.floskell.override { inherit monad-dijkstra; }));
            monad-dijkstra = dontCheck (unmarkBroken (haskellPackages.monad-dijkstra.override { inherit hlint; }));
              hlint = callPackage ./haskell-language-server/hlint.nix {};
          haskell-lsp = callPackage ./haskell-language-server/haskell-lsp.nix { inherit haskell-lsp-types; };
          haskell-lsp-types = callPackage ./haskell-language-server/haskell-lsp-types.nix {};
          lsp-test = callPackage ./haskell-language-server/lsp-test.nix { inherit haskell-lsp; };
          ormolu = callPackage ./haskell-language-server/ormolu.nix { inherit ghc-lib-parser; };
            ghc-lib-parser = callPackage ./haskell-language-server/ghc-lib-parser.nix {};
          ghcide = callPackage ./haskell-language-server/ghcide.nix { inherit haskell-lsp haskell-lsp-types opentelemetry hie-bios lsp-test; };
            opentelemetry = callPackage ./haskell-language-server/opentelemetry.nix {};
          hie-bios = callPackage ./haskell-language-server/hie-bios.nix {};
        hnix = callPackage ./hnix.nix {};
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
