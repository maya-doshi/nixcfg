{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../nixosModules
    ];

  environment.systemPackages = with pkgs; [
    age
    nh
    btop
    fish
    wget
    curl
    git
    tmux
  ];

  sops = {
    defaultSopsFile = "./secrets/keys.yaml";
    age.keyFile = "~/.config/sops/secrets/age-key.txt";
  };

  nixpkgs.config.allowUnfree = true;

  # Enable networking
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  programs.nix-ld.enable = true;

  system.stateVersion = "25.11";
}
