---
title: "Developing Data Products Week 2 Project 1"
author: "jedraynes"
date: "4/1/2021"
output: 
  html_document: 
    keep_md: yes
---

# Mapping US National Parks in R with Leaflet

### # Overview and Sources

---

**Created:** April 1, 2021

This webpage is my project submission for the Developing Data Products Week 2 Project.
The source of the data is found [here](https://download.geonames.org/export/dump/) and the data dictionary can be found [here](https://download.geonames.org/export/dump/readme.txt). The listing of US National Park Service National Parks can be found [here](https://www.nps.gov/aboutus/national-park-system.htm). I used the NPS listing to check that all national parks (63 in total) were included in my listing.

### # Data Wrangling

---

To start, let's load our packages. For this, we'll use leaflet to plot the parks, dplyr to manipulate our data,  data.table to copy data frames for internal version control, and htmlwidgets and htmltools to save our map for the website.


```r
# load libraries
suppressPackageStartupMessages(pacman::p_load(leaflet, 
                                              dplyr, 
                                              data.table, 
                                              htmlwidgets, 
                                              htmltools))
```

Next, we'll define the working directory to access our files and load in the data.



```r
# set cwd
setwd('C:\\Users\\Jed\\iCloudDrive\\Documents\\Learn\\R\\Johns Hopkins Data Science Specialization\\9 Developing Data Products\\Week 2')

# define column names
col_names <- c('geonameid', 
               'name', 
               'asciiname', 
               'alternatenames', 
               'latitude', 
               'longitude', 
               'feature_class', 
               'feature_code', 
               'country_code', 
               'cc2', 
               'admin1_code', 
               'admin2_code',
               'admin3_code', 
               'admin4_code', 
               'population', 
               'elevation', 
               'dem', 
               'timezone', 
               'modification_date')

# load data
df_all <- read.csv('US.txt', sep = '\t', col.names = col_names)
```


Then, we clean the loaded data to prepare a dataframe that is structured for our leaflet plot. I first copied the necessary columns from the entire data. I then filtered for class 'L' which represents parks and areas per the data dictionary, filtered where the name contained 'National Park', and arranged it alphabetically so I could easily compare it to the NPS site which is listed A-Z.

After doing so, I compiled a list of names in my listing that weren't national parks and removed these items from my dataframe. After doing so, I grouped my dataframe by the names and took the average latitude and longitude to group away parks that were listed more than once.

Finally, I compared the dataframe of 58 parks to the NPS listing of 63 parks and determined which parks were missing. It turns out I was missing five national parks: Gateway Arch National Park, Indiana Dunes National Park, National Park of American Samoa, New River Gorge National Park, and White Sands National Park. I grabbed the latitude and longitude from this [site](https://www.gps-coordinates.net/) and created a dataframe to append to my master list. After appending, I checked my listing and confirmed the 63 parks I had in my dataset matched the NPS listing per their site.


```r
# copy df and only select the necessary columns
df <- copy(df_all)[, c(2, 5, 6, 7)]

# subset the df to only national parks
df <- df %>%
  filter(feature_class == 'L') %>%
  filter(grepl('National Park', name)) %>%
  arrange(name)

# define items in the subset that aren't NPS national parks and remove them
not_parks <- c('Capital Reef National Park', 
               'Congaree National Park Auxillary Parking Lot', 
               'Congaree National Park Wilderness',
               'Denali National Park and Preserve Headquarters', 
               'Fiske Hill National Park', 
               'Fort Hunt National Park', 
               'Fort Nonsense Historical National Park', 
               'Great Sand Dunes National Park and Preserve', 
               'Great Smoky Mountains National Park (North Carolina secion)', 
               'Horseshoe Canyon Unit- Canyonlands National Park', 
               'National Park', 
               'National Park Service Headquarters', 
               'Olympic National Park Headquarters Historic District', 
               'Prairie National Park', 
               'Rio Cacheu National Park', 
               'Rocky Mountain National Park Administration Building', 
               'Rocky Mountain National Park Wilderness', 
               'Saguaro National Park East Unit (historical)', 
               'Sequoia and Kings Canyon National Parks', 
               'Southeast Archeological Center National Park Service', 
               'Theodore Roosevelt National Park - Nor`th Unit', 
               'Washington Headquarters National Park', 
               'Wolf Trap National Park for the Performing Arts')
df <- df[!(df$name %in% not_parks), ]

# to remove the duplicates, we'll group by name and take the average latitude and longitude
df <- df %>% 
  group_by(name) %>%
  summarize(latitude = mean(latitude), 
            longitude = mean(longitude))
  
# define five missing national parks
parks_to_add <- data.frame(name = c('Gateway Arch National Park',  
                                    'Indiana Dunes National Park', 
                                    'National Park of American Samoa', 
                                    'New River Gorge National Park', 
                                    'White Sands National Park'), 
                           latitude = c(38.6246071, 
                                        41.663543701171875, 
                                        -14.2619444, 
                                        37.84026336669922, 
                                        32.783233642578125), 
                           longitude = c(-90.1849717, 
                                         -87.03569793701172, 
                                         -170.6880556, 
                                         -80.98970794677734, 
                                         -106.33186340332031))

# layer in missing parks
df <- df %>%
  rbind(parks_to_add) %>%
  arrange(name)
```

After organizing my data, I created an icon using the NPS logo to make my map have a bit more flair. Finally, I plotted my map using leaflet and used the default clustering to visualize where most parks were located (western US). The most interesting one, in my opinion, is the National Park of American Samoa, that's definitely going on my travel list.

<!--html_preserve--><div id="htmlwidget-97be1ae1ca30be7f29db" style="width:672px;height:480px;" class="leaflet html-widget"></div>
<script type="application/json" data-for="htmlwidget-97be1ae1ca30be7f29db">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addMarkers","args":[[44.35073,38.72254,43.834,29.29778,25.49049,38.46589,38.57778,37.5839,38.32687,38.36697,32.17539,33.99861,33.79187,42.94109,41.26085,36.49363,63.34111,24.64883,25.37217,67.79681,38.6246071,58.50056,48.68306,36.10697,43.79044,38.9461,37.77654,35.60065,31.92301,20.7204,19.41938,34.51427,41.6635437011719,48.00341,33.87343,58.56256,59.81571,36.88785,67.35336,60.54726,40.49368,37.19758,37.23905,46.87997,-14.2619444,37.8402633666992,48.8332,47.96336,34.98369,36.4904,41.37133,40.34281,32.17871,36.50768,38.49177,46.95359,48.48355,32.7832336425781,43.58009,61.06998,44.42796,37.84835,37.29824],[-68.24411,-109.58635,-102.39395,-103.22985,-80.21025,-107.16661,-107.72426,-112.18271,-109.87826,-111.2615,-104.44384,-119.85838,-80.74867,-122.13282,-81.57116,-117.09091,-150.73414,-82.87177,-80.88182,-153.30978,-90.1849717,-137.00056,-113.80031,-112.113,-110.68176,-114.25797,-105.62886,-83.50877,-104.88554,-156.15515,-155.2885,-93.05085,-87.0356979370117,-88.868855,-115.90099,-154.9788,-150.10857,-118.55515,-159.19889,-153.24879,-121.40735,-86.13089,-108.46241,-121.72691,-170.6880556,-80.9897079467773,-121.34661,-123.92651,-109.78779,-121.18117,-124.03166,-105.68364,-110.6079,-118.5752,-78.4691,-103.45922,-92.8381,-106.33186340332,-103.43948,-142.43421,-110.58846,-119.55696,-113.02644],{"iconUrl":{"data":"https://upload.wikimedia.org/wikipedia/commons/1/1d/US-NationalParkService-Logo.svg","index":0},"iconWidth":28.9782608695652,"iconHeight":31,"iconAnchorX":14.4891304347826,"iconAnchorY":16},null,null,{"interactive":true,"draggable":false,"keyboard":true,"title":"","alt":"","zIndexOffset":0,"opacity":1,"riseOnHover":false,"riseOffset":250},["Acadia National Park","Arches National Park","Badlands National Park","Big Bend National Park","Biscayne National Park","Black Canyon National Park","Black Canyon of the Gunnison National Park","Bryce Canyon National Park","Canyonlands National Park","Capitol Reef National Park","Carlsbad Caverns National Park","Channel Islands National Park","Congaree National Park","Crater Lake National Park","Cuyahoga Valley National Park","Death Valley National Park","Denali National Park","Dry Tortugas National Park","Everglades National Park","Gates of the Arctic National Park","Gateway Arch National Park","Glacier Bay National Park and Preserve","Glacier National Park","Grand Canyon National Park","Grand Teton National Park","Great Basin National Park","Great Sand Dunes National Park","Great Smoky Mountains National Park","Guadalupe Mountains National Park","Haleakala National Park","Hawaiâ€˜i Volcanoes National Park","Hot Springs National Park","Indiana Dunes National Park","Isle Royale National Park","Joshua Tree National Park","Katmai National Park","Kenai Fjords National Park","Kings Canyon National Park","Kobuk Valley National Park","Lake Clark National Park","Lassen Volcanic National Park","Mammoth Cave National Park","Mesa Verde National Park","Mount Rainier National Park (MRNP)","National Park of American Samoa","New River Gorge National Park","North Cascades National Park","Olympic National Park","Petrified Forest National Park","Pinnacles National Park","Redwood National Park","Rocky Mountain National Park","Saguaro National Park","Sequoia National Park","Shenandoah National Park","Theodore Roosevelt National Park","Voyageurs National Park","White Sands National Park","Wind Cave National Park","Wrangell-Saint Elias National Park","Yellowstone National Park","Yosemite National Park","Zion National Park"],null,{"showCoverageOnHover":true,"zoomToBoundsOnClick":true,"spiderfyOnMaxZoom":true,"removeOutsideVisibleBounds":true,"spiderLegPolylineOptions":{"weight":1.5,"color":"#222","opacity":0.5},"freezeAtZoom":false},null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]}],"limits":{"lat":[-14.2619444,67.79681],"lng":[-170.6880556,-68.24411]}},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->
