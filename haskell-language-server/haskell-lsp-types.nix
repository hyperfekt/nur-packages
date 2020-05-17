let
  f = { haskellPackages
      , ...}@args:
      haskellPackages.callHackageDirect
        {
          pkg = "haskell-lsp-types";
          ver = "0.22.0.0";
          sha256 = "1apjclphi2v6ggrdnbc0azxbb1gkfj3x1vkwpc8qd6lsrbyaf0n8";
        }
        (builtins.removeAttrs args (builtins.attrNames (builtins.functionArgs f)));
in
  f
