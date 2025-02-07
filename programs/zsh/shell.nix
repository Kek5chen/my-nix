{ config, pkgs, ... }:

{
  programs = {
    command-not-found.enable = false;

    zsh = {
      enable = true;
      enableCompletion = true;
      
      ohMyZsh = {
        enable = true;
        theme = "darkblood";
      };

      shellAliases = with pkgs; {
        nrs = "sudo nixos-rebuild switch";
        n = "${neovim}/bin/nvim";
        vi = "${neovim}/bin/nvim";
        vim = "${neovim}/bin/nvim";

        gst = "${git}/bin/git status";
        gco = "${git}/bin/git checkout";
        gc = "${git}/bin/git commit";
        gp = "${git}/bin/git push";
        gpl = "${git}/bin/git pull --rebase";
        gcl = "${git}/bin/git clone";
        ga = "${git}/bin/git add";
      };

      shellInit = ''
        export NP=$HOME/dev/nix/nixpkgs
      '';
    };
  };
}
