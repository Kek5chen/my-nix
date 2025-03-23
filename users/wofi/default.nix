{ pkgs, lib, config, ... }:

{
  home.file.".config/wofi.css".source = ./wofi.css;
}
