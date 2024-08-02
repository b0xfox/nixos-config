{

  programs.hyprland.enable = true;

  environment.sessionVariables = {
    
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";

  };

  hardware = {

    opengl.enable = true;
    nvidia.modesetting.enable = true;

  };

}
