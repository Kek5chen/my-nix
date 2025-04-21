{ pkgs, lib, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  # services.desktopManager.plasma6.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.displayManager.gdm.enable = true;

  services.displayManager = {
    autoLogin.enable = false;
    autoLogin.user = "kx";
    defaultSession = "gnome-xorg";
  };

  environment.systemPackages = with pkgs; [
    playerctl
    xorg.xbacklight
  ];
}
