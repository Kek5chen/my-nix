{ pkgs, ... }:

{
  programs.steam.enable = true;
  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];

  hardware.steam-hardware.enable = true;

  services.monado = {
    enable = true;
    defaultRuntime = true;
  };

  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
    WMR_HANDTRACKING = "0";
  };
}
