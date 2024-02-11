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
    # Enabling Qtile
    windowManager.qtile.enable = true;
        # extraPackages = if hasNvidia then [ pkgs.cudaPackages.nvidia_driver pkgs.nvidia-vaapi-driver] else [];
  };

  

  # Xdg Protal
  xdg.portal = {
    enable = true;
    config.common.default = "pkgs.xdg-desktop-portal-kde";
    extraPortals = [ pkgs.xdg-desktop-portal-kde];
  };
  
  environment.systemPackages = with pkgs; [
    # For Qtile
    dunst # Notification
    libnotify
    wireplumber # Sound & Videosharing
    grim
    slurp
    xclip
    mpd
    vlc
    picom # Compositor
    rofi # Launcher
    nitrogen # Wallpaper




  ];

}
