let
  f = { haskellPackages
      , haskell
      , ...}@args:
      haskell.lib.dontCheck
        (haskellPackages.callHackageDirect
          {
            pkg = "hie-bios";
            ver = "0.5.0";
            sha256 = "116nmpva5jmlgc2dgy8cm5wv6cinhzmga1l0432p305074w720r2";
          }
          (builtins.removeAttrs args (builtins.attrNames (builtins.functionArgs f))));
in
  f
