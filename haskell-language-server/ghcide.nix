let
  f = { callCabal2nix
      , fetchFromGitHub
      , dontCheck
      , ...}@args:
      dontCheck
        (callCabal2nix
          "ghcide"
          (fetchFromGitHub {
            owner = "mpickering";
            repo = "ghcide";
            rev = "27855641693e8247543a1e12ffe9f0fd613f64f5";
            sha256 = "111hg5qkykfsrabg0nadhgizydy9k04g0nc2k8pyl29l6ppdnxfk";
          })
          (builtins.removeAttrs args (builtins.attrNames (builtins.functionArgs f))));
in
  f
