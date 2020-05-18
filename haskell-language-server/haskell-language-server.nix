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
            rev = "0a2be76f5f3496670d7a3f6a8f324a393c859109";
            sha256 = "0rjlyck806bxdq56d8q82v4qa2dqb49ki9fw2lmfy5c68vadbznf";
          })
          (builtins.removeAttrs args (builtins.attrNames (builtins.functionArgs f))));
in
  f
