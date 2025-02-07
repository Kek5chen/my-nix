self: super:
let
  unfreePredicate = import ./unfree-pkgs.nix self;
  # TODO: Remove this at some point
  permittedInsecurePackages = [
    "dotnet-sdk-wrapped-7.0.410"
    "dotnet-sdk-7.0.410"
  ];
  unstable = (import <nixpkgs-unstable> {
    config.allowUnfreePredicate = unfreePredicate; 
    config.permittedInsecurePackages = permittedInsecurePackages; 
  });
in
{
  ryujinx = unstable.callPackage ./programs/ryujinx/package.nix {};
  jetbrains = unstable.callPackage ./programs/jetbrains {};

  inherit (unstable)
    jetbrains-toolbox
    neovim
    #jetbrains
    gradle
    anydesk
    wineWowPackages
    heroic
    lutris
    nordpass
    spotify
    brave;
}


