{ config, pkgs, ... }:

{
# Configure xserver
  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager.lightdm.enable = true;
    videoDriver = "amdgpu";
  };

  

  # Xdg Protal
  xdg.portal = {
    enable = true;
    config.common.default = "pkgs.xdg-desktop-portal-hyprland";
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland];
  };

  # Hyprland

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };


    # For Hyprland (Doesn't work on nvidia)
  environment.systemPackages = with pkgs; [

    hyprland
    hyprland-protocols
    xdg-desktop-portal-hyprland
    kitty
    ranger
    waybar
    dunst
    libnotify
    hyprpaper
    rofi-wayland
    wireplumber
    grim
    slurp
    wl-clipboard
];
}
