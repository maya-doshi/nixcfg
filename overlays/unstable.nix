final: prev: {
  feishin = prev.unstable.feishin;
  xwayland-satellite = prev.unstable.xwayland-satellite;
  plex = prev.unstable.plex;
  navidrome = prev.unstable.navidrome;
  memos = prev.unstable.memos;
  karakeep = prev.unstable.karakeep;
  baikal = prev.unstable.baikal;
  kavita = prev.kavita.overrideAttrs (old: {
    backend = old.backend.overrideAttrs (oldBackend: {
      patches = (oldBackend.patches or []) ++ [
        (final.fetchpatch {
         url = "https://patch-diff.githubusercontent.com/raw/maya-doshi/Kavita/pull/1.patch";
         hash = "sha256-0Ug84gyiRPAUCnSpYRo5Tndq1j8z2b2LRc8rOwspFVw=";
        })
        (final.fetchpatch {
         url = "https://github.com/maya-doshi/Kavita/commit/4db108a58e85f11ed76ac9f3dcb435ce2d6fdd80.patch";
         hash = "sha256-KjEOU+FMb8sSKfOgnXKUvOwIxl/52V7lhGcwhgVw2DU=";
        })
      ];
    });
  });
}
