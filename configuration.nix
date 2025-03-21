# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

let
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
      ./programs/steam/steam.nix

      # Home Manager
      # <home-manager/nixos>
    ];

  nixpkgs.overlays = [ 
    (import ./unstable-overlay.nix)
    (import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz"))
  ];

  nix.settings.auto-optimise-store = true;
  nix.settings.cores = 16;
  nix.settings.max-jobs = "auto";
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.kernelModules = [
    "v4l2loopback"
  ];

  security.rtkit.enable = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "kx" ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos"; # Define your hostname.
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
      extraGroups = [ "wheel" "docker" "wireshark" ];
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
    # jetbrains.clion
    # jetbrains.rust-rover
    # jetbrains.idea-ultimate
    jetbrains-toolbox
    #qbittorrent
    postman
    anydesk
    # lutris
    discord
    winbox4
    nordpass
    # exodus
    bitwarden-desktop
(
      (pkgs.heroic-unwrapped.overrideAttrs (old: rec {
        buildPhase = ''
          runHook preBuild

          # Force Electron to pull binaries, not build from source
          export npm_config_build_from_source=false
          export electron_config_build_from_source=false
          export npm_config_runtime=electron
          export npm_config_disturl=https://atom.io/download/electron
          # e.g. pin a known Electron version:
          # export npm_config_target=25.8.5

          pnpm --offline electron-vite build
          pnpm --ignore-scripts prune --prod
          find node_modules/.bin -xtype l -delete

          runHook postBuild
        '';
      }))
    )

    # Free as in freedom
    librewolf
    vim
    wget
    neovim
    vlc
    preload
    easyeffects
    dunst
    btop
    protonup-qt
    ripgrep
    feh
    git
    gh
    gcc
    rar
    unrar
    nixfmt-rfc-style
    gradle
    glib
    jdk21
    pkg-config
    openssl.dev
    adwaita-qt6
    wineWowPackages.stable
    nmap
    tcpdump
    wireshark
    traceroute
    inetutils
    floorp
    gamemode
    rust-analyzer
    tor
    tor-browser

    # Rust
    # rustBin
    # clippy
    rustup

    xclip
    xsel
    file

    kdePackages.plasma-desktop
    kdePackages.plasma5support
    kdePackages.qt5compat
    kdePackages.dolphin
    kdePackages.konsole
    kdePackages.kate
    kdePackages.plasma-vault
    kdePackages.ksvg
    kdePackages.kirigami
    kdePackages.kirigami-addons
    kdePackages.wayland
    kdePackages.qtwayland
    sddm-astronaut
    libsForQt5.kirigami2


    atlauncher
    element-desktop
    ryujinx
    obs-studio
    wasabiwallet


    # JP typing
    fcitx5-mozc
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-31.7.7"
  ];

  programs.wireshark.enable = true;

  programs.gnupg.agent.enable = true;
  services.pcscd.enable = true;

  # networking.extraHosts =
  # ''
  #   127.0.0.1 www.youtube.com
  #   127.0.0.1 youtube.com
  #   127.0.0.1 m.youtube.com
  # '';

  nixpkgs.config.element-web.conf = {
    show_labs_settings = true;
    default_theme = "dark";
  };

  services.openssh.enable = true;
  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
    rootless.setSocketVariable = true;
  };

  services.mullvad-vpn.enable = true;

  environment.variables = {
    "__GL_SYNC_DISPLAY_DEVICE" = "DP-2";
    "VDPAU_NVIDIA_SYNC_DISPLAY_DEVICE" = "DP-2";
    "KWIN_X11_REFRESH_RATE" = 165000;
    "KWIN_X11_NO_SYNC_TO_VBLANK" = 1;
    "KWIN_X11_FORCE_SOFTWARE_VSYNC" = 1;
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

