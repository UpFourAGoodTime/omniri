{
  ...
}:
{
  flake.homeModules.desktop-entries-stylix =
  {
    config,
    lib,
    pkgs,
    ...
  }:
  {
    options.stylix.targets.desktop-entries-stylix = {
      enable = config.lib.stylix.mkEnableTarget "desktop-entries-stylix" true;

      entries = {
        pear-desktop.enable = lib.mkEnableOption "pear-desktop-icon";

        element-desktop.enable = lib.mkEnableOption "element-desktop";

        chromium-browser = {
          enable = lib.mkEnableOption "chromium-browser";

          package = lib.mkPackageOption pkgs "chromium" { } // {
                default = pkgs.ungoogled-chromium;
              };
        };

      };
    };

    config = lib.mkIf (config.stylix.enable && config.stylix.targets.desktop-entries-stylix.enable) {

    programs.chromium = lib.mkIf config.stylix.targets.desktop-entries-stylix.entries.chromium-browser.enable {
      enable = true;
      package = config.stylix.targets.desktop-entries-stylix.entries.chromium-browser.package;
    };

    xdg.mimeApps = lib.mkIf config.stylix.targets.desktop-entries-stylix.entries.chromium-browser.enable {
      enable = true;

      defaultApplications = {
        "text/html" = "chromium-browser.desktop";
        "x-scheme-handler/http" = "chromium-browser.desktop";
        "x-scheme-handler/https" = "chromium-browser.desktop";
      };

      defaultApplicationPackages = [
        config.stylix.targets.desktop-entries-stylix.entries.chromium-browser.package
      ];
    };

      xdg.desktopEntries = {

        "qt5ct" = {
          name = "Qt5 Settings";
          noDisplay = true;
        };

        "qt6ct" = {
          name = "Qt6 Settings";
          noDisplay = true;
        };

        "kvantummanager" = {
          name = "Kvantum Manager";
          noDisplay = true;
        };



        "chromium-browser" = lib.mkIf config.stylix.targets.desktop-entries-stylix.entries.chromium-browser.enable {
          name = "Chromium";
          type = "Application";
          terminal = false;
          categories = [
            "Network"
            "WebBrowser"
          ];
          exec = "${lib.getExe config.stylix.targets.desktop-entries-stylix.entries.chromium-browser.package} %U";

          icon = pkgs.writeText "chromium.svg" ''
            <svg viewBox="0 0 256 256" fill="none" xmlns="http://www.w3.org/2000/svg"><g
                    clip-path="url(#a)"
                ><path
                        d="M128 191.995c35.346 0 64-28.654 64-64 0-35.347-28.654-64-64-64-35.346 0-64 28.654-64 64 0 35.346 28.654 64 64 64Z"
                        fill="url(#radialGradient1)"
                    /><path
                        d="M96.01 183.41a63.681 63.681 0 0 1-23.42-23.43l-.007.004-55.425-96a128.027 128.027 0 0 0 110.841 192.018l55.436-96.018a63.985 63.985 0 0 1-16.465 18.775 64.007 64.007 0 0 1-70.96 4.651Z"
                        fill="url(#linearGradient1)"
                    /><path
                        d="M191.991 127.984a63.683 63.683 0 0 1-8.581 31.996l.007.004-55.426 96a128.029 128.029 0 0 0 110.872-192H127.991a64 64 0 0 1 64 64Z"
                        fill="url(#linearGradient2)"
                    /><path
                        d="M128 180c28.719 0 52-23.281 52-52s-23.281-52-52-52-52 23.281-52 52 23.281 52 52 52Z"
                        fill="url(#linearGradient4)"
                    /><path
                        d="M95.99 72.59a63.684 63.684 0 0 1 32.001-8.566v-.008h110.851A128.035 128.035 0 0 0 127.991.026 128.028 128.028 0 0 0 17.13 63.999l55.436 96.018a64.003 64.003 0 0 1 4.65-70.961A64 64 0 0 1 95.991 72.59Z"
                        fill="url(#linearGradient3)"
                    /></g>
                    <defs>
                    <linearGradient id="linearGradient1">
                      <stop
                            style="stop-color:${config.lib.stylix.colors.withHashtag.base01};stop-opacity:1;"
                            offset="0"
                            id="stop5"
                        />
                      <stop
                            style="stop-color:#000000;stop-opacity:1;"
                            offset="1"
                            id="stop6"
                        />
                    </linearGradient>
                    <linearGradient id="linearGradient2">
                      <stop
                            style="stop-color:${config.lib.stylix.colors.withHashtag.base00};stop-opacity:1;"
                            offset="0"
                            id="stop5"
                        />
                      <stop
                            style="stop-color:#000000;stop-opacity:1;"
                            offset="1"
                            id="stop6"
                        />
                    </linearGradient>
                    <linearGradient id="linearGradient3">
                      <stop style="stop-color:${config.lib.stylix.colors.withHashtag.base08};stop-opacity:1;" offset="0" id="stop5" />
                      <stop
                            style="stop-color:#000000;stop-opacity:1;"
                            offset="1"
                            id="stop6"
                        />
                    </linearGradient>
                    <linearGradient id="linearGradient4">
                      <stop style="stop-color:${config.lib.stylix.colors.withHashtag.base0A};stop-opacity:1;" offset="0" id="stop5" />
                      <stop
                            style="stop-color:#000000;stop-opacity:1;"
                            offset="1"
                            id="stop6"
                        />
                    </linearGradient>
                    <radialGradient
                        id="radialGradient1"
                        cx="50%"
                        cy="50%"
                        r="50%"
                        fx="50%"
                        fy="50%"
                    >
                      <stop offset="80%" stop-color="black" />
                      <stop offset="100%" stop-color="white" />
                    </radialGradient>
                    <clipPath id="a"><path fill="#fff" d="M0 0h256v256H0z" /></clipPath>
                        </defs>
            </svg>
          '';
        };

        "element-desktop" = lib.mkIf config.stylix.targets.desktop-entries-stylix.entries.element-desktop.enable {
          name = "Element";
          exec = "${lib.getExe pkgs.element-desktop} %u";
          icon = pkgs.writeText "element.svg" ''
            <?xml version="1.0" encoding="UTF-8" standalone="no" ?>
            <svg
                width="112"
                height="112"
                viewBox="0 0 112 112"
                fill="none"
                version="1.1"
                id="svg5"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns="http://www.w3.org/2000/svg"
                xmlns:svg="http://www.w3.org/2000/svg"
            >
              <defs id="defs5">
                <linearGradient id="linearGradient5">
                  <stop style="stop-color:${config.lib.stylix.colors.withHashtag.base02};stop-opacity:1;" offset="0" id="stop5" />
                  <stop style="stop-color:#000000;stop-opacity:1;" offset="1" id="stop6" />
                </linearGradient>
                <radialGradient
                        xlink:href="#linearGradient5"
                        id="radialGradient6"
                        cx="56"
                        cy="56"
                        fx="56"
                        fy="56"
                        r="56"
                        gradientUnits="userSpaceOnUse"
                    />
              </defs>
              <path
                    fill-rule="evenodd"
                    clip-rule="evenodd"
                    d="M 56,112 C 86.9279,112 112,86.9279 112,56 112,25.0721 86.9279,0 56,0 25.0721,0 0,25.0721 0,56 c 0,30.9279 25.0721,56 56,56 z"
                    fill="#0DBD8B"
                    id="path1"
                    style="fill:url(#radialGradient6)"
                />
              <path
                    fill-rule="evenodd"
                    clip-rule="evenodd"
                    d="m 45.7614,26.093 c 0,-2.2604 1.8363,-4.0929 4.1014,-4.0929 15.3526,0 27.7983,12.4199 27.7983,27.7405 0,2.2605 -1.8363,4.0929 -4.1014,4.0929 -2.2652,0 -4.1014,-1.8324 -4.1014,-4.0929 0,-10.7998 -8.7732,-19.5547 -19.5955,-19.5547 -2.2651,0 -4.1014,-1.8325 -4.1014,-4.0929 z"
                    fill="#ffffff"
                    id="path2"
                />
              <path
                    fill-rule="evenodd"
                    clip-rule="evenodd"
                    d="m 85.8985,45.6477 c 2.2652,0 4.1014,1.8324 4.1014,4.0929 0,15.3206 -12.4457,27.7405 -27.7982,27.7405 -2.2651,0 -4.1014,-1.8325 -4.1014,-4.0929 0,-2.2604 1.8363,-4.0929 4.1014,-4.0929 10.8222,0 19.5954,-8.7549 19.5954,-19.5547 0,-2.2605 1.8363,-4.0929 4.1014,-4.0929 z"
                    fill="#ffffff"
                    id="path3"
                />
              <path
                    fill-rule="evenodd"
                    clip-rule="evenodd"
                    d="m 66.3031,85.907 c 0,2.2605 -1.8362,4.0929 -4.1014,4.0929 -15.3525,0 -27.7982,-12.4198 -27.7982,-27.7405 0,-2.2604 1.8363,-4.0929 4.1014,-4.0929 2.2651,0 4.1014,1.8325 4.1014,4.0929 0,10.7998 8.7732,19.5548 19.5954,19.5548 2.2652,0 4.1014,1.8324 4.1014,4.0928 z"
                    fill="#ffffff"
                    id="path4"
                />
              <path
                    fill-rule="evenodd"
                    clip-rule="evenodd"
                    d="M 26.1014,66.3524 C 23.8363,66.3524 22,64.5199 22,62.2595 22,46.9388 34.4457,34.519 49.7982,34.519 c 2.2651,0 4.1014,1.8324 4.1014,4.0928 0,2.2605 -1.8363,4.0929 -4.1014,4.0929 -10.8222,0 -19.5954,8.755 -19.5954,19.5548 0,2.2604 -1.8363,4.0929 -4.1014,4.0929 z"
                    fill="#ffffff"
                    id="path5"
                />
            </svg>

          '';
        };

        "com.github.th_ch.youtube_music" = lib.mkIf config.stylix.targets.desktop-entries-stylix.entries.pear-desktop.enable {
          name = "Youtube Music";
          type = "Application";
          terminal = false;
          categories = [
            "AudioVideo"
          ];
          exec = "${lib.getExe pkgs.pear-desktop} %U";

          icon = pkgs.writeText "pear-desktop.svg" ''
            <?xml version="1.0" encoding="UTF-8" standalone="no"?>
            <svg
               width="868"
               height="868"
               viewBox="0 0 1024 1024"
               fill="none"
               version="1.1"
               id="svg11"
               sodipodi:docname="icon.svg"
               inkscape:version="1.4.4 (dcaf3e7d9e, 2026-05-05)"
               xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
               xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
               xmlns="http://www.w3.org/2000/svg"
               xmlns:svg="http://www.w3.org/2000/svg">
              <sodipodi:namedview
                 id="namedview11"
                 pagecolor="#505050"
                 bordercolor="#ffffff"
                 borderopacity="1"
                 inkscape:showpageshadow="0"
                 inkscape:pageopacity="0"
                 inkscape:pagecheckerboard="1"
                 inkscape:deskcolor="#505050"
                 inkscape:zoom="0.95967742"
                 inkscape:cx="433.47899"
                 inkscape:cy="434"
                 inkscape:window-width="1920"
                 inkscape:window-height="1046"
                 inkscape:window-x="0"
                 inkscape:window-y="0"
                 inkscape:window-maximized="1"
                 inkscape:current-layer="svg11" />
              <circle
                 cx="512"
                 cy="512"
                 r="410"
                 fill="url(#paint0_linear_18_2)"
                 id="circle1"
                 style="fill:url(#paint0_linear_18_2);filter:url(#filter0_d_18_2)"
                 transform="matrix(1.1799068,0,0,1.1795591,-92.03273,-106.16032)" />
              <circle
                 cx="512"
                 cy="512"
                 r="402"
                 stroke="url(#paint1_radial_18_2)"
                 stroke-opacity="0.5"
                 stroke-width="16"
                 id="circle2"
                 style="display:none;stroke:url(#paint1_radial_18_2);filter:url(#filter0_d_18_2)"
                 transform="matrix(1.1799068,0,0,1.1795591,-92.03273,-106.16032)"
                 sodipodi:insensitive="true" />
              <path
                 d="m 657.25024,503.81509 c 6.28193,3.64212 6.28193,12.7438 0,16.38472 L 376.31232,683.02768 c -6.28193,3.64092 -14.13524,-0.90934 -14.13524,-8.19236 V 349.17959 c 0,-7.16832 7.60947,-11.69138 13.83958,-8.35791 l 0.29566,0.16554 z"
                 fill="url(#paint2_linear_18_2)"
                 stroke="url(#paint3_linear_18_2)"
                 stroke-width="9.44172"
                 stroke-linejoin="round"
                 id="path2"
                 style="fill:url(#paint2_linear_18_2);stroke:url(#paint3_linear_18_2)" />
              <defs
                 id="defs11">
                <filter
                   id="filter0_d_18_2"
                   x="78"
                   y="90"
                   width="868"
                   height="868"
                   filterUnits="userSpaceOnUse"
                   color-interpolation-filters="sRGB">
                  <feFlood
                     flood-opacity="0"
                     result="BackgroundImageFix"
                     id="feFlood2" />
                  <feColorMatrix
                     in="SourceAlpha"
                     type="matrix"
                     values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0"
                     result="hardAlpha"
                     id="feColorMatrix2" />
                  <feOffset
                     dy="12"
                     id="feOffset2" />
                  <feGaussianBlur
                     stdDeviation="12"
                     id="feGaussianBlur2" />
                  <feComposite
                     in2="hardAlpha"
                     operator="out"
                     id="feComposite2" />
                  <feColorMatrix
                     type="matrix"
                     values="0 0 0 0 0.866667 0 0 0 0 0.141176 0 0 0 0 0.462745 0 0 0 0.4 0"
                     id="feColorMatrix3" />
                  <feBlend
                     mode="normal"
                     in2="BackgroundImageFix"
                     result="effect1_dropShadow_18_2"
                     id="feBlend3" />
                  <feBlend
                     mode="normal"
                     in="SourceGraphic"
                     in2="effect1_dropShadow_18_2"
                     result="shape"
                     id="feBlend4" />
                </filter>
                <linearGradient
                   id="paint0_linear_18_2"
                   x1="102"
                   y1="102"
                   x2="922"
                   y2="922"
                   gradientUnits="userSpaceOnUse">
                  <stop
                     stop-color="#FF632F"
                     id="stop4"
                     offset="0"
                     style="stop-color:#2fc4ff;stop-opacity:1;" />
                  <stop
                     offset="1"
                     stop-color="#DC148C"
                     id="stop5"
                     style="stop-color:#ea1cc3;stop-opacity:1;" />
                </linearGradient>
                <radialGradient
                   id="paint1_radial_18_2"
                   cx="0"
                   cy="0"
                   r="1"
                   gradientUnits="userSpaceOnUse"
                   gradientTransform="matrix(410.00031,410.00031,-410.00031,410.00031,512,512)">
                  <stop
                     offset="0.68"
                     stop-color="white"
                     stop-opacity="0"
                     id="stop6" />
                  <stop
                     offset="0.72"
                     stop-color="white"
                     id="stop7" />
                </radialGradient>
                <linearGradient
                   id="paint2_linear_18_2"
                   x1="512"
                   y1="329"
                   x2="512"
                   y2="695"
                   gradientUnits="userSpaceOnUse"
                   gradientTransform="matrix(1.1779368,0,0,1.1824998,-137.85707,-93.432445)">
                  <stop
                     stop-color="white"
                     id="stop8" />
                  <stop
                     offset="1"
                     stop-color="white"
                     stop-opacity="0.4"
                     id="stop9" />
                </linearGradient>
                <linearGradient
                   id="paint3_linear_18_2"
                   x1="512"
                   y1="329"
                   x2="512"
                   y2="695"
                   gradientUnits="userSpaceOnUse"
                   gradientTransform="matrix(1.1779368,0,0,1.1824998,-137.85707,-93.432445)">
                  <stop
                     stop-color="white"
                     stop-opacity="0"
                     id="stop10" />
                  <stop
                     offset="1"
                     stop-color="white"
                     stop-opacity="0.5"
                     id="stop11" />
                </linearGradient>
              </defs>
            </svg>

          '';
        };
      };
    };
  };
}
