let
  f = { callCabal2nix
      , fetchFromGitHub
      , nix
      , ...}@args:
        (callCabal2nix
          "hnix"
          (fetchFromGitHub {
            owner = "haskell-nix";
            repo = "hnix";
            rev = "111937ba585679e0cf901885e8c3fca8ae301c8f";
            sha256 = "09hkkprhprrpk98r6jbn3akhvnq198vknh5y13ryin5q74wfxf3n";
            fetchSubmodules= true;
          })
          (builtins.removeAttrs args (builtins.attrNames (builtins.functionArgs f))))
        .overrideAttrs (drv: { nativeBuildInputs = (drv.nativeBuildInputs or []) ++ [ nix ]; });
in
  f
