#!/bin/sh

get_icon() {
    case $1 in
        # Icons for weather-icons
        #01d) icon="";;
        #01n) icon="";;
        #02d) icon="";;
        #02n) icon="";;
        #03*) icon="";;
        #04*) icon="";;
        #09d) icon="";;
        #09n) icon="";;
        #10d) icon="";;
        #10n) icon="";;
        #11d) icon="";;
        #11n) icon="";;
        #13d) icon="";;
        #13n) icon="";;
        #50d) icon="";;
        #50n) icon="";;
        #*) icon="";


    01d) icon="";; # Clear sky day.
    01n) icon="";; # Clear sky night.
    02d) icon="";; # Few clouds day.
    02n) icon="";; # Few clouds night.
    03d) icon="";; # Scattered clouds day.
    03n) icon="";; # Scattered clouds night.
    04d) icon="";; # Broken clouds day.
    04n) icon="";; # Broken clouds night.
    09d) icon="";; # Shower rain day.
    09n) icon="";; # Shower rain night.
    10d) icon="";; # Rain day.
    10n) icon="";; # Rain night
    11d) icon="";; # Thunderstorm day.
    11n) icon="";; # Thunderstorm night
    13d) icon="";; # Snow day. Snowflake alternative: 
    13n) icon="";; # Snow night. Snowflake alternative: 
    50d) icon="";; # Mist day.
    50n) icon="";; # Mist night.
    *) icon="";


        # Icons for Font Awesome 5 Pro
        #01d) icon="";;
        #01n) icon="";;
        #02d) icon="";;
        #02n) icon="";;
        #03d) icon="";;
        #03n) icon="";;
        #04*) icon="";;
        #09*) icon="";;
        #10d) icon="";;
        #10n) icon="";;
        #11*) icon="";;
        #13*) icon="";;
        #50*) icon="";;
        #*) icon="";
    esac

    echo $icon
}

KEY="4cf3731a25d1d1f4e4a00207afd451a2"
CITY="Santiago, CL"
UNITS="metric"
SYMBOL="°C"

API="https://api.openweathermap.org/data/2.5"

if [ -n "$CITY" ]; then
#API="https://api.openweathermap.org/data/2.5"
    if [ "$CITY" -eq "$CITY" ] 2>/dev/null; then
        CITY_PARAM="id=$CITY"
    else
        CITY_PARAM="q=$CITY"
    fi

    weather=$(curl -sf "$API/weather?appid=$KEY&$CITY_PARAM&units=$UNITS")
else
    location=$(curl -sf https://location.services.mozilla.com/v1/geolocate?key=geoclue)

    if [ -n "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        weather=$(curl -sf "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
    fi
fi

if [ -n "$weather" ]; then
    weather_desc=$(echo "$weather" | jq -r ".weather[0].description")
    weather_temp=$(echo "$weather" | jq ".main.temp" | cut -d "." -f 1)
    weather_icon=$(echo "$weather" | jq -r ".weather[0].icon")

    echo "%{F#FFFF00}$(get_icon "$weather_icon")%{F-}" "$weather_desc", "$weather_temp$SYMBOL"
fi
