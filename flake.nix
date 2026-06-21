{
  description = "haze";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, sops-nix, nixos-hardware, ... }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";


      overlays = [
        (
          final: prev: {
            unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          }
        )
        (import ./overlays/mpv.nix)
        (import ./overlays/unstable.nix)
      ];

    in {
      overlays.default = lib.composeManyExtensions overlays;

      nixosConfigurations = {
        logan = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/logan/configuration.nix
            sops-nix.nixosModules.sops
            { nixpkgs.overlays = overlays; }
          ];
        };

        richard = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/richard/configuration.nix
            sops-nix.nixosModules.sops
            nixos-hardware.nixosModules.lenovo-thinkpad-x220
            { nixpkgs.overlays = overlays; }
          ];
        };

        oliver = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/oliver/configuration.nix
            sops-nix.nixosModules.sops
            { nixpkgs.overlays = overlays; }
          ];
        };

        stefan = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/stefan/configuration.nix
            sops-nix.nixosModules.sops
            { nixpkgs.overlays = overlays; }
          ];
        };
      };
    };
}
