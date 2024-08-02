{ config, lib, pkgs, ... }: {
    
    imports = [
        ./hardware-configuration.nix
        ./os-modules/bundle.nix
        ./os-modules/system_packages.nix
    ];

    networking.hostName = "box";

    services.xserver.videoDrivers = [ "nvidia" ];

    nix.settings.experimental-featuress = [ "nix-command" "flakes" ];

    services.printing.enable = true;

    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "24.05";
}
