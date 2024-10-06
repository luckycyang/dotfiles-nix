{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    swww.url = "github:LGFae/swww";
    nur.url = "github:nix-community/NUR";
    mynur.url = "github:luckycyang/nur-packages";
    mynur.inputs.nixpkgs.follows = "nixpkgs";
    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
    jovian.inputs.nixpkgs.follows = "nixpkgs-unstable";
    nixvim.url = "github:luckycyang/nixvim";
    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
  };

  outputs = inputs@{ nixpkgs, home-manager, nixpkgs-unstable, nixos-hardware, swww, mynur, nixvim, ... }:
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowBroken = true;
        config.allowUnfree = true;
        config.nvidia.acceptLicense = true;
        overlays = [ inputs.nixpkgs-wayland.overlay inputs.nur.overlay ];
      };
    in
    {
      nixosConfigurations = {
        luckynix = nixpkgs.lib.nixosSystem rec {
          inherit system;
          specialArgs = { inherit pkgs-unstable mynur nixvim inputs; };
          modules = [
            ./hosts/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.dingduck = import ./home/home.nix;
              home-manager.extraSpecialArgs = inputs // { inherit system pkgs-unstable; };
            }
            (_: {
              nixpkgs.overlays = [
                (final: prev: {
                  v2raya = prev.v2raya.override { v2ray = final.xray; };
                })
              ];
            })

          ];
        };
      };
    };
}
