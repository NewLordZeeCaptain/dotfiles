{ config, pkgs, ... }:

{
  # Nvidia Configuraton
  hardware.nvidia =  {
    modesetting.enable = true;

    # Nvidia Power management
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # OpenSource kernel modules 
    open = false;

    # Enable nvidia settings
    nvidiaSettings = true;

    # Selecting driver version
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

}
