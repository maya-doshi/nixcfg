{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./base.nix
    ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    tmux
    curl
    git
  ];

  virtualisation.docker = {
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    storageDriver = "btrfs";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services = {
    openssh.enable = true;
    tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };
  };
}
