{ inputs =
    { nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      ps-tools.follows = "purs-nix/ps-tools";
      purs-nix.url = "github:purs-nix/purs-nix/master";
      utils.url = "github:numtide/flake-utils";
    };

  outputs = { nixpkgs, utils, ... }@inputs:
    utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ]
      (system:
         let
           pkgs = nixpkgs.legacyPackages.${system};
           ps-tools = inputs.ps-tools.legacyPackages.${system};
           purs-nix = inputs.purs-nix { inherit system; };
           ps =
             purs-nix.purs
               { dependencies =
                   with purs-nix.ps-pkgs;
                   [ console
                     effect
                     foldable-traversable
                     prelude
                     strings
                     tuples
                     jelly
                   ];

                 dir = ./.;
               };
         in
         { packages =
             rec {
               default = import ./default.nix { inherit bundle pkgs; };
               bundle = ps.modules.Main.bundle { esbuild = { minify = true; }; };
               output = ps.modules.Main.output {};
             };

           devShells.default =
             pkgs.mkShell
               { packages =
                   with pkgs;
                   [ entr
                     nodejs
                     (ps.command {})
                     ps-tools.for-0_15.purescript-language-server
                     ps-tools.for-0_15.purs-tidy
                     purs-nix.esbuild
                     purs-nix.purescript
                   ];

                 shellHook =
                   ''
                   alias watch="find src | entr -s 'echo bundling; purs-nix bundle'"
                   '';
               };
         }
      );
}
