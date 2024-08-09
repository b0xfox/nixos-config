{ pkgs, ... }:

{
  home.packages = with pkgs; [ neovim zsh ];

  programs.zsh.enable = true;
  programs.zsh.ohMyZsh.enable = true;

  programs.hyprland.enable = true;
  programs.hyprland.config = {
    # Hyprland-specific configuration
  };
}
