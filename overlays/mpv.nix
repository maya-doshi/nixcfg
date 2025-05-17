final: prev: {
  mpv-unwrapped = prev.mpv-unwrapped.override {
    waylandSupport = true;
    cddaSupport = true;
    sixelSupport = true;
  };
}
