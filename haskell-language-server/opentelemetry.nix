let
  f = { callHackageDirect
      , ...}@args:
      callHackageDirect
        {
          pkg = "opentelemetry";
          ver = "0.4.2";
          sha256 = "1cclr4l7s6jmf31vkp1ypzbjm4i77mn7vfvy67w3r2nfda5silkw";
        }
        (builtins.removeAttrs args (builtins.attrNames (builtins.functionArgs f)));
in
  f
