{ home-manager, pkgs, ... }:

{
  home.shellAliases = with pkgs; {
    nrs = "sudo nixos-rebuild switch";
    n = "nvim";
    nix-shell = "nix-shell --run \"${pkgs.zsh}/bin/zsh\"";

    gst = "${git}/bin/git status";
    gco = "${git}/bin/git checkout";
    gc = "${git}/bin/git commit";
    gp = "${git}/bin/git push";
    gpl = "${git}/bin/git pull --rebase";
    gcl = "${git}/bin/git clone";
    ga = "${git}/bin/git add";
  };


  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "darkblood";
    };
  };
}
