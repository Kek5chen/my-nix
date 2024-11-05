{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      ipaexfont
      (nerdfonts.override { fonts = [ "0xProto" ]; })
    ];
    fontconfig.defaultFonts.serif = [ "0xProto" "Noto Sans CJK JP" ];
    fontconfig.defaultFonts.sansSerif = [ "0xProto" "Noto Serif CJK JP" ];
  };
}
