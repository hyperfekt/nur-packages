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
            rev = "024d4ec94dea2380cdeee6958ab7c49cff846d12";
            sha256 = "1rw6j8m2x5ls5sfqpzgp1n4ssk79r1ci4fr1za897zw7mqna1d94";
          })
          (builtins.removeAttrs args (builtins.attrNames (builtins.functionArgs f))));
in
  f
