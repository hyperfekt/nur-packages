let
  f = { haskellPackages
      , haskell
      , ...}@args:
      haskell.lib.dontCheck
        (haskellPackages.callHackageDirect
          {
            pkg = "ghc-lib-parser";
            ver = "8.10.1.20200412";
            sha256 = "05adhjbvkgpx0bwzv1klc2a356d23zqdbj502iapqksirjkk6cqj";
          }
          (builtins.removeAttrs args (builtins.attrNames (builtins.functionArgs f))));
in
  f
