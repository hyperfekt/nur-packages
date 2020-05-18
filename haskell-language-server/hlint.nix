let
  f = { callHackageDirect
      , ...}@args:
      callHackageDirect
        {
          pkg = "hlint";
          ver = "2.2.11";
          sha256 = "0v4axmqb3zwzznyvhiqbr50k23ah63sd9gsmi5sa2p97hch8kwx1";
        }
        (builtins.removeAttrs args (builtins.attrNames (builtins.functionArgs f)));
in
  f
