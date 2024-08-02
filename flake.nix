{
	description = "My NixOS Flake";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-24.05";

        home-manager = {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
	};

	outputs = { self, nixpkgs, ... }:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        # box - system hostname
        nixosConfigurations.box = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [ ./system-config/configuration.nix ];
        };
        homeConfigurations = {
            fox = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./system-config/home.nix ];
            };
        };
    };
}
