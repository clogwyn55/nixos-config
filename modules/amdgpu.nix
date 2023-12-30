{ pkgs, ... }:

{
  boot.initrd.kernelModules = ["amdgpu"];

  hardware.opengl = {
    extraPackages = with pkgs; [ rocmPackages.clr.icd ];
    driSupport = true;
    driSupport32Bit = true;
  };

  systemd.tmpfiles.rules = [ # needed for rocm?
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
  
}
