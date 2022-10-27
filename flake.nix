{ inputs =
    { nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      ps-tools.follows = "purs-nix/ps-tools";
      purs-nix.url = "github:zer0-star/purs-nix/add-jelly";
      utils.url = "github:numtide/flake-utils";
    };

  outputs = { self, nixpkgs, utils, ... }@inputs:
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
                     node-fs
                     node-fs-aff
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
               default = import ./default.nix { inherit main generate-site pkgs; };
               main = ps.modules.BrowserMain.bundle { esbuild = { minify = true; }; };
               generate-site = ps.modules.NodeMain.script {};
               server = pkgs.writeShellScriptBin "server" ''
                 ${pkgs.simple-http-server}/bin/simple-http-server -i ${default}/public
               '';
             };

           apps.serve = {
             type = "app";
             program = "${self.packages.${system}.server}/bin/server";
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
