{ config, pkgs, ... }:
{
  home = {
    file."Library/Application Support/Übersicht/widgets/simple-bar".source = pkgs.fetchFromGitHub {
      owner = "Jean-Tinland";
      repo = "simple-bar";
      rev = "9d86a56cdc9219b00981646eedabb47a58fc4723";
      sha256 = "sha256-UDKDZY4xO0gJ/tPIVHNBqlQmfvbZFAg5A1TG6pF0pLQ=";
    };

    file.".simplebarrc".text = # json
      ''
        {
          "global": {
            "theme": "auto",
            "floatingBar": true,
            "noBarBg": true,
            "noColorInData": false,
            "bottomBar": false,
            "inlineSpacesOptions": false,
            "disableNotifications": false,
            "compactMode": true,
            "widgetMaxWidth": "160px",
            "spacesBackgroundColorAsForeground": false,
            "widgetsBackgroundColorAsForeground": false,
            "font": "JetBrains Mono",
            "fontSize": "11px",
            "yabaiPath": "/usr/local/bin/yabai",
            "shell": "sh",
            "slidingAnimationPace": "5",
            "externalConfigFile": true
          },
          "themes": {
            "lightTheme": "OneLight",
            "darkTheme": "MaterialOcean"
          },
          "process": {
            "displayOnlyCurrent": false,
            "centered": false,
            "showCurrentSpaceMode": false,
            "hideWindowTitle": false,
            "displayOnlyIcon": false,
            "displaySkhdMode": false,
            "displayStackIndex": true,
            "displayOnlyCurrentStack": false
          },
          "spacesDisplay": {
            "exclusions": "",
            "titleExclusions": "",
            "spacesExclusions": "",
            "exclusionsAsRegex": false,
            "displayAllSpacesOnAllScreens": false,
            "hideDuplicateAppsInSpaces": false,
            "displayStickyWindowsSeparately": false,
            "hideEmptySpaces": false,
            "showOptionsOnHover": true,
            "switchSpacesWithoutYabai": true
          },
          "widgets": {
            "processWidget": false,
            "weatherWidget": false,
            "batteryWidget": true,
            "wifiWidget": false,
            "vpnWidget": false,
            "zoomWidget": false,
            "soundWidget": true,
            "micWidget": false,
            "dateWidget": true,
            "timeWidget": true,
            "keyboardWidget": false,
            "spotifyWidget": true,
            "cryptoWidget": false,
            "stockWidget": false,
            "musicWidget": false,
            "mpdWidget": false,
            "dndWidget": false,
            "browserTrackWidget": false
          },
          "weatherWidgetOptions": {
            "refreshFrequency": 1800000,
            "unit": "C",
            "hideLocation": false,
            "hideGradient": false,
            "customLocation": ""
          },
          "batteryWidgetOptions": {
            "refreshFrequency": 10000,
            "toggleCaffeinateOnClick": true,
            "caffeinateOption": ""
          },
          "networkWidgetOptions": {
            "refreshFrequency": 20000,
            "networkDevice": "en0",
            "hideWifiIfDisabled": false,
            "toggleWifiOnClick": false,
            "hideNetworkName": false
          },
          "vpnWidgetOptions": {
            "refreshFrequency": 8000,
            "vpnConnectionName": "",
            "vpnShowConnectionName": false
          },
          "zoomWidgetOptions": {
            "refreshFrequency": 5000,
            "showVideo": true,
            "showMic": true
          },
          "soundWidgetOptions": {
            "refreshFrequency": 20000
          },
          "micWidgetOptions": {
            "refreshFrequency": 20000
          },
          "dateWidgetOptions": {
            "refreshFrequency": 30000,
            "shortDateFormat": true,
            "locale": "en-UK",
            "calendarApp": ""
          },
          "timeWidgetOptions": {
            "refreshFrequency": 1000,
            "hour12": false,
            "dayProgress": true,
            "showSeconds": false
          },
          "keyboardWidgetOptions": {
            "refreshFrequency": 20000
          },
          "cryptoWidgetOptions": {
            "refreshFrequency": 300000,
            "denomination": "usd",
            "identifiers": "bitcoin,ethereum,celo",
            "precision": 5
          },
          "stockWidgetOptions": {
            "refreshFrequency": 900000,
            "yahooFinanceApiKey": "YOUR_API_KEY",
            "symbols": "AAPL,TSLA",
            "showSymbol": true,
            "showCurrency": true,
            "showMarketPrice": true,
            "showMarketChange": false,
            "showMarketPercent": true,
            "showColor": true
          },
          "spotifyWidgetOptions": {
            "refreshFrequency": 10000,
            "showSpecter": true
          },
          "musicWidgetOptions": {
            "refreshFrequency": 10000,
            "showSpecter": true
          },
          "mpdWidgetOptions": {
            "refreshFrequency": 10000,
            "showSpecter": true,
            "mpdPort": "6600",
            "mpdHost": "127.0.0.1",
            "mpdFormatString": "%title%[ - %artist%]|[%file%]"
          },
          "dndWidgetOptions": {
            "refreshFrequency": 60000,
            "showDndLabel": false
          },
          "browserTrackWidgetOptions": {
            "refreshFrequency": 10000,
            "showSpecter": true
          },
          "userWidgets": {
            "userWidgetsList": {}
          },
          "customStyles": {
            "styles": "/* your custom css styles here */"
          }
        }
      '';
  };
}
