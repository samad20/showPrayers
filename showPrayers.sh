#!/bin/sh
# MIT License

# Copyright (c) 2022

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.












#you should keep it
today=$(date +%s)

# change this - use URL for help
# https://www.latlong.net/
lat='28.596769'
long='-81.203430'

# change this - use URL for help
# https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes
country="US"

# method" (number) -
# A prayer times calculation method. Methods identify various schools of thought about how to compute the timings. If not specified, it defaults to the closest authority based on the location or co-ordinates specified in the API call. This parameter accepts values from 0-12 and 99, as specified below:
# * 0 - Shia Ithna-Ansari
# 1 - University of Islamic Sciences, Karachi
# 2 - Islamic Society of North America
# 3 - Muslim World League
# 4 - Umm Al-Qura University, Makkah
# 5 - Egyptian General Authority of Survey
# 7 - Institute of Geophysics, University of Tehran
# 8 - Gulf Region
# 9 - Kuwait
# 10 - Qatar
# 11 - Majlis Ugama Islam Singapura, Singapore
# 12 - Union Organization islamic de France
# 13 - Diyanet İşleri Başkanlığı, Turkey
# 14 - Spiritual Administration of Muslims of Russia
# 15 - Moonsighting Committee Worldwide (also requires shafaq paramteer)
# 99 - Custom. See https://aladhan.com/calculation-methods

# change this - use information abbove
method="2" #method 2 for Americas for example


# adjust the Hijri date- change it if you need
adjustment="1"

output="$HOME/showPrayers/prayers.json"

# The api can be found for free
curl "http://api.aladhan.com/v1/timings/$today?latitude=$lat&longitude=$long&method=$method&adjustment=$adjustment" -s -o $output



# Parsing the data for the five salawat
prayers="$HOME/showPrayers/prayers.json"
fajr=$(jq ".data.timings.Fajr" $prayers | bc | awk '{$1=$1};1')
sunrise=$(jq ".data.timings.Sunrise" $prayers | bc | awk '{$1=$1};1')
dhuhr=$(jq ".data.timings.Dhuhr" $prayers | bc | awk '{$1=$1};1')
asr=$(jq ".data.timings.Asr" $prayers | bc | awk '{$1=$1};1')
maghrib=$(jq ".data.timings.Maghrib" $prayers | bc | awk '{$1=$1};1')
isha=$(jq ".data.timings.Isha" $prayers | bc | awk '{$1=$1};1')
day=$(jq ".data.date.hijri.weekday.en" $prayers | bc | awk '{$1=$1};1')
daynumber=$(jq ".data.date.hijri.day" $prayers | bc | awk '{$1=$1};1')
month=$(jq ".data.date.hijri.month.en" $prayers | bc | awk '{$1=$1};1')
year=$(jq ".data.date.hijri.year" $prayers | bc | awk '{$1=$1};1')

nextprayer=""
# Get the current time
currenttime=$(date +%H:%M)

# For each prayer, two variables are used, one to be printed as the name of the prayer (nextprayer), 
# and the other variable (time) to be used in the calculation of the remaining time (nextTime)
if [[ $currenttime > $fajr && $currenttime < $dhuhr ]]; then
    nextprayer=$(echo "Dhuhr")
    nextTime=$dhuhr

elif [[ $currenttime > $dhuhr && $currenttime < $asr ]]; then
    nextprayer=$(echo "Asr")
    nextTime=$asr

elif [[ $currenttime > $asr && $currenttime < $maghrib ]]; then
    nextprayer=$(echo "Maghrib")
    nextTime=$maghrib

elif [[ $currenttime > $maghrib && $currenttime < $isha ]]; then
    nextprayer=$(echo "Isha")
    nextTime=$isha

elif [[ $currenttime > $isha || $currenttime < $fajr ]]; then
    nextprayer=$(echo "Fajr")
    nextTime=$fajr
fi

# Calculate the remaining time to the next prayer (or iftar in ramadan and the fast duration is ramadan)
remain=$(date -u -d @$(($(date -d "$nextTime" "+%s") - $(date -d "$currenttime" "+%s"))) "+%H:%M")
fast=$(date -u -d @$(($(date -d "$maghrib" '+%s') - $(date -d "$fajr" '+%s'))) '+%H:%M')
Tofast=$(date -u -d @$(($(date -d "$maghrib" '+%s') - $(date -d "$currenttime" '+%s'))) '+%H:%M')

# Sending the salawat to the stdout
printf "\nTime: $currenttime\n"
printf "\n🕌 Prayer times for the day: $day \n$daynumber-$month-$year\n"
printf "\n۞ Fajr\t\t$fajr\n"
printf "۞ Sunrise\t$sunrise\n"
printf "۞ Dhuhr\t\t$dhuhr\n"
printf "۞ Asr\t\t$asr\n"
printf "۞ Maghrib\t$maghrib\n"
printf "۞ Isha\t\t$isha\n\n"

printf "\n🕌 Next prayer ۩ $nextprayer ۩ $nextTime\n"
printf "Remaining time $remain\n\n"
printf "Duration of fasting $fast\n"
printf "Time left until breakfast $Tofast\n\n"