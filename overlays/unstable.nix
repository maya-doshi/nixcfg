final: prev: {
  xwayland-satellite = prev.unstable.xwayland-satellite;
  plex = prev.unstable.plex;
  navidrome = prev.unstable.navidrome;
  memos = prev.unstable.memos;
  karakeep = prev.unstable.karakeep;
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
  tautulli = prev.unstable.tautulli.overrideAttrs (old: {
    patches = (old.patches or []) ++ [
      (final.fetchpatch {
        url = "https://github.com/maya-doshi/Tautulli/commit/7d2384c072dfdd0255b6d17f06cd3af74d63c077.patch";
        hash = "sha256-vw0Qq7hqdUx1bVRxXqEneaNKE1vlDSlwLrtoUnfX8aE=";
      })
    ];
    propagatedBuildInputs = (old.propagatedBuildInputs or []) ++ [
      final.python313Packages.pylast
    ];
    pythonPath = (old.pythonPath or []) ++ [
      final.python313Packages.pylast
    ];
  });
}
