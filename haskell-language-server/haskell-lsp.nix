let
  f = { haskellPackages
      , ...}@args:
      haskellPackages.callHackageDirect
        {
          pkg = "haskell-lsp";
          ver = "0.22.0.0";
          sha256 = "1q3w46qcvzraxgmw75s7bl0qvb2fvff242r5vfx95sqska566b4m";
        }
        (builtins.removeAttrs args (builtins.attrNames (builtins.functionArgs f)));
in
  f
