let
  f = { callHackageDirect
      , dontCheck
      , ...}@args:
      dontCheck
        (callHackageDirect
          {
            pkg = "ormolu";
            ver = "0.0.5.0";
            sha256 = "09zc5mra3n2kkbvvwvh7y0dh3fbs74i170xy66j90ndagqnfs16g";
          }
          (builtins.removeAttrs args (builtins.attrNames (builtins.functionArgs f))));
in
  f
