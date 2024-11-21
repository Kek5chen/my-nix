self: super:
let
  unstable = (import <nixpkgs-unstable> { });
in
{
  unstable.config.allowUnfreePredicate = pkg: builtins.elem (unstable.lib.getName pkg) [
    "clion"
  ];

  ryujinx = unstable.callPackage ./programs/ryujinx/package.nix {};
  jetbrains = unstable.callPackage ./programs/jetbrains {};

  inherit (unstable)
    neovim
    #jetbrains
    gradle;
}


