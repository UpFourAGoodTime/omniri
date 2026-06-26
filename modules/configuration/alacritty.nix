{
  ...
}:
{
  flake.homeModules.alacritty-stylix =
    {
      config,
      lib,
      ...
    }:
    {
      options.stylix.targets.omniri-Alacritty.enable =
        config.lib.stylix.mkEnableTarget "omniri-Alacritty" true;

      config = lib.mkMerge [
        (lib.mkIf (config.stylix.enable && config.stylix.targets.omniri-Alacritty.enable) {

          programs.alacritty.settings = {

            window.opacity = config.stylix.opacity.terminal;

            font = with config.stylix.fonts; {
              normal = {
                family = monospace.name;
                style = "Regular";
              };
              size = sizes.terminal;
            };

            colors = with config.lib.stylix.colors.withHashtag; {
              primary = {
                foreground = base01;
                background = base05;
              };
              selection = {
                text = base01;
                background = base04;
              };
              cursor = {
                text = base04;
                cursor = base01;
              };
              normal = {
                black = base05;
                white = base00;
                red = base02;
                green = base03;
                yellow = base08;
                blue = base0C;
                magenta = base02;
                cyan = base0B;
              };
              bright = {
                black = base03;
                white = base07;
                red = bright-red;
                green = bright-green;
                yellow = bright-yellow;
                blue = bright-blue;
                magenta = bright-magenta;
                cyan = bright-cyan;
              };
            };

          };

        })
      ];

    };
}
