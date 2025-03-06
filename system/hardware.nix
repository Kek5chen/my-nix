{ config, ... }:

{
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  hardware.graphics = {
     enable = true; 
     enable32Bit = true; 
  }; 
  
  hardware.nvidia = {
    open = false;
    nvidiaSettings = true;
    gsp.enable = true;
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  hardware.xpadneo.enable = true;
}
