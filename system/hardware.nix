{ ... }:

{
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  hardware.opengl = {
     enable = true; 
     driSupport = true; 
     driSupport32Bit = true; 
  }; 

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  hardware.xpadneo.enable = true;
}
