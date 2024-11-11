self: super:
let
  unstable = (import <nixpkgs-unstable> { });
in
{
  unstable.config.allowUnfreePredicate = pkg: builtins.elem (unstable.lib.getName pkg) [
    "clion"
  ];
  neovim = unstable.neovim;
  ryujinx = unstable.callPackage ./programs/ryujinx/package.nix {};
  jetbrains = unstable.jetbrains;
}


