---
title: "Developing Data Products Week 3 Project 1"
author: "jedraynes"
date: "4/1/2021"
output: 
  html_document: 
    keep_md: yes
---

# Minimum Wage: 1968 to 2019 Actual vs. Inflation Adjusted

### # Overview and Sources

---

**Created:** April 1, 2021

The dataset used in this project was initially scraped from the US Department of Labor. Note, this dataset uses the minimum wage (and takes the lower value in years where there are multiple) which represents the phase-in amounts when the law was enacted to include new populations.


### # Data Wrangling

---

I'll start by loading in the required packages. For this project, I'm using 'dplyr' to clean the data, 'plotly' to layer in the interactivity, 'ggplot2' to actually create the plot, 'data.table' to use the copy function, 'reshape2' to melt the dataframe, and 'htmlwidgets' and 'htmltools' to save the plot down for the website.


```r
# load libraries
suppressPackageStartupMessages(pacman::p_load(dplyr,
                                              plotly,
                                              ggplot2,
                                              data.table, 
                                              reshape2, 
                                              htmlwidgets, 
                                              htmltools))
```

Next, I'll load and inspect the data.


```r
# set the working directory
setwd('C:\\Users\\Jed\\iCloudDrive\\Documents\\Learn\\R\\Johns Hopkins Data Science Specialization\\9 Developing Data Products\\Week 3')

# load data
inflage <- read.csv('inflage.csv')[, c(-1, -3)]
inflage_copy <- copy(inflage)

# inspect
head(inflage)
```

```
##   year min_wage adjusted_min_wage
## 1 1968     1.15          8.869974
## 2 1969     1.15          8.496239
## 3 1970     1.30          9.045455
## 4 1971     1.30          8.590910
## 5 1972     1.60         10.238988
## 6 1973     1.60          9.878460
```


To get the data organized for plotting, I'll rename the columns and unpivot the wage columns.


```r
# rename columns
names(inflage) <- c('Year', 'Minimum Wage, Actual', 'Minimum Wage, Inflation Adjusted')

# unpivot
inflage <- inflage %>% 
  melt(id.var = 'Year')
```

### # Plot

---

<!--html_preserve--><div id="htmlwidget-adb9c9c9b4cf887fb9f1" style="width:960px;height:480px;" class="plotly html-widget"></div>
<script type="application/json" data-for="htmlwidget-adb9c9c9b4cf887fb9f1">{"x":{"data":[{"x":[1968,1969,1970,1971,1972,1973,1974,1975,1976,1977,1978,1979,1980,1981,1982,1983,1984,1985,1986,1987,1988,1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019],"y":[1.15,1.15,1.3,1.3,1.6,1.6,1.6,1.6,2.2,2.2,2.2,2.9,3.1,3.35,3.35,3.35,3.35,3.35,3.35,3.35,3.35,3.35,3.35,3.8,4.25,4.25,4.25,4.25,4.25,4.75,5.15,5.15,5.15,5.15,5.15,5.15,5.15,5.15,5.15,5.15,5.85,6.55,7.25,7.25,7.25,7.25,7.25,7.25,7.25,7.25,7.25,7.25],"text":["variable: Minimum Wage, Actual<br />Year: 1968<br />value:  1.150000","variable: Minimum Wage, Actual<br />Year: 1969<br />value:  1.150000","variable: Minimum Wage, Actual<br />Year: 1970<br />value:  1.300000","variable: Minimum Wage, Actual<br />Year: 1971<br />value:  1.300000","variable: Minimum Wage, Actual<br />Year: 1972<br />value:  1.600000","variable: Minimum Wage, Actual<br />Year: 1973<br />value:  1.600000","variable: Minimum Wage, Actual<br />Year: 1974<br />value:  1.600000","variable: Minimum Wage, Actual<br />Year: 1975<br />value:  1.600000","variable: Minimum Wage, Actual<br />Year: 1976<br />value:  2.200000","variable: Minimum Wage, Actual<br />Year: 1977<br />value:  2.200000","variable: Minimum Wage, Actual<br />Year: 1978<br />value:  2.200000","variable: Minimum Wage, Actual<br />Year: 1979<br />value:  2.900000","variable: Minimum Wage, Actual<br />Year: 1980<br />value:  3.100000","variable: Minimum Wage, Actual<br />Year: 1981<br />value:  3.350000","variable: Minimum Wage, Actual<br />Year: 1982<br />value:  3.350000","variable: Minimum Wage, Actual<br />Year: 1983<br />value:  3.350000","variable: Minimum Wage, Actual<br />Year: 1984<br />value:  3.350000","variable: Minimum Wage, Actual<br />Year: 1985<br />value:  3.350000","variable: Minimum Wage, Actual<br />Year: 1986<br />value:  3.350000","variable: Minimum Wage, Actual<br />Year: 1987<br />value:  3.350000","variable: Minimum Wage, Actual<br />Year: 1988<br />value:  3.350000","variable: Minimum Wage, Actual<br />Year: 1989<br />value:  3.350000","variable: Minimum Wage, Actual<br />Year: 1990<br />value:  3.350000","variable: Minimum Wage, Actual<br />Year: 1991<br />value:  3.800000","variable: Minimum Wage, Actual<br />Year: 1992<br />value:  4.250000","variable: Minimum Wage, Actual<br />Year: 1993<br />value:  4.250000","variable: Minimum Wage, Actual<br />Year: 1994<br />value:  4.250000","variable: Minimum Wage, Actual<br />Year: 1995<br />value:  4.250000","variable: Minimum Wage, Actual<br />Year: 1996<br />value:  4.250000","variable: Minimum Wage, Actual<br />Year: 1997<br />value:  4.750000","variable: Minimum Wage, Actual<br />Year: 1998<br />value:  5.150000","variable: Minimum Wage, Actual<br />Year: 1999<br />value:  5.150000","variable: Minimum Wage, Actual<br />Year: 2000<br />value:  5.150000","variable: Minimum Wage, Actual<br />Year: 2001<br />value:  5.150000","variable: Minimum Wage, Actual<br />Year: 2002<br />value:  5.150000","variable: Minimum Wage, Actual<br />Year: 2003<br />value:  5.150000","variable: Minimum Wage, Actual<br />Year: 2004<br />value:  5.150000","variable: Minimum Wage, Actual<br />Year: 2005<br />value:  5.150000","variable: Minimum Wage, Actual<br />Year: 2006<br />value:  5.150000","variable: Minimum Wage, Actual<br />Year: 2007<br />value:  5.150000","variable: Minimum Wage, Actual<br />Year: 2008<br />value:  5.850000","variable: Minimum Wage, Actual<br />Year: 2009<br />value:  6.550000","variable: Minimum Wage, Actual<br />Year: 2010<br />value:  7.250000","variable: Minimum Wage, Actual<br />Year: 2011<br />value:  7.250000","variable: Minimum Wage, Actual<br />Year: 2012<br />value:  7.250000","variable: Minimum Wage, Actual<br />Year: 2013<br />value:  7.250000","variable: Minimum Wage, Actual<br />Year: 2014<br />value:  7.250000","variable: Minimum Wage, Actual<br />Year: 2015<br />value:  7.250000","variable: Minimum Wage, Actual<br />Year: 2016<br />value:  7.250000","variable: Minimum Wage, Actual<br />Year: 2017<br />value:  7.250000","variable: Minimum Wage, Actual<br />Year: 2018<br />value:  7.250000","variable: Minimum Wage, Actual<br />Year: 2019<br />value:  7.250000"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(248,118,109,1)","dash":"solid"},"hoveron":"points","name":"Minimum Wage, Actual","legendgroup":"Minimum Wage, Actual","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null},{"x":[1968,1969,1970,1971,1972,1973,1974,1975,1976,1977,1978,1979,1980,1981,1982,1983,1984,1985,1986,1987,1988,1989,1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019],"y":[8.86997360703812,8.49623876404494,9.04545502645503,8.5909095477387,10.2389878345499,9.87846009389671,9.03052360515021,8.07720537428023,10.4070287769784,9.89112478632479,9.2580928,11.167505124451,10.4799922879177,10.1275505747126,9.34355143160127,9.00917075664622,8.64668204121688,8.35162938388626,8.0392052919708,7.92353327338129,7.61535782195333,7.27577952105698,6.91598822605965,7.42535809806835,8.09420347574222,7.8387762973352,7.64575581395349,7.43718895542249,7.23969883419689,7.85239786297926,8.38194368811881,8.24420024345709,8.02442002369668,7.73570588235294,7.64834613212874,7.45471711612548,7.31383423326134,7.10289512323021,6.83067120524458,6.6917738716307,7.28933058555998,8.15912296405753,8.80002722821397,8.65873001457613,8.41264200472062,8.28057799200973,8.15186434446553,8.15915441129277,8.04863960222188,7.8523280856864,7.69304304324497,7.57552877892194],"text":["variable: Minimum Wage, Inflation Adjusted<br />Year: 1968<br />value:  8.869974","variable: Minimum Wage, Inflation Adjusted<br />Year: 1969<br />value:  8.496239","variable: Minimum Wage, Inflation Adjusted<br />Year: 1970<br />value:  9.045455","variable: Minimum Wage, Inflation Adjusted<br />Year: 1971<br />value:  8.590910","variable: Minimum Wage, Inflation Adjusted<br />Year: 1972<br />value: 10.238988","variable: Minimum Wage, Inflation Adjusted<br />Year: 1973<br />value:  9.878460","variable: Minimum Wage, Inflation Adjusted<br />Year: 1974<br />value:  9.030524","variable: Minimum Wage, Inflation Adjusted<br />Year: 1975<br />value:  8.077205","variable: Minimum Wage, Inflation Adjusted<br />Year: 1976<br />value: 10.407029","variable: Minimum Wage, Inflation Adjusted<br />Year: 1977<br />value:  9.891125","variable: Minimum Wage, Inflation Adjusted<br />Year: 1978<br />value:  9.258093","variable: Minimum Wage, Inflation Adjusted<br />Year: 1979<br />value: 11.167505","variable: Minimum Wage, Inflation Adjusted<br />Year: 1980<br />value: 10.479992","variable: Minimum Wage, Inflation Adjusted<br />Year: 1981<br />value: 10.127551","variable: Minimum Wage, Inflation Adjusted<br />Year: 1982<br />value:  9.343551","variable: Minimum Wage, Inflation Adjusted<br />Year: 1983<br />value:  9.009171","variable: Minimum Wage, Inflation Adjusted<br />Year: 1984<br />value:  8.646682","variable: Minimum Wage, Inflation Adjusted<br />Year: 1985<br />value:  8.351629","variable: Minimum Wage, Inflation Adjusted<br />Year: 1986<br />value:  8.039205","variable: Minimum Wage, Inflation Adjusted<br />Year: 1987<br />value:  7.923533","variable: Minimum Wage, Inflation Adjusted<br />Year: 1988<br />value:  7.615358","variable: Minimum Wage, Inflation Adjusted<br />Year: 1989<br />value:  7.275780","variable: Minimum Wage, Inflation Adjusted<br />Year: 1990<br />value:  6.915988","variable: Minimum Wage, Inflation Adjusted<br />Year: 1991<br />value:  7.425358","variable: Minimum Wage, Inflation Adjusted<br />Year: 1992<br />value:  8.094203","variable: Minimum Wage, Inflation Adjusted<br />Year: 1993<br />value:  7.838776","variable: Minimum Wage, Inflation Adjusted<br />Year: 1994<br />value:  7.645756","variable: Minimum Wage, Inflation Adjusted<br />Year: 1995<br />value:  7.437189","variable: Minimum Wage, Inflation Adjusted<br />Year: 1996<br />value:  7.239699","variable: Minimum Wage, Inflation Adjusted<br />Year: 1997<br />value:  7.852398","variable: Minimum Wage, Inflation Adjusted<br />Year: 1998<br />value:  8.381944","variable: Minimum Wage, Inflation Adjusted<br />Year: 1999<br />value:  8.244200","variable: Minimum Wage, Inflation Adjusted<br />Year: 2000<br />value:  8.024420","variable: Minimum Wage, Inflation Adjusted<br />Year: 2001<br />value:  7.735706","variable: Minimum Wage, Inflation Adjusted<br />Year: 2002<br />value:  7.648346","variable: Minimum Wage, Inflation Adjusted<br />Year: 2003<br />value:  7.454717","variable: Minimum Wage, Inflation Adjusted<br />Year: 2004<br />value:  7.313834","variable: Minimum Wage, Inflation Adjusted<br />Year: 2005<br />value:  7.102895","variable: Minimum Wage, Inflation Adjusted<br />Year: 2006<br />value:  6.830671","variable: Minimum Wage, Inflation Adjusted<br />Year: 2007<br />value:  6.691774","variable: Minimum Wage, Inflation Adjusted<br />Year: 2008<br />value:  7.289331","variable: Minimum Wage, Inflation Adjusted<br />Year: 2009<br />value:  8.159123","variable: Minimum Wage, Inflation Adjusted<br />Year: 2010<br />value:  8.800027","variable: Minimum Wage, Inflation Adjusted<br />Year: 2011<br />value:  8.658730","variable: Minimum Wage, Inflation Adjusted<br />Year: 2012<br />value:  8.412642","variable: Minimum Wage, Inflation Adjusted<br />Year: 2013<br />value:  8.280578","variable: Minimum Wage, Inflation Adjusted<br />Year: 2014<br />value:  8.151864","variable: Minimum Wage, Inflation Adjusted<br />Year: 2015<br />value:  8.159154","variable: Minimum Wage, Inflation Adjusted<br />Year: 2016<br />value:  8.048640","variable: Minimum Wage, Inflation Adjusted<br />Year: 2017<br />value:  7.852328","variable: Minimum Wage, Inflation Adjusted<br />Year: 2018<br />value:  7.693043","variable: Minimum Wage, Inflation Adjusted<br />Year: 2019<br />value:  7.575529"],"type":"scatter","mode":"lines","line":{"width":1.88976377952756,"color":"rgba(0,191,196,1)","dash":"solid"},"hoveron":"points","name":"Minimum Wage, Inflation Adjusted","legendgroup":"Minimum Wage, Inflation Adjusted","showlegend":true,"xaxis":"x","yaxis":"y","hoverinfo":"text","frame":null}],"layout":{"margin":{"t":48.1461187214612,"r":7.30593607305936,"b":44.5662100456621,"l":31.4155251141553},"paper_bgcolor":"rgba(255,255,255,1)","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187},"title":{"text":"<b> Minimum Wage Actual vs. Inflation Adjusted 1968 to 2019 <\/b>","font":{"color":"rgba(0,0,0,1)","family":"","size":17.5342465753425},"x":0.5,"xref":"paper"},"xaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[1965.45,2021.55],"tickmode":"array","ticktext":["1970","1980","1990","2000","2010","2020"],"tickvals":[1970,1980,1990,2000,2010,2020],"categoryorder":"array","categoryarray":["1970","1980","1990","2000","2010","2020"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":false,"gridcolor":null,"gridwidth":0,"zeroline":false,"anchor":"y","title":{"text":"Year","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"yaxis":{"domain":[0,1],"automargin":true,"type":"linear","autorange":false,"range":[0.649124743777452,11.6683803806735],"tickmode":"array","ticktext":["3","6","9"],"tickvals":[3,6,9],"categoryorder":"array","categoryarray":["3","6","9"],"nticks":null,"ticks":"outside","tickcolor":"rgba(51,51,51,1)","ticklen":3.65296803652968,"tickwidth":0.66417600664176,"showticklabels":true,"tickfont":{"color":"rgba(77,77,77,1)","family":"","size":11.689497716895},"tickangle":-0,"showline":false,"linecolor":null,"linewidth":0,"showgrid":false,"gridcolor":null,"gridwidth":0,"zeroline":false,"anchor":"x","title":{"text":"Value","font":{"color":"rgba(0,0,0,1)","family":"","size":14.6118721461187}},"hoverformat":".2f"},"shapes":[{"type":"rect","fillcolor":"transparent","line":{"color":"rgba(51,51,51,1)","width":0.66417600664176,"linetype":"solid"},"yref":"paper","xref":"paper","x0":0,"x1":1,"y0":0,"y1":1}],"showlegend":true,"legend":{"bgcolor":"rgba(255,255,255,1)","bordercolor":"transparent","borderwidth":1.88976377952756,"font":{"color":"rgba(0,0,0,1)","family":"","size":11.689497716895},"y":1},"hovermode":"closest","barmode":"relative"},"config":{"doubleClick":"reset","showSendToCloud":false},"source":"A","attrs":{"19441c8e3c1a":{"colour":{},"x":{},"y":{},"type":"scatter"}},"cur_data":"19441c8e3c1a","visdat":{"19441c8e3c1a":["function (y) ","x"]},"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.2,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

