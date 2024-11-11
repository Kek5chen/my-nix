{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      noto-fonts

      source-han-mono
      source-han-sans
      source-han-serif
      sarasa-gothic

      noto-fonts-cjk
      noto-fonts-emoji

      ipaexfont
      liberation_ttf
      (nerdfonts.override { fonts = [ "0xProto" ]; })
    ];

    fontDir.enable = true;
    fontconfig.enable = true;

    enableDefaultPackages = true;

    fontconfig.defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      monospace = [ "Source Han Mono" ];
      #serif = [ "0xProto" "Noto Sans CJK JP" ];
      serif = [ "Source Han Serif" "Noto Sans CJK JP" ];
      sansSerif = [ "0xProto" "Noto Serif CJK JP" ];
    };
  };
}
