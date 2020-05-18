let
  f = { callHackageDirect
      , dontCheck
      , ...}@args:
      dontCheck
        (callHackageDirect
          {
            pkg = "lsp-test";
            ver = "0.10.3.0";
            sha256 = "0rs5v0cqksp97rk2sh6b1j6lvrvdf9j08852y9b4chg55d0pzzl9";
          }
          (builtins.removeAttrs args (builtins.attrNames (builtins.functionArgs f))));
in
  f
