{ config, pkgs, ... }:

{
  imports = [ ./maya/laptop.nix ];

  home.packages = with pkgs; [
    # Handwriting
    xournalpp
    rnote

    # Dev
    vscode
    zed-editor
    nodejs_22
    clang_14
    clang-tools_14
    cmake
    ninja
    gnumake
    zlib
    catch2
    boost
    libelf
    libdwarf
    elfutils
    libbfd
    gopls

    # music
    plexamp
    spotify
    spotify-player

    # misc
    ryzenadj
    ryzen-monitor-ng
    vial
    mixxx
    hexchat
    prismlauncher
    obs-studio
  ];
}
