{ pkgs ? import <nixpkgs> { } }:
let
  easy-ps = import
    (pkgs.fetchFromGitHub {
      owner = "justinwoo";
      repo = "easy-purescript-nix";
      rev = "5926981701ac781f08b02e31e4705e46b799299d";
      sha256 = "sha256-fA0HEajsXLgI+dRJBYysFExELU8o/TgRnrm2UAju6Q0=";
    }) {
    inherit pkgs;
  };
in
easy-ps.shell

# pkgs.mkShell {
#   buildInputs = with easy-ps; [
#     purs-tidy
#   ];
# }
