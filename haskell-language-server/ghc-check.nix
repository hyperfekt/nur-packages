let
  f = { callHackageDirect
      , ...}@args:
      callHackageDirect
        {
          pkg = "ghc-check";
          ver = "0.3.0.1";
          sha256 = "1dj909m09m24315x51vxvcl28936ahsw4mavbc53danif3wy09ns";
        }
        (builtins.removeAttrs args (builtins.attrNames (builtins.functionArgs f)));
in
  f
