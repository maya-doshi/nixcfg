{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.haze.apps.sioyek.enable {
    programs.sioyek = {
      enable = true;
      config = {
        "custom_color_contrast" = "0.3";
        "custom_color_mode_empty_background_color" = "#282828";
        "page_separator_color" = "#282828";
        "page_separator_width" = "0";
        "custom_background_color" = "#282828";
        "custom_text_color" = "#ebdbb2";
        "search_highlight_color" = "#7ec16e";
        "status_bar_color" = "#8ec07c";
        "status_bar_text_color" = "#282828";
        "startup_commands" = "toggle_custom_color";
      };
      bindings = {
        "next_page;goto_top_of_page" = "J";
        "previous_page;goto_top_of_page" = "K";
        "toggle_custom_color" = "<C-r>";
      };
    };
  };
}
