{ pkgs, config, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    kitty
    wofi
    swaybg
    eww
    wl-clipboard
    dunst
    foot
  ];
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  
  environment.etc."hypr/hyprland.conf".source = ./hyprland/hyprland.conf;
  environment.etc."i3/config".source = ./users/i3/config;
}
