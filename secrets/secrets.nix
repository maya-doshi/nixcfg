let
  maya-richard =  builtins.readFile ./publicKeys/maya-richard.pub;
  keys = [ maya-richard ];
in {
  "lastFM/apiKey.age".publicKeys = keys;
  "lastFM/secret.age".publicKeys = keys;
  "spotify/clientId.age".publicKeys = keys;
  "spotify/clientSecret.age".publicKeys = keys;
}
