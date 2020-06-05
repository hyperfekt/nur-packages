let
  f = { callHackageDirect
      , dontCheck
      , ...}@args:
      dontCheck
        (callHackageDirect
          {
            pkg = "ghc-lib-parser";
            ver = "8.10.1.20200523";
            sha256 = "1fnhqb9l0cg58lalrrn4ms48rnnzlyb7dqa9h2g21m9287q5y6gs";
          }
          (builtins.removeAttrs args (builtins.attrNames (builtins.functionArgs f))));
in
  f
