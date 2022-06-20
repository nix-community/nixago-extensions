{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    data-merge.url = "github:divnix/data-merge";
    nixago.url = "github:nix-community/nixago";
    nixago.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, nixago, data-merge }:
    rec {
      # Only run CI on Linux
      herculesCI.ciSystems = [ "x86_64-linux" "aarch64-linux" ];
    } // (flake-utils.lib.eachDefaultSystem
      (system:
        let
          engines = nixago.engines.${system};
          make = nixago.lib.${system}.make;
          exts = import ./extensions { inherit pkgs engines data-merge; };

          # Setup pkgs
          pkgs = import nixpkgs {
            inherit system;
          };

          # Import test runner
          runTest = import ./tests/common.nix { inherit pkgs make exts; };

          # Helper function for aggregating development tools
          mkTools = tools: (builtins.listToAttrs
            (
              builtins.map
                (tool:
                  pkgs.lib.nameValuePair (pkgs.lib.getName tool) { pkg = tool; exe = pkgs.lib.getExe tool; })
                tools
            ) // { all = tools; });

          # Define development tools
          tools = mkTools [
            pkgs.conform
            pkgs.cue
            pkgs.just
            pkgs.lefthook
            pkgs.mdbook
            pkgs.mdbook-mermaid
            pkgs.nixpkgs-fmt
            pkgs.nodePackages.prettier
            pkgs.typos
          ];

          # Define development tool configuration (with extensions!)
          configs = import ./.config.nix { inherit exts tools; };
        in
        rec {
          # Add local tests
          checks = import ./tests { inherit pkgs runTest; };

          # Configure local development shell
          devShells = {
            default = pkgs.mkShell {
              shellHook = (nixago.lib.${system}.makeAll configs).shellHook;
              packages = tools.all;
            };
          };
        } // import ./extensions { inherit pkgs engines data-merge; }
      ));
}
