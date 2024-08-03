{
	description = "My NixOS Flake";

    outputs = @inputs{ self, ... }:
    let
         # ---- SYSTEM SETTINGS ---- #
        systemSettings = {
            system = "x86_64-linux";
            hostname = "box";
            timezone = "America/Detroit";
            locale = "en_US.UTF-8";
            bootMode = "uefi";
            bootMountPath = "/boot";
            grubDevice = "";
            # gpuType = "nvidia"; # amd, intel or nvidia; only makes some slight mods for amd at the moment
            nixBranch = "stable";
        };
        # ----- USER SETTINGS ----- #
        userSettings = {
            username = "fox";
            name = "Sherlock";
            dotfilesDir = "~/.dotfiles";
            #theme = "io";
            wm = "hyprland";
            wmType = if (wm == "hyprland") then "wayland" else "x11";
            term = "alacritty"; # Default terminal command;
            # font = "Intel One Mono"; # Selected font
            editor = "nvim";
        };
        # ----- NIX-PACKAGES ----- #
        pkgs-stable = import inputs.nixpkgs-stable {
            system = systemSettings.system;
            config = {
                allowUnfree = true;
                allowUnfreePredicate = (_: true);
            };
        };
        pkgs-unstable = import inputs.nixpkgs-unstable {
            system = systemSettings.system;
            config = {
                allowUnfree = true;
                allowUnfreePredicate = (_: true);
            };
        };
        pkgs = (if (systemSettings.nixBranch == "stable")
            then
                pkgs-stable
            else
                pkgs-unstable
        );
        lib = pkgs.lib;
        home-manager = inputs.home-manager-stable;
        # pkgs = nixpkgs.legacyPackages.${systemSettings.system}
    in {
        homeConfigurations = {
            # fox - username
            fox = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./config/home.nix ];
                extraSpecialArgs = {
                    inherit pkgs-stable;
                    inherit pkgs-unstable;
                    inherit systemSettings;
                    inherit userSettings;
                    inherit inputs;
                };
            };
        };
        nixosConfigurations = {
            system = lib.nixosSystem {
                system = systemSettings.system;
                modules = [ ./config/configuration.nix ];
                specialArgs = {
                    inherit pkgs-stable;
                    inherit pkgs-unstable;
                    inherit systemSettings;
                    inherit userSettings;
                    inherit inputs;
                };
            };
        };
    };

    inputs = {
        
        nixpkgs.url = "nixpkgs/nixos-unstable";
        nixpkgs-stable.url = "nixpkgs/nixos-24.05";

        home-manager-unstable = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        
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

        stylix.url = "github:danth/stylix";

    };
}
