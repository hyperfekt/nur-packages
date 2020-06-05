let
  f = { callCabal2nix
      , fetchFromGitHub
      , dontCheck
      , ...}@args:
      dontCheck
        (callCabal2nix
          "haskell-language-server"
          (fetchFromGitHub {
            owner = "haskell";
            repo = "haskell-language-server";
            rev = "2310e1039c90d9bccaffd688a0d1ec79a9360bf4";
            sha256 = "1c1wfwddgcy8gxx53rvf5sj6g5f0vjsv8vwmnan9asx5jrskz51p";
          })
          (builtins.removeAttrs args (builtins.attrNames (builtins.functionArgs f))));
in
  f
