{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./base.nix
    ];

  environment.systemPackages = with pkgs; [
    openssl
    tmux
    sshfs
    waypipe
    rclone
    python3
    tlrc
    ripgrep
    hdparm
    smartmontools
    pciutils
    usbutils
    lshw
    p7zip
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.fuse.userAllowOther = true;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "no";
    };
    tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };
  };
}
