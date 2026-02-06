# Skyfall

A beautiful, full-featured weather app that runs entirely in the browser. No API keys required.

![Weather](https://img.shields.io/badge/weather-Open--Meteo-blue) ![No API Key](https://img.shields.io/badge/API%20Key-not%20required-green)

## Features

- **Auto-detect location** — Uses browser geolocation to find you
- **Current conditions** — Temperature, feels-like, humidity, wind, pressure, UV, visibility
- **3-day forecast** — Daily highs/lows with precipitation & snow totals
- **48-hour hourly forecast** — Scrollable hour-by-hour predictions
- **Predicted snow totals** — See how much snow is coming
- **Sunrise & sunset** — With daylight duration
- **Live precipitation radar** — RainViewer map overlay
- **Metric/Imperial toggle** — °C/°F, km/h/mph
- **Collapsible stats** — Minimize details to make the map bigger
- **Auto-refresh** — Updates every 15 minutes
- **Dark theme** — Easy on the eyes

## Quick Start

```bash
# Local only
python3 -m http.server 8765

# On your network
./serve.sh

# Public URL (works from anywhere, no password)
./serve-tunnel.sh
```

Then open http://localhost:8765 (or the URL from serve-tunnel.sh)

## Data Sources

- **Weather**: [Open-Meteo](https://open-meteo.com) — Free, no API key
- **Radar**: [RainViewer](https://rainviewer.com) — Free precipitation maps
- **Maps**: [CARTO](https://carto.com) — Dark basemap
- **Geocoding**: Open-Meteo + Nominatim

## License

MIT
