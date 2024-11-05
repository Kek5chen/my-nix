{ ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "kx";
    defaultSession = "plasmax11";
  };
}
