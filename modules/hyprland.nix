{ config, lib, ... }:
{
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      systemd.enable = true;

      settings = {
        "$terminal" = "alacritty";
        "$fileManager" = "nautilus";
        "$menu" = "rofi -show drun -show-icons";

        exec-once = [
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        ];

        monitor = [
          "eDP-1,1920x1200@60,0x0,1"
          "desc:Dell Inc. DELL U2723QE 6DCGH34,preferred,auto,1.5"
          "desc:Philips Consumer Electronics Company PHL 328P6VU AU52129000348,preferred,auto,1.5"
          "desc:Crestron Electronics Inc. Crestron, preferred, auto, 1, mirror, eDP-1"
          "desc:Canon Inc. CANON WUX500 0x01010101, preferred, auto, 1, mirror, eDP-1"
          "desc:Crestron Electronics Inc. Crestron 420, preferred, auto, 1, mirror, eDP-1"
          ",preferred,auto,1"
        ];

        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ];

        general = {
          gaps_in = 5;
          gaps_out = 10;

          border_size = 2;

          "col.active_border" = lib.mkDefault "rgb(2df598)";
          "col.inactive_border" = lib.mkDefault "rgba(595959aa)";

          resize_on_border = false;

          allow_tearing = false;

          layout = "dwindle";
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        input = {
          kb_layout = "us";
          kb_variant = "altgr-intl";
          follow_mouse = 1;
          sensitivity = 0;

          touchpad = {
            natural_scroll = true;
          };
        };

        gestures = {
          workspace_swipe = false;
        };

        decoration = {
          active_opacity = 1.0;
          inactive_opacity = 0.7;

          blur = {
            enabled = true;
            size = 3;
            passes = 1;

            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;

          bezier = "myBezier, 0.06, 0.9, 0.1, 1.05";

          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        misc = {
          disable_hyprland_logo = true;
        };

        "$mainMod" = "SUPER";

        bind = [
          "$mainMod, T, exec, $terminal"
          "$mainMod, Q, killactive"
          "$mainMod, L, exec, hyprlock"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating"
          "$mainMod, R, exec, $menu"

          "$mainMod, F, fullscreen, 1"
          "$mainMod SHIFT, F, fullscreen, 0"

          "$mainMod CTRL, left, movewindow, l"
          "$mainMod CTRL, right, movewindow, r"
          "$mainMod CTRL, up, movewindow, u"
          "$mainMod CTRL, down, movewindow, d"

          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # "$mainMod CTRL, M, exec, hyprctl keyword monitor HDMI-A-1, preferred, auto, 1, mirror, eDP-1"
          # "$mainMod CTRL SHIFT, M, exec, hyprctl keyword monitor HDMI-A-1, preferred, auto, 1"

          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioNext, exec, playerctl next"

          ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"

          ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        ];

        bindle = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
