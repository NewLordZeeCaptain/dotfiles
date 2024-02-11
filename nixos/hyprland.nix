{ config, pkgs, ... }:
let
  # Configure Video
  hasAmd = false;
  hasNvidia = true;

  # GPU-specific options
  gpuOptions = if hasNvidia then {
    driver = "nvidia";
    enableNvidia = true;
    extraPackages = [ pkgs.nvidia-settings pkgs.nvidia-vaapi-driver];
  } else if hasAmd then {
    driver = "amdgpu";
    enableAmd = true;
    extraPackages = [];
  } else { driver = "modesetting"; };
in 
{
# Configure xserver
  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager.lightdm.enable = true;
    videoDriver = gpuOptions.driver;
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
    webcord
    telegram-desktop
    grim
    slurp
    wl-clipboard
    mpd
    vlc
];
}
