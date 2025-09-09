final: prev: {
  xwayland-satellite = prev.unstable.xwayland-satellite;
  plex = prev.unstable.plex;
  navidrome = prev.unstable.navidrome;
  memos = prev.unstable.memos;
  karakeep = prev.unstable.karakeep;
  kavita = prev.unstable.kavita.overrideAttrs (old: {
    backend = old.backend.overrideAttrs (oldBackend: {
      patches = (oldBackend.patches or []) ++ [
        (final.fetchpatch {
          url = "https://patch-diff.githubusercontent.com/raw/maya-doshi/Kavita/pull/1.patch";
          hash = "sha256-0Ug84gyiRPAUCnSpYRo5Tndq1j8z2b2LRc8rOwspFVw=";
        })
      ];
    });
  });
}
