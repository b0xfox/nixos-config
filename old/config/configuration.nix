{ pkgs, lib, systemSettings, userSettings ... }:

{
    imports = [
        ./modules/system/hardware/hardware-configuration.nix
        ./modules/system/hardware/bootloader.nix
        ./modules/system/hardware/bluetooth.nix
        ./modules/system/hardware/printing.nix
        ./modules/system/hardware/sound.nix
        ./modules/system/hardware/opengl.nix
        ./modules/system/security/firewall.nix
        ./modules/system/env.nix
        ./modules/system/fonts.nix
        ./modules/system/networking.nix
        ./modules/system/wm/hyprland.nix
        ./pkgs/system.nix
    ];

    networking.hostName = systemSettings.hostname;
    time.timeZone = systemSettings.timezone;
    i18n.defaultLocale = systemSettings.locale;

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
