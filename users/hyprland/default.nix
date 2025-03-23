{ pkgs, home, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      monitor=eDP-1,1920x1080@60,0x0,1
      monitor=eDP-1,addreserved,0,0,48,0

      exec-once=swaybg -i $NIXOS_CONFIG_DIR/pics/wallpaper.png
      # exec-once=foot --server
      exec-once=wlsunset -l -23 -L -46
      exec-once=eww daemon
      exec-once=eww open bar
      exec-once=dunst
    '';
    settings = {
      monitor = [
        "eDP-1,1920x1080@60,0x0,1"
        "eDP-1,addreserved,0,0,48,0"
      ];
      general = {
        gaps_in = 6;
	gaps_out = 12;
	border_size = 4;
	"col.active_border" = "0xffb072d1";
        "col.inactive_border" = "0xff292a37";
      };
      misc = {
        disable_splash_rendering = true;
      };
      decoration = {
        rounding = 8;
        drop_shadow = 0;
        shadow_range = 60;
        "col.shadow" = "0x66000000";
        blur = {
            enabled = true;
        };
      };
      animations = {
        enabled = 1;
	animation = [
          "windows,1,4,default,slide"
          "border,1,5,default"
          "fadeIn,1,5,default"
          "workspaces,1,3,default"
	];
      };
      dwindle.pseudotile = 0;
      windowrule = [
        # hm.. none yet
      ];
      bind = [
        "ALT,Return,exec,kitty"
        "ALTSHIFT,Q,killactive,"
        "ALT,V,togglefloating,"
        "ALT,R,exec,wofi --show run --xoffset=1670 --yoffset=12 --width=230px --height=984 --style=$HOME/.config/wofi.css --term=footclient --prompt=Run"
        "ALT,N,exec,cd ~/stuff/notes && footclient -a foot-notes sh -c \"nvim ~/stuff/notes/$(date '+%Y-%m-%d').md\""
        "ALT,F,fullscreen,0"

        "ALT,h,movefocus,l"
        "ALT,l,movefocus,r"
        "ALT,k,movefocus,u"
        "ALT,j,movefocus,d"

        "ALTSHIFT,h,movewindow,l"
        "ALTSHIFT,l,movewindow,r"
        "ALTSHIFT,k,movewindow,u"
        "ALTSHIFT,j,movewindow,d"
        
        "ALT,1,workspace,1"
        "ALT,2,workspace,2"
        "ALT,3,workspace,3"
        "ALT,4,workspace,4"
        "ALT,5,workspace,5"
        
        "ALTSHIFT,1,movetoworkspacesilent,1"
        "ALTSHIFT,2,movetoworkspacesilent,2"
        "ALTSHIFT,3,movetoworkspacesilent,3"
        "ALTSHIFT,4,movetoworkspacesilent,4"
        "ALTSHIFT,5,movetoworkspacesilent,5"
        
        ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
        ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
        ",XF86AudioRaiseVolume,exec,pamixer -i 5"
        ",XF86AudioLowerVolume,exec,pamixer -d 5"
      ];
    };
  };
  
  programs.eww = {
    enable = true;
    configDir = ./eww;
  };
}
