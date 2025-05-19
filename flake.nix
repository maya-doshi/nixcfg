{
  description = "haze";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-24.11";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }:
    let
      lib = nixpkgs.lib;

      overlays = [
        (import ./overlays/mpv.nix)
      ];

    in {
      overlays.default = lib.composeManyExtensions overlays;

      nixosConfigurations = {
        logan = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/logan/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.maya = import ./homes/logan.nix;
            }
            { nixpkgs.overlays = overlays; }
          ];
        };

        richard = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/richard/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.maya = import ./homes/maya/richard.nix;
            }
            nixos-hardware.nixosModules.lenovo-thinkpad-x220
            { nixpkgs.overlays = overlays; }
          ];
        };

        # stefan coming soon
        # but first his mutant child
        stefyle = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/stefyle/configuration.nix
            { nixpkgs.overlays = overlays; }
          ];
        };
      };
    };
}
