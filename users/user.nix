{ home-manager, pkgs, ... }:

{
  programs.zsh.enable = true;
  users.users.willow.shell = pkgs.zsh;

  home-manager.users.willow = {
    imports = [ ./zsh ./hyprland ./wofi ];

    home.stateVersion = "24.11";
    home.username = "willow";
    home.homeDirectory = "/home/willow";
    
    programs.git = {
      enable = true;
      userName = "willow";
      userEmail = "52585984+Kek5chen@users.noreply.github.com";
    };
  };
}
