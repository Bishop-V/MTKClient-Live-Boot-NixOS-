# MTKClient-Live-Boot-NixOS-
This project is to create a reproducible and easily configureable Live Boot enviroment to use MTKClient.

The code shared here is to build an ISO using the NixOS live boot installer as the base. 

To build the Arm ISO from an x86_64 NixOS install you will need to add this to your configuration:
```
nix.settings.extra-platforms = [ "aarch64-linux" ];
boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
```

To build for x86_64:
```
sudo nixos-rebuild build-image --image-variant iso --flake .#mtkclient_x86_64
```

To build for aarch64:
```
sudo nixos-rebuild build-image --image-variant iso --flake .#mtkclient_aarch64
```
