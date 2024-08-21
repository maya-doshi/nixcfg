{
  description = "maya-nixcfg";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }:
    let
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        logan = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/logan/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.maya = import ./homes/maya/laptop.nix;
            }
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
          ];
        };

        oliver = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/oliver/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.maya = import ./homes/maya/laptop.nix;
            }
          ];
        };
      };
    };
}
