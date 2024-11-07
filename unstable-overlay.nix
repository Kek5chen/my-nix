self: super: {
  neovim = (import <nixpkgs-unstable> { }).neovim;
  ryujinx = ((import <nixpkgs-unstable> {}).callPackage ./programs/ryujinx/package.nix {});
}

