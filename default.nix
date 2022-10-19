{ pkgs, bundle }:

pkgs.stdenv.mkDerivation {
  name = "zer0-star.dev";

  src = ./.;

  buildInputs = with pkgs; [
    nodejs
    esbuild
    nodePackages.tailwindcss
  ];

  buildPhase = ''
    cp ${bundle} ./public/index.js
    tailwindcss -i ./src/index.css -o ./public/index.css
  '';

  installPhase = ''
    mkdir $out
    cp -r public $out
  '';
}
