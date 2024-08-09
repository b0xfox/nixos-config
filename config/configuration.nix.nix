{ config, pkgs, ... }:

{

    boot.loader = {
        efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot";  
        };
        grub = {
            enable = true;
            devices = [ "nodev" ];
            efiSupport = true;
            useOSProber = true;
        };
    };

    networking.hostName = "box";
    time.timeZone = "America/Detroit";
    i18n.defaultLocale = "en_US.UTF-8";
    environment.systemPackages = with pkgs; [ vim git ];

    services.xserver.enable = true;
    services.xserver.windowManager.hyprland.enable = true;
    services.xserver.displayManager.sddm.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    users = {
        fox = {

            isNormalUser = true;
            description = "boxfox";
            extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" ];
            # packages = with pkgs; [];
            initialPassword = "1234";
        };
    };

    system.autoUpgrade = {
        enable = true;
        channel = "https://nixos.org/channels/nixos-24.05";
    };

    # services.xserver.videoDrivers = [ "nvidia" ];

    system.stateVersion = "24.05";

}
