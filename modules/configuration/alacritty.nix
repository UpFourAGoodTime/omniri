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

      config = lib.mkIf (config.stylix.enable && config.stylix.targets.omniri-Alacritty.enable) {

        home.file = {
          ".config/alacritty/alacritty.toml".text = ''
            [colors.primary]
            background = '${config.lib.stylix.colors.withHashtag.base06}'
            foreground = '${config.lib.stylix.colors.withHashtag.base01}'

            [colors.vi_mode_cursor]
            text = '${config.lib.stylix.colors.withHashtag.base01}'
            cursor = '${config.lib.stylix.colors.withHashtag.base06}'

            [colors.selection]
            text = '${config.lib.stylix.colors.withHashtag.base01}'
            background = '${config.lib.stylix.colors.withHashtag.base04}'

            [colors.normal]
            black = '#181818'
            red = '${config.lib.stylix.colors.withHashtag.base02}'
            green = '${config.lib.stylix.colors.withHashtag.base03}'
            yellow = '${config.lib.stylix.colors.withHashtag.base08}'
            blue = '${config.lib.stylix.colors.withHashtag.base0C}'
            magenta = '${config.lib.stylix.colors.withHashtag.base02}'
            cyan = '${config.lib.stylix.colors.withHashtag.base0B}'
            white = '#BAC2DE'

            [colors.bright]
            black = '#585B70'
            red = '#F38BA8'
            green = '#A6E3A1'
            yellow = '#F9E2AF'
            blue = '#89B4FA'
            magenta = '#F5C2E7'
            cyan = '#94E2D5'
            white = '#A6ADC8'


            [colors.dim]
            black = '#45475A'
            red = '#F38BA8'
            green = '#A6E3A1'
            yellow = '#F9E2AF'
            blue = '#89B4FA'
            magenta = '#F5C2E7'
            cyan = '#94E2D5'
            white = '#BAC2DE'

            [window]
            opacity = 0.8
          '';
        };
      };
    };
}
