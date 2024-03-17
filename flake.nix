{
  description = "Bharadwaj's NixOS / nix-darwin configuration";

  inputs = {
    # pricipal inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    nixos-flake.url = "github:srid/nixos-flake";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # software inputs
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nixos-shell.url = "github:Mic92/nixos-shell";
    nixos-vscode-server.url = "github:nix-community/nixos-vscode-server";
    nixos-vscode-server.flake = false;
  };

  outputs = inputs @ {self, ...}:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-darwin"];
      imports = [
        inputs.nixos-flake.flakeModule
      ];

      flake = let
        user = "bharadwaj";
      in {
        # darwinConfigurations.appreciate =
        #   self.nixos-flake.lib.mkMacosSystem
        #   ./systems/darwin.nix;

        nixosConfigurations = {
          default = self.nixos-flake.lib.mkLinuxSystem {
            imports = [
              ./nixos/configuration.nix
              inputs.sops-nix.nixosModules.sops
              {
                users.users.${user}.isNormalUser = true;
              }
              self.nixosModules.home-manager
              {
                home-manager.users.${user} = {
                  imports = [self.homeModules.default ./nixos/home.nix];
                };
              }
            ];
          };
        };

        homeModules.default = {pkgs, ...}: {
          imports = [
            ./home/direnv.nix
          ];
        };
      };

      perSystem = {
        self',
        pkgs,
        ...
      }: {
        packages.default = self'.packages.activate;
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.alejandra
          ];
        };
        formatter = pkgs.alejandra;
      };
    };
}
