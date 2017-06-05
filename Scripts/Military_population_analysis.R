#Military population vs. PTSD and Veteran mentions analyses

#Housekeeping
libs <- c("tidyverse", "RColorBrewer","stringr", "foreach", "forcats", "dplyr")
invisible(lapply(libs, require, character.only = TRUE))

setwd("/Users/hieronimusloho/Box Sync/Research Stuff/NYT-PTSD")

#Load data
all.yearly <- readRDS(file = "Processed_Data/all_terms_hits.yearly.RDS")
mil.pop <- read_csv(file = "CSVs/other/Mil.Vs.Total.Pop.csv")

#Correlation of US military population percentage with PTSD (all forms) mentions
#Not significant p = 0.404
ptsd_all_forms_.vs.mil.pop.corr <- cor.test(mil.pop$mil_percent, 
                                                (filter(all.yearly, term == "(vets*) AND PTSD_all_forms"))$yearly_percentage,
                                                method = "pearson")

###Function borrowed from R-CookBook: http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/ 
# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}


###Visualizations of the comparions of vets/PTSD/MH NYT mentions with percentage of US population in military.
#Plot military population as a percentage of total US population by year
mil.pop.yearly.plot <- mil.pop %>%
  select(year, mil_percent) %>%
  ggplot(aes(x = year, y = mil_percent)) + 
  geom_line() + 
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  scale_x_continuous(breaks = seq(1900,2010,10)) +
  ylab("% of US population in active duty military") +
  xlab("Year") +
  ggtitle(paste("US military population as a percentage of total US population"),
          subtitle = "Military population data sourced from DoD Selected Manpower Statistics \nUS total population data sourced from US Census Bureau")

#Plot all forms of PTSD hits as a percentage of all total articles by year         
ptsd_all_forms.yearly.plot <- all.yearly %>%
  filter(term == "(vets*) AND PTSD_all_forms") %>%
  ggplot(aes(x = year, y = yearly_percentage)) + 
  geom_line() + 
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  scale_x_continuous(breaks = seq(1900,2010,10)) +
  ylab("% of total articles per year") +
  xlab("Year") +
  ggtitle(paste("Use of (vets*) AND PTSD(all forms) in popular media"),
          subtitle = "NYT, Reuters, and AP sources, 1900-2016 \nvets* = 'veteran or soldier or military or armedforces'")


#Combine the two plots together and save
multiplot(ptsd_all_forms.yearly.plot, mil.pop.yearly.plot)
dev.copy(pdf,"Figures/PTSD/ptsd_all_forms.vs.mil.pop.yearly.percent.pdf")
dev.copy(postscript,"Figures/PTSD/ptsd_all_forms.vs.mil.pop.yearly.percent.eps")
dev.off()