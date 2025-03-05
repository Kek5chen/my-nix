{ pkgs, lib, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  # services.desktopManager.plasma6.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.windowManager.hypr.enable = true;

  services.xserver.windowManager.i3.enable = true;
  services.picom.enable = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.package = lib.mkForce pkgs.kdePackages.sddm;
  services.displayManager.sddm.theme = "sddm-astronaut-theme";

  services.displayManager = {
    autoLogin.enable = false;
    autoLogin.user = "kx";
    defaultSession = "xfce+i3";
  };

  environment.systemPackages = with pkgs; [
    playerctl
    xorg.xbacklight
  ];
}
