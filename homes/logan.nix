{ config, pkgs, ... }:

{
  imports = [ ./maya/laptop.nix ];

  home.packages = with pkgs; [
    # Handwriting
    xournalpp
    rnote

    # Dev
    vscode
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

    # misc
    ryzenadj
    ryzen-monitor-ng
    vial
  ];
}
