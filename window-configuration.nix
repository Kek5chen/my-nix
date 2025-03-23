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
  
  #programs.hyprland.enable = true;
  services.xserver.windowManager.i3.enable = true;
  
  environment.etc."hypr/hyprland.conf".source = ./hyprland/hyprland.conf;
  environment.etc."i3/config".source = ./users/i3/config;
}
