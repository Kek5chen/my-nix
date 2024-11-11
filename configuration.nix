# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

let
#  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  rustBin = pkgs.rust-bin.nightly.latest.default.override {
    extensions = [ "rust-src" ];
    targets = [ "x86_64-pc-windows-gnu" ];
  };
in
{
  imports =
    [
      ./hardware-configuration.nix

      ./system/hardware.nix
      ./system/fonts.nix
      ./system/keys.nix
      ./system/sound.nix
      ./system/windowing.nix

      ./programs/zsh/shell.nix
      ./programs/nordvpn/nordvpn.nix
      ./programs/steam/steam.nix

      # Home Manager
      #(import "${home-manager}/nixos")
    ];

  nixpkgs.overlays = [ (import ./unstable-overlay.nix) (import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz")) ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.supportedFilesystems = [ "ntfs" ];

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;

    users.kx = {
      isNormalUser = true;
      extraGroups = [ "wheel" "nordvpn" "docker" ];
      packages = with pkgs; [
        tree
      ];
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Unfree
    vesktop
    spotify
    steam
    brave
    jetbrains.clion
    jetbrains.rust-rover
    qbittorrent

    # Free as in freedom
    librewolf
    vim
    wget
    neovim
    heroic
    vlc
    preload
    easyeffects
    btop
    protonup-qt
    ripgrep
    git
    gh
    gcc
    rar
    unrar
    nixfmt-rfc-style

    # Rust
    rustBin

    xclip
    xsel
    file

    kdePackages.plasma-desktop
    kdePackages.plasma5support
    kdePackages.qt5compat
    kdePackages.sddm
    kdePackages.dolphin
    kdePackages.konsole
    kdePackages.kate
    kdePackages.kirigami
    kdePackages.plasma-vault
    kdePackages.ksvg

    element-desktop
    ryujinx
    obs-studio


    # JP typing
    fcitx5-mozc

    atlauncher
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
   "spotify"
   "atlauncher"

   "steam"
   "steam-run"
   "steam-original"

   "nordvpn"

   "clion"
   "rust-rover"

   "nvidia-x11"
   "nvidia-settings"

   "rar"
   "unrar"

   "xow_dongle-firmware"
  ];
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  nixpkgs.config.element-web.conf = {
    show_labs_settings = true;
    default_theme = "dark";
  };

  services.openssh.enable = true;
  services.unclutter.enable = true;
  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
    rootless.setSocketVariable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  # # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

