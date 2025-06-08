{
  description = "haze";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-25.05";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
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
              home-manager.extraSpecialArgs = {inherit self;};
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
              home-manager.extraSpecialArgs = {inherit self;};
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension="bak";
              home-manager.users.maya = import ./homes/richard.nix;
            }
            nixos-hardware.nixosModules.lenovo-thinkpad-x220
            { nixpkgs.overlays = overlays; }
          ];
        };

        oliver = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/oliver/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.extraSpecialArgs = {inherit self;};
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.haze = import ./homes/desktop.nix;
            }
            { nixpkgs.overlays = overlays; }
          ];
        };

        stefan = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/stefan/configuration.nix
            { nixpkgs.overlays = overlays; }
          ];
        };
      };
    };
}
