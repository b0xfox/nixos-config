{ pkgs, ... }: {

  users = {

    defaultUserShell = pkgs.alacritty;

    users.fox = {

        isNormalUser = true;
        description = "boxfox";
        extraGroups = [ "wheel" "video" "audio" "networkmanager" "lp" "scanner" ];
        # packages = with pkgs; [];
        initialPassword = "1234";
    };

  };

}
