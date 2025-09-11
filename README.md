<div align=center>
<h1>Weather Tool</h1>
</div>


This Bash script allows you to browse countries and their states/provinces 
from the `worldcities.csv` dataset and fetch real-time weather information 
using the wttr.in API.

--------------------
 REQUIREMENTS
--------------------
- Bash (v4 or higher recommended)
- awk, grep, cut, sort, tr, curl (commonly available on Linux/macOS)
- The dataset file: `worldcities.csv` (https://simplemaps.com/data/world-cities)

--------------------
 HOW TO USE
--------------------
1. Clone this repository.

```bash
git clone https://github.com/mattzsync/simple-weather-checker
```

2. Make the script executable:
```bash
chmod +x weather.sh
```
3. Run the script:
```bash
./weather.sh
```

--------------------
 FEATURES
--------------------
- **Show all countries**  
  Displays a numbered list of all unique countries in the dataset.

- **Search for a country**  
  Search by name or partial name, then optionally select a country 
  directly from the results.

- **Select a country by number**  
  Pick a country from the list and see its states/provinces.

- **Browse states**  
  After selecting a country, you can view and select its states or provinces.

- **Weather lookup**  
  After selecting a state/province, the script fetches current weather data 
  from [wttr.in](https://wttr.in).
