{ home-manager, pkgs, ... }:

{
  programs.zsh.enable = true;
  users.users.kx.shell = pkgs.zsh;

  home-manager.users.kx = {
    imports = [ ./zsh ./hyprland ./wofi ];

    home.stateVersion = "24.11";
    home.username = "kx";
    home.homeDirectory = "/home/kx";
    
    programs.git = {
      enable = true;
      userName = "willow";
      userEmail = "52585984+Kek5chen@users.noreply.github.com";
    };
  };
}
