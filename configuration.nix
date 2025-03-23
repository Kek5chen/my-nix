# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, home-manager, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <home-manager/nixos>
      ./hardware-configuration.nix
      ./users/kx.nix
      ./window-configuration.nix
      ./programs/nordvpn/nordvpn.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth.enable = true;

  networking.hostName = "meowtop"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  #console = {
  #  font = "Lat2-Terminus16";
  #  keyMap = "us";
  #  useXkbConfig = true; # use xkb.options in tty.
  #};
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    fira-code
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [ "FiraCode Nerd Font" ];
    sansSerif = [ "FiraCode Nerd Font" ];
    serif     = [ "FiraCode Nerd Font" ];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable VPN
  # services.mullvad-vpn.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Fix audio cracking / Add realtime support
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."kx" = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "wireshark" "docker" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    zsh
    floorp
    ripgrep
    vesktop
    spotify-player
    unzip
    btop
    libreoffice
    nix-search-cli
    thunderbird
    pulseaudio
    speedcrunch
    light
    outils
    spotify
    nodejs
    lldb
    fd
    exodus
    bitwarden
    tree-sitter
    nil

    # Networking Tools
    nmap
    wireshark-cli
    tcpdump
    masscan
    openvpn
    proxychains-ng
    curl
    wget
    socat

    # Exploitation Tools
    metasploit
    exploitdb
    sqlmap
    hydra
    john
    hashcat
    aircrack-ng
    burpsuite
    dirb
    gobuster
    wfuzz

    # Reverse Engineering Tools
    radare2
    ghidra
    binwalk
    strace
    ltrace
    gdb
    apktool
    bytecode-viewer
    jadx
    #cutter

    # Forensics Tools
    autopsy
    testdisk
    foremost
    scalpel
    stegsolve
    exiftool
    tshark

    # Cryptography Tools
    hashcat
    ccrypt
    cryptsetup
    stegsolve
    yubikey-manager
    openssl

    # Scripting and Development
    #python3
    #python3Packages.pip
    #python3Packages.requests
    #python3Packages.flask
    #ruby
    #rubyPackages.nokogiri
    #perl
    #rust
    #openjdk
    #nodejs
    ruby

    # Debugging and System Tools
    htop
    iotop
    lsof
    netcat
    ncdu
    tmux
    screen
    vim
    nano

    # Additional Tools
    ffuf
    bloodhound
    neo4j
    dnsenum
    amass
    subfinder
    nikto
    theharvester

    # Useful Utilities
    jq
    csvkit
    imagemagick
    zsh
    bash

    # Wordlists
    wordlists

    # Unfree
    steam
  ];

  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.neovim = {
    enable = true;

    withRuby = true;
    withNodeJs = true;
    withPython3 = true;

    vimAlias = true;
    viAlias = true;

    defaultEditor = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

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
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

  services.sshd = {
    enable = true;
  };

  virtualisation.docker.enable = true;
}

