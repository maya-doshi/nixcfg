{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.haze.services.emacs.enable {
    services.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
    };
  };
}
