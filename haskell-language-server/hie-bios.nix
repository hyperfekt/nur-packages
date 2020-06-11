let
  f = { callCabal2nix
      , fetchFromGitHub
      , dontCheck
      , ...}@args:
      dontCheck
        (callCabal2nix
          "hie-bios"
          (fetchFromGitHub {
            owner = "mpickering";
            repo = "hie-bios";
            rev = "293baaf793f82f639affe734ebe785ccdcafd40b";
            sha256 = "04hp32xzbqij4q6npybx2xbzy8x84a2i2r7zxfhks2fx5xjg11vf";
          })
          (builtins.removeAttrs args (builtins.attrNames (builtins.functionArgs f))));
in
  f
