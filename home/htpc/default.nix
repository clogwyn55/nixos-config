{ pkgs, ... }:
{
  programs.kodi.package = pkgs.kodi.withPackages (exts:
    [
    exts.kodi-launches-steam
    ]);
}
