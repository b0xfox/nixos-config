{
	description = "My NixOS Flake"'

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-24.05";
		home-manager.url = "github:nix-community/home-manager/release-24.05";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, ... }:
    let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        hostName = "box";
        userName = "fox";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        nixosConfigurations = {
            ${hostName} = lib.nixosSystem {
                system = ${system};
                modules = [ ./system-config/configuration.nix ];
            };
        };
        homeConfigurations = {
            ${username} = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./system-config/home.nix ];
            };
        };
    };
}
