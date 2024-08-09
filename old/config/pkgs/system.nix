{ pkgs, ... }:{

    environment.systemPackages = with pkgs; [

        # Wayland
        swww
        waybar
        rofi-wayland
        # xdg-desktop-portal-hyprland

        # CLI
        git
        wget
        # zsh
        # fish
        # kitty
        htop
        ranger
        fastfetch
        nano
        neovim
        # emacs
        # nixvim

    ];

}
