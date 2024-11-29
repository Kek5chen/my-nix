self: super:
let
  unfreePredicate = import ./unfree-pkgs.nix self ;
  unstable = (import <nixpkgs-unstable> { config.allowUnfreePredicate = unfreePredicate; });
in
{
  ryujinx = unstable.callPackage ./programs/ryujinx/package.nix {};
  jetbrains = unstable.callPackage ./programs/jetbrains {};

  inherit (unstable)
    neovim
    #jetbrains
    gradle
    anydesk
    wineWowPackages
    heroic
    lutris;
}


