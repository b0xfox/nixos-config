{ pkgs, userSettings, ... }:
{
    imports = [
        ./modules/user/pgks/alacritty.nix
        ./modules/user/pgks/waybar.nix
        ./modules/user/wm/hyprland.nix
        ./pkgs/user.nix
    ];

    home = {
        username = userSettings.username;
        homeDirectory = "/home/${userSettings.username}";
        stateVersion = "24.05";

        sessionVariables = {
            EDITOR = userSettings.editor;
        };
    };

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
