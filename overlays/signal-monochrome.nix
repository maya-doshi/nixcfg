final: prev:
let
  signalTrayColor = "#ebdbb2";
  validColor = builtins.match "^#[[:xdigit:]]{6}$" signalTrayColor != null;
  trayIcon = builtins.toFile "signal-tray.svg" (
    builtins.replaceStrings
      [ "#ffffff" ]
      [ signalTrayColor ]
      (builtins.readFile ./../assets/signal-tray.svg)
  );
in
assert prev.lib.assertMsg validColor "signalTrayColor must be a six-digit RGB hex color, such as #ffffff";
{
  signal-desktop = prev.signal-desktop.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or [ ])
      ++ prev.lib.optionals prev.stdenv.hostPlatform.isLinux [ prev.librsvg ];

    postPatch = (old.postPatch or "") + prev.lib.optionalString prev.stdenv.hostPlatform.isLinux ''
      icon=${trayIcon}
      dir=images/tray-icons/base

      rsvg-convert -w 16 -h 16 "$icon" -o "$dir/signal-tray-icon-16x16-base.png"
      rsvg-convert -w 32 -h 32 "$icon" -o "$dir/signal-tray-icon-32x32-base.png"
      rsvg-convert -w 48 -h 48 "$icon" -o "$dir/signal-tray-icon-48x48-base.png"
      rsvg-convert -w 256 -h 256 "$icon" -o "$dir/signal-tray-icon-256x256-base.png"
    '';
  });
}
