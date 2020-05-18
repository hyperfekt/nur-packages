let
  f = { callHackageDirect
      , ...}@args:
      callHackageDirect
        {
          pkg = "opentelemetry";
          ver = "0.4.0";
          sha256 = "1lzm1bmis835digmrm3ipgh5zhn99dbkcfp5daqcf8lzr9hg075p";
        }
        (builtins.removeAttrs args (builtins.attrNames (builtins.functionArgs f)));
in
  f
