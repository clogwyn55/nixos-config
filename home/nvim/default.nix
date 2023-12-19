{ pkgs, ... }:
{
  home.packages = [
	pkgs.lua-language-server
	pkgs.nil
    pkgs.docker-compose-language-service
    pkgs.pylyzer
    pkgs.taplo
    pkgs.lemminx
  ];
    
  home.file."/.config/nvim" = {
    source = ./config;
    recursive = true;
  };
}
