{ pkgs, lib, ... }:

let
  linux = pkgs.buildLinux rec {
    version = "6.18.26";
    modDirVersion = version;

    src = fetchTarball {
      url = "https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${version}.tar.xz";
      sha256 = "sha256:0ahcx78v71nspmyyhcb0rb27dv52apn531g9gxs4zscx3s1mrnfi";
    };

    # Inherit sensible defaults from the current kernel packages
    kernelPatches = [];
    structuredExtraConfig = {};
  };

  kernelPackages = pkgs.linuxPackagesFor linux;
in
{
  boot.kernelPackages = kernelPackages;

  boot.kernelPatches = [
    {
      name = "v7_20251216_bin_du_add_amd_isp4_driver";
      patch = pkgs.fetchurl {
        url = "https://lore.kernel.org/all/20251216091326.111977-1-Bin.Du@amd.com/t.mbox.gz";
        # hash can change due to mailing list stuff...
        hash = "sha256-6n3Lxut2wrreZUzkKoJ7L7ItYC7GPhw39aE9I8W8xcg=";
      };
    }
  ];
}
