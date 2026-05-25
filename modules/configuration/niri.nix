{
  self,
  inputs,
  ...
}:
{

  flake.homeModules.niri-stylix =
    {
      config,
      lib,
      ...
    }:
    {
      options.stylix.targets.omniri-niri.enable = config.lib.stylix.mkEnableTarget "omniri-Niri" true;

      config = lib.mkIf (config.stylix.enable && config.stylix.targets.omniri-niri.enable) {

        home.file = {

          ".config/niri-stylix/colors.kdl".text = ''
            layout {

            focus-ring {
            on

            // How many logical pixels the ring extends out from the windows. base0D
            width 4

            active-gradient from="${config.lib.stylix.colors.withHashtag.base03}" to="${config.lib.stylix.colors.withHashtag.base01}" angle=180

            }
            }

            overview {
                backdrop-color "${config.lib.stylix.colors.withHashtag.base06}"
            }
          '';
        };
      };
    };

  flake.nixosModules.niri =
    {
      pkgs,
      lib,
      ...
    }:
    {

      imports = [
      ];

      environment.systemPackages = [
        pkgs.bibata-cursors
        (self.packages.${pkgs.stdenv.hostPlatform.system}.omniri-Noctalia)
      ];

      services = {
        displayManager.sddm.enable = lib.mkDefault true;
        displayManager.sddm.wayland.enable = lib.mkDefault true;
      };

      programs.niri = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.omniri-Niri;
      };
    };

  perSystem =
    {
      pkgs,
      lib,
      ...
    }:
    {
      packages.omniri-Niri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;

        "config.kdl".content = ''
          spawn-at-startup "${lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.omniri-Noctalia}"

          spawn-at-startup "${
            lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.omniri-Noctalia
          }" "ipc" "call" "wallpaper" "set" "${
            self.packages.${pkgs.stdenv.hostPlatform.system}.wallpapers
          }/share/wallpapers/pb293788xdcqhv8yhjan3w238dw724fr-files/wallhaven-k81776_2880x1620.png" "eDP-1"

          prefer-no-csd

          xwayland-satellite {
          path "${lib.getExe pkgs.xwayland-satellite}"
          }

          window-rule {
              geometry-corner-radius 12
              clip-to-geometry true
              draw-border-with-background false
          }

          cursor {
              xcursor-theme "Bibata-Modern-Classic"
              xcursor-size 20

              hide-when-typing
          }

          input {
            keyboard {
            xkb {
                layout "us"
            }

            // repeat-delay 600
            // repeat-rate 25
            // track-layout "global"
            numlock
            }

            touchpad {
                tap
                natural-scroll
            }

            focus-follows-mouse "max-scroll-amount"="0%" {
            }
          }
          binds {

              XF86AudioRaiseVolume allow-when-locked=true { spawn "${
                lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.omniri-Noctalia
              }" "ipc" "call" "volume" "increase"; }
              XF86AudioLowerVolume allow-when-locked=true { spawn "${
                lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.omniri-Noctalia
              }" "ipc" "call" "volume" "decrease"; }
              XF86AudioMute allow-when-locked=true { spawn "${
                lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.omniri-Noctalia
              }" "ipc" "call" "volume" "muteOutput"; }
              XF86MonBrightnessUp allow-when-locked=true { spawn "${
                lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.omniri-Noctalia
              }" "ipc" "call" "brightness" "increase"; }
              XF86MonBrightnessDown allow-when-locked=true { spawn "${
                lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.omniri-Noctalia
              }" "ipc" "call" "brightness" "decrease"; }

              Mod+1 { focus-workspace 1; }
              Mod+2 { focus-workspace 2; }
              Mod+3 { focus-workspace 3; }
              Mod+4 { focus-workspace 4; }
              Mod+5 { focus-workspace 5; }
              Mod+6 { focus-workspace 6; }
              Mod+7 { focus-workspace 7; }
              Mod+8 { focus-workspace 8; }
              Mod+9 { focus-workspace 9; }
              Mod+Ctrl+1 { move-column-to-workspace 1; }
              Mod+Ctrl+2 { move-column-to-workspace 2; }
              Mod+Ctrl+3 { move-column-to-workspace 3; }
              Mod+Ctrl+4 { move-column-to-workspace 4; }
              Mod+Ctrl+5 { move-column-to-workspace 5; }
              Mod+Ctrl+6 { move-column-to-workspace 6; }
              Mod+Ctrl+7 { move-column-to-workspace 7; }
              Mod+Ctrl+8 { move-column-to-workspace 8; }
              Mod+Ctrl+9 { move-column-to-workspace 9; }

              Mod+Page_Up { focus-workspace-up; }
              Mod+Page_Down { focus-workspace-down; }

              Mod+Up    { focus-window-up; }
              Mod+Down  { focus-window-down; }
              Mod+Right { focus-column-right; }
              Mod+Left { focus-column-left; }

              Mod+R { focus-workspace-up; }
              Mod+F { focus-workspace-down; }

              Mod+W { focus-window-up; }
              Mod+S { focus-window-down; }
              Mod+D { focus-column-right; }
              Mod+A { focus-column-left; }

              Mod+Ctrl+Page_Up { move-column-to-workspace-up; }
              Mod+Ctrl+Page_Down { move-column-to-workspace-down; }

              Mod+Ctrl+Up { move-window-up; }
              Mod+Ctrl+Down { move-window-down; }
              Mod+Ctrl+Right { move-column-right; }
              Mod+Ctrl+Left { move-column-left; }

              Mod+Ctrl+R { move-column-to-workspace-up; }
              Mod+Ctrl+F { move-column-to-workspace-down; }

              Mod+Ctrl+W { move-window-up; }
              Mod+Ctrl+S { move-window-down; }
              Mod+Ctrl+D { move-column-right; }
              Mod+Ctrl+A { move-column-left; }

              Mod+Minus { set-column-width "-5%"; }
              Mod+Equal { set-column-width "+5%"; }
              Mod+Shift+Minus { set-window-height "-5%"; }
              Mod+Shift+Equal { set-window-height "+5%"; }

              Mod+Z cooldown-ms=250 { spawn "${
                lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.omniri-Noctalia
              }" "ipc" "call" "launcher" "toggle"; }

              Mod+Q cooldown-ms=50 { close-window; }

              Mod+T cooldown-ms=500 { spawn "${lib.getExe pkgs.alacritty}"; }

              Mod+O cooldown-ms=250 { toggle-overview; }


          }

          layout {

          focus-ring {
              // Uncomment this line to disable the focus ring.
              // on

              // How many logical pixels the ring extends out from the windows.
              width 4

              // Colors can be set in a variety of ways:
              // - CSS named colors: "red"
              // - RGB hex: "#rgb", "#rgba", "#rrggbb", "#rrggbbaa"
              // - CSS-like notation: "rgb(255, 127, 0)", rgba(), hsl() and a few others.

              // Color of the ring on the active monitor.
              active-color "#7fc8ff"

              // Color of the ring on inactive monitors.
              inactive-color "#505050"

              // You can also use gradients. They take precedence over solid colors.
              // Gradients are rendered the same as CSS linear-gradient(angle, from, to).
              // The angle is the same as in linear-gradient, and is optional,
              // defaulting to 180 (top-to-bottom gradient).
              // You can use any CSS linear-gradient tool on the web to set these up.
              // Changing the color space is also supported, check the wiki for more info.
              //
              // active-gradient from="rgb(85, 145, 74)" to="rgb(67, 121, 72)" angle=180

              // You can also color the gradient relative to the entire view
              // of the workspace, rather than relative to just the window itself.
              // To do that, set relative-to="workspace-view".
              //
               inactive-gradient from="#505050" to="#808080" angle=45 relative-to="workspace-view"
          }

          }

          animations {
              // Uncomment to turn off all animations.
              // You can also put "off" into each individual animation to disable it.
              // off

              // Slow down all animations by this factor. Values below 1 speed them up instead.
               slowdown 3.0

              // Individual animations.

              workspace-switch {
                  spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
              }

              window-open {
                  duration-ms 150
                  curve "ease-out-expo"
              }

              window-close {
                 duration-ms 300
                 curve "linear"
                 custom-shader r"
                   vec4 fall_and_rotate(vec3 coords_geo, vec3 size_geo) {
                       float progress = niri_clamped_progress * niri_clamped_progress;
                       vec2 coords = (coords_geo.xy - vec2(0.5, 1.0)) * size_geo.xy;
                       coords.y -= progress * 1440.0;
                       float random = (niri_random_seed - 0.5) / 2.0;
                       random = sign(random) - random;
                       float max_angle = 0.5 * random;
                       float angle = progress * max_angle;
                       mat2 rotate = mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
                       coords = rotate * coords;
                       coords_geo = vec3(coords / size_geo.xy + vec2(0.5, 1.0), 1.0);
                       vec3 coords_tex = niri_geo_to_tex * coords_geo;
                       vec4 color = texture2D(niri_tex, coords_tex.st);
                       return color * (1.0 - niri_clamped_progress);
                   }
                   vec4 close_color(vec3 coords_geo, vec3 size_geo) {
                      return fall_and_rotate(coords_geo, size_geo);
                   }
                 "
              }

              horizontal-view-movement {
                  spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
              }

              window-movement {
                  spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
              }

              window-resize {
                  spring damping-ratio=1.1 stiffness=1000 epsilon=0.0001
              }

              config-notification-open-close {
                  spring damping-ratio=0.6 stiffness=1000 epsilon=0.001
              }

              exit-confirmation-open-close {
                  spring damping-ratio=0.6 stiffness=500 epsilon=0.01
              }

              screenshot-ui-open {
                  duration-ms 200
                  curve "ease-out-quad"
              }

              overview-open-close {
                  spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
              }

              recent-windows-close {
                  spring damping-ratio=1.0 stiffness=800 epsilon=0.001
              }
          }

          gestures {
              dnd-edge-view-scroll {
                  trigger-width 30
                  delay-ms 100
                  max-speed 1500
              }

              dnd-edge-workspace-switch {
                  trigger-height 50
                  delay-ms 100
                  max-speed 1500
              }

              hot-corners {
                   off
                  // top-left
                  // top-right
                  // bottom-left
                  // bottom-right
              }
          }


          // Load stylix colors + user overrides
          include optional=true "~/.config/niri-stylix/user-config.kdl"
          include optional=true "~/.config/niri-stylix/colors.kdl"
        '';
      };
    };
}
