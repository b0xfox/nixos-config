{
  description = "My NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager-stable = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    stylix = {
      url = "github:danth/stylix";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager-stable, home-manager-unstable, hyprland, stylix }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = import (if systemSettings.nixBranch == "stable" then nixpkgs-stable else nixpkgs) { system = system; };
    lib = pkgs.lib;
    home-manager = home-manager-stable;
    systemSettings = {
      hostname = "box";
      timezone = "America/Detroit";
      locale = "en_US.UTF-8";
      bootMode = "uefi";
      bootMountPath = "/boot";
      grubDevice = "";
      nixBranch = "stable";
    };
    userSettings = {
        username = "fox";
        name = "Goofyman";
        dotfilesDir = "~/.dotfiles";
        #theme = "io";
        wmType = "hyprland";
        term = "alacritty"; # Default terminal command;
        # font = "Intel One Mono"; # Selected font
        editor = "nvim";
    };
    pkgs = if systemSettings.nixBranch == "stable" then
      import nixpkgs-stable { system = system; }
    else
      import nixpkgs { system = system; };

    lib = pkgs.lib;
    home-manager = home-manager-stable;
  in
  {
    homeConfigurations = {
      fox = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./config/home.nix ];
        extraSpecialArgs = {
          inherit systemSettings;
          inherit inputs;
        };
      };
    };

    nixosConfigurations = {
      default = lib.nixosSystem {
        system = system;
        modules = [ ./config/configuration.nix ];
        specialArgs = {
          inherit systemSettings;
          inherit inputs;
        };
      };
    };
  }
}
# overlays = [
#     (self: super: {
#         discord = super.discord.overrideAttrs (
#             _: { src = builtins.fetchTarball {
#                 url = "https://discord.com/api/download?platform=linux&format=tar.gz";
#                 sha256 = "0000000000000000000000000000000000000000000000000000"; # 52 0s
#             }; }
#         );
#     })
# ];
