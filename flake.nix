{
  description = "haze";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-24.11";
    };
    agenix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:ryantm/agenix";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, agenix, ... }:
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
            agenix.nixosModules.default
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
            agenix.nixosModules.default
            {
              environment.systemPackages = [ agenix.packages.x86_64-linux.default ];
            }
            { nixpkgs.overlays = overlays; }
          ];
        };

        # stefan coming soon
      };
    };
}
