{ pkgs, main, generate-site }:

pkgs.stdenv.mkDerivation {
  name = "zer0-star.dev";

  src = ./.;

  buildInputs = with pkgs; [
    nodejs
    esbuild
    nodePackages.tailwindcss
  ];

  buildPhase = ''
    cp ${main} ./public/index.js
    ${generate-site}
    tailwindcss -i ./src/index.css -o ./public/index.css
  '';

  installPhase = ''
    mkdir $out
    cp -r public $out
  '';
}
