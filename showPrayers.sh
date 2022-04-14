#!/bin/sh

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
method="2" #method 2 for Americas


# adjust the Hijri date- change it if you need
adjustment="1"

output="$HOME/showPrayers/prayers.json"

# The api can be found for free
curl "http://api.aladhan.com/v1/timings/$today?latitude=$lat&longitude=$long&method=$method&adjustment=$adjustment" -s -o $output