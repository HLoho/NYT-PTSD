#Veterans and PTSD NYT Subproject Scripts
#Adam Chekroud and Hieronimus Loho

#Housekeeping
libs <- c("tidyverse", "RColorBrewer","stringr", "foreach", "forcats", "dplyr")
invisible(lapply(libs, require, character.only = TRUE))

setwd("/Users/hieronimusloho/Box Sync/Research Stuff/NewYorkTimes")

#Load the main RDS with all of the hits for all terms
all.yearly <- readRDS(file = "Processed_Data/all_terms_hits.yearly.RDS")
mil.pop <- read_csv(file = "CSVs/other/Military_Count.csv")

#Filter out for the terms we want
vets.ptsd.bf.ss.vs.yearly <- all.yearly %>%
  filter(term == "(vets*) AND PTSD" |
           term == "(vets*) AND battle fatigue" |
           term == "(vets*) AND shell shock" |
           term == "(vets*) AND (post) Vietnam syndrome")
 
#Re-level terms 
vets.ptsd.bf.ss.vs.yearly$term <- fct_relevel(vets.ptsd.bf.ss.vs.yearly$term, c("(vets*) AND shell shock",
                                              "(vets*) AND battle fatigue", 
                                              "(vets*) AND (post) Vietnam syndrome", 
                                              "(vets*) AND PTSD"))

#Set color scheme in the dataframe
vets.ptsd.bf.ss.vs.yearly$color <- c(rep("#e41a1c", 117),
                                     rep("#377eb8", 117),
                                     rep("#4daf4a", 117),
                                     rep("#984ea3", 117))

#Facet wrapped plot of ptsd, battle fatigue, shell shock and Vietnam syndrome
vets.ptsd_all_forms.yearly.1900.facet.plot <- vets.ptsd.bf.ss.vs.yearly %>%
  ggplot(aes(x = year, y = yearly_percentage, color = color)) +
  facet_wrap(~term, ncol = 1, scales = "free_y") +
  geom_line(color = vets.ptsd.bf.ss.vs.yearly$color) + 
  theme_bw() +
  theme(panel.border = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black")) +
  theme(legend.position = "none") +
  annotate("text", x = 1918, y = 0, label = "WWI", size = 3) + 
  annotate("segment", x = 1918, xend= 1918, y = 0, yend = Inf, alpha = 0.5, lty = 3) +
  annotate("text", x = 1945, y = 0, label = "WWII", size = 3) + 
  annotate("segment", x = 1945, xend = 1945, y = 0, yend = Inf, alpha = 0.5, lty = 3) +
  annotate("text", x = 1975, y = 0, label = "Vietnam War", size = 3) +
  annotate("segment", x = 1975, xend = 1975, y = 0, yend = Inf, alpha = 0.5, lty = 3) +
  annotate("text", x = 1990, y = 0, label = "Gulf War", size = 3) +
  annotate("segment", x = 1991, xend = 1991, y = 0, yend = Inf, alpha = 0.5, lty = 3) +
  annotate("text", x = 2009, y = 0, label = "Afghanistan and Iraq Wars", size = 3) +
  annotate("segment", x = 2016, xend = 2016, y = 0, yend = Inf, alpha = 0.5, lty = 3) +
  scale_x_continuous(breaks = seq(1900,2010,10)) +
  ylab("% of total articles per year") +
  xlab("Year") +
  ggtitle(paste("Use of 'PTSD' with veterans in popular media"),
          subtitle = "NYT, Reuters, and AP sources, 1900-2016 \nvets* = 'veteran or soldier or military or armedforces'")

#Save the graphs 
ggsave(vets.ptsd_all_forms.yearly.1900.facet.plot, 
        file = "Figures/Figure1.pdf",
        height = 7.07, width = 11)
