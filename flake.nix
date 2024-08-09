{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager-stable.url = "github:nix-community/home-manager/release-24.05";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager-stable, hyprland }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { system = system; };
    lib = pkgs.lib;
    home-manager = home-manager-stable;
  in
  {
    nixosConfigurations = {
      default = lib.nixosSystem {
        system = system;
        modules = [ ./configuration.nix ];
        specialArgs = {
          inherit pkgs;
          inherit home-manager;
          inherit hyprland;
        };
      };
    };

    homeConfigurations = {
      fox = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          inherit hyprland;
        };
      };
    };
  };
}
