{
  lib,
  config,
  ...
}:
{
  options = {
    swaync.enable = lib.mkEnableOption "enables tmux";
  };

  config = lib.mkIf config.swaync.enable {
    services.swaync = {
      enable = true;

      style = ''
        @define-color panto-green #2df598;
        @define-color bg #212121;
        @define-color darker #121212;

        .notification {
          border-radius: 0px;
          border-color: @panto-green;
          margin: 6px 12px;
          padding: 4px;
        }

        .notification-content {
          border-radius: 0px;
        }

        .notification-default-action {
          border-radius: 0px;
        }

        .KB {
          border: none;
          background-color: @panto-green;
        }

        .body-image {
          margin-top: 6px;
          background-color: white;
          border-radius: 0px;
        }

        .body {
          font-size: 12px;
          font-weight: normal;
          background: transparent;
          color: white;
          text-shadow: none;
        }

        /* The "Notifications" and "Do Not Disturb" text widget */
        .top-action-title {
          color: white;
          text-shadow: none;
        }
        .control-center {
          border-radius: 2px;
          background: #121212;
          padding: 4px;
          margin: 4px;
          border: 1px solid @bg;
        }
        .control-center-list {
          background: transparent;
        }
        .floating-notifications {
          background: transparent;
        }
        .widget-mpris-player {
          padding: 8px;
          margin: 8px;
          background-color: @bg;
          border-radius: 0px;
        }

        .widget-mpris-title {
          font-weight: bold;
          font-size: 1.25rem;
        }

        .widget-mpris-subtitle {
          font-size: 1.1rem;
        }
        .widget-volume {
          background-color: @bg;
          border-radius: 0px;
          font-size: 14px;
        }
        .widget-slder label {
          font-size: 20px;
          background-color: @panto-green;
        }
      '';

      settings = {
        positionY = "top";
        positionX = "right";
        control-center-layer = "top";
        layer-shell = true;
        fit-to-screen = false;

        widgets = [
          "volume"
          "mpris"
          "notifications"
        ];
      };
    };
  };
}
