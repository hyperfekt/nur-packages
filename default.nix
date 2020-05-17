{ pkgs ? import (import ./nixpkgs.nix) {}}:
let
  all = pkgs:
    let
      inherit (pkgs) callPackage;

      callWithPackages = package: explicitHaskellDeps: explicitDeps: haskellPackages: callPackage package ({ inherit haskellPackages; } // pkgs.lib.mapAttrs (n: v: v haskellPackages) explicitHaskellDeps // explicitDeps);
    in
      rec {
        default-haskell-language-server = haskell-language-server pkgs.haskellPackages;
        default-ghcide = ghcide pkgs.haskellPackages;
        haskell-language-server = callWithPackages ./haskell-language-server/haskell-language-server.nix { inherit floskell haskell-lsp haskell-lsp-types ormolu ghcide lsp-test; } {};
          floskell = haskellPackages: with pkgs.haskell.lib; dontCheck (unmarkBroken (haskellPackages.floskell.override { monad-dijkstra = monad-dijkstra haskellPackages; }));
            monad-dijkstra = haskellPackages: with pkgs.haskell.lib; dontCheck (unmarkBroken (haskellPackages.monad-dijkstra.override { hlint = hlint haskellPackages; }));
              hlint = callWithPackages ./haskell-language-server/hlint.nix {} {};
          haskell-lsp = callWithPackages ./haskell-language-server/haskell-lsp.nix { inherit haskell-lsp-types; } {};
          haskell-lsp-types = callWithPackages ./haskell-language-server/haskell-lsp-types.nix {} {};
          lsp-test = callWithPackages ./haskell-language-server/lsp-test.nix { inherit haskell-lsp; } {};
          ormolu = callWithPackages ./haskell-language-server/ormolu.nix { inherit ghc-lib-parser; } {};
            ghc-lib-parser = callWithPackages ./haskell-language-server/ghc-lib-parser.nix {} {};
          ghcide = callWithPackages ./haskell-language-server/ghcide.nix { inherit haskell-lsp haskell-lsp-types opentelemetry hie-bios lsp-test; } {};
            opentelemetry = callWithPackages ./haskell-language-server/opentelemetry.nix {} {};
            hie-bios = callWithPackages ./haskell-language-server/hie-bios.nix {} {};
  };
in
  (all pkgs) // rec {
    nixpkgs = (import (import ./nixpkgs.nix) {});
    pinned = all nixpkgs;
  }
