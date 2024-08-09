{ pkgs, ... }:{

    home.packages = with pkgs; [

        ### === APPS === ###
        brave
        alacritty
        # firefox
        # gimp
        # discord
        # obsidian
        # audacity
        # blockbench
        # prismlauncher
        # obs-studio
        # kdePackages.kdenlive

        ### === CLI === ###
        # spotify-player

        ### === CODING === ###
        # godot_4
        # vscode
        # zed-editor
        # unityhub

        ### === GAMING === ###
        # steam

    ];

}
