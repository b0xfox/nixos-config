{ pkgs, ... }:{

    environment.systemPackages = with pkgs; [

        # Wayland
        hyprland
        swww
        waybar
        rofi-wayland
        # xdg-desktop-portal-hyprland

        # CLI
        git
        wget
        alacritty
        # zsh
        # fish
        # kitty
        htop
        ranger
        fastfetch
        nano
        neovim
        emacs
        #nixvim

        # Misc
        home-manager

    ];

}
