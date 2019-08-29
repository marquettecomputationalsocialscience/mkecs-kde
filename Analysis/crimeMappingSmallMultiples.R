library(ggplot2)
library(gridExtra)
library(forcats)

rm(list=ls())

# function for easily counting the occurances of where the default parameter is changed
find_values <- function(group) {
  p1_k_def <- 0
  p1_k_nondef <- 0
  p1_b_def <- 0
  p1_b_nondef <- 0
  p1_m_def <- 0
  p1_m_nondef <- 0
  
  p2_k_def <- 0
  p2_k_nondef <- 0
  p2_b_def <- 0
  p2_b_nondef <- 0
  p2_m_def <- 0
  p2_m_nondef <- 0
  
  p3_k_def <- 0
  p3_k_nondef <- 0
  p3_b_def <- 0
  p3_b_nondef <- 0
  p3_m_def <- 0
  p3_m_nondef <- 0
  
  # logic for picture 1
  #
  for (x in group$kernel1){
    if (x == "gaussian") {
      p1_k_def <- p1_k_def + 1
    }
    else {
      p1_k_nondef <- p1_k_nondef + 1
    }
  }
  for (x in group$bandwidth1){
    if (x == 0.005){
      p1_b_def <- p1_b_def + 1
    }
    else{
      p1_b_nondef <- p1_b_nondef + 1
    }
  }
  for (x in group$metric1){
    if (x == "euclidean"){
      p1_m_def <- p1_m_def + 1
    }
    else{
      p1_m_nondef <- p1_m_nondef + 1
    }
  }
  
  # logic for picture 2
  #
  for (x in group$kernel2){
    if (x == "gaussian") {
      p2_k_def <- p2_k_def + 1
    }
    else {
      p2_k_nondef <- p2_k_nondef + 1
    }
  }
  for (x in group$bandwidth2){
    if (x == 0.005){
      p2_b_def <- p2_b_def + 1
    }
    else{
      p2_b_nondef <- p2_b_nondef + 1
    }
  }
  for (x in group$metric2){
    if (x == "euclidean"){
      p2_m_def <- p2_m_def + 1
    }
    else{
      p2_m_nondef <- p2_m_nondef + 1
    }
  }
  
  #logic for picture 3
  #
  for (x in group$kernel3){
    if (x == "gaussian") {
      p3_k_def <- p3_k_def + 1
    }
    else {
      p3_k_nondef <- p3_k_nondef + 1
    }
  }
  for (x in group$bandwidth3){
    if (x == 0.005){
      p3_b_def <- p3_b_def + 1
    }
    else{
      p3_b_nondef <- p3_b_nondef + 1
    }
  }
  for (x in group$metric3){
    if (x == "euclidean"){
      p3_m_def <- p3_m_def + 1
    }
    else{
      p3_m_nondef <- p3_m_nondef + 1
    }
  }
  
  return (c(p1_k_def, p1_k_nondef, p1_b_def, p1_b_nondef, p1_m_def, p1_m_nondef,
            p2_k_def, p2_k_nondef, p2_b_def, p2_b_nondef, p2_m_def, p2_m_nondef,
            p3_k_def, p3_k_nondef, p3_b_def, p3_b_nondef, p3_m_def, p3_m_nondef))
}

#
# IF CODE IS BEING RERUN, MAKE SURE THIS NEXT LINE POINTS TO THE DATA FILE
#
map_data <- read.csv('/Users/Joey/mkecs-kde/Analysis/data/map-data.csv')

# get the subgroups per background
group1 <- subset(map_data, group_num==1)
group2 <- subset(map_data, group_num==2)
group3 <- subset(map_data, group_num==3)


#
# this section deals with defaults. it will answer the questions, "Do people change the default parameters?" and 
#"Does a person's background affect the choice of if they change the default parameter?"
#


# set up the new dataframe of if people changed the default values and the respective counts
parameters <- rep(c('default kernel', 'changed kernel', 'default bandwidth', 'changed bandwidth', 'default metric', 'changed metric'), 3)
picture_num <- c(1,1,1,1,1,1,
                 2,2,2,2,2,2,
                 3,3,3,3,3,3)
group1_data <- find_values(group1)
group2_data <- find_values(group2)
group3_data <- find_values(group3)
parameter_data <- data.frame(parameters, group1_data, group2_data, group3_data, picture_num)

# organize new dataframes pertaining to the specific groups and picture
g1p1 <- parameter_data[c(1:6), c(-3,-4)]
g1p2 <- parameter_data[c(7:12), c(-3,-4)]
g1p3 <- parameter_data[c(13:18), c(-3,-4)]
g2p1 <- parameter_data[c(1:6), c(-2,-4)]
g2p2 <- parameter_data[c(7:12), c(-2,-4)]
g2p3 <- parameter_data[c(13:18), c(-2,-4)]
g3p1 <- parameter_data[c(1:6), c(-2,-3)]
g3p2 <- parameter_data[c(7:12), c(-2,-3)]
g3p3 <- parameter_data[c(13:18), c(-2,-3)]

# long code for plotting the graphs nicely
g1p1_graph <- ggplot(g1p1, aes(fct_inorder(g1p1$parameters), g1p1$group1_data)) +xlab(" ")+ylab(" ")+ ggtitle("No background vs map 1") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")
g1p2_graph <- ggplot(g1p2, aes(fct_inorder(g1p2$parameters), g1p2$group1_data)) +xlab(" ")+ylab(" ")+ ggtitle("No background vs map 2") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")
g1p3_graph <- ggplot(g1p3, aes(fct_inorder(g1p3$parameters), g1p3$group1_data)) +xlab(" ")+ylab(" ")+ ggtitle("No background vs map 3") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")
g2p1_graph <- ggplot(g2p1, aes(fct_inorder(g2p1$parameters), g2p1$group2_data)) +xlab(" ")+ylab(" ")+ ggtitle("Technical back. vs map 1") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")
g2p2_graph <- ggplot(g2p2, aes(fct_inorder(g2p2$parameters), g2p2$group2_data)) +xlab(" ")+ylab(" ")+ ggtitle("Technical back. vs map 2") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")
g2p3_graph <- ggplot(g2p3, aes(fct_inorder(g2p3$parameters), g2p3$group2_data)) +xlab(" ")+ylab(" ")+ ggtitle("Technical back. vs map 3") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")
g3p1_graph <- ggplot(g3p1, aes(fct_inorder(g3p1$parameters), g3p1$group3_data)) +xlab(" ")+ylab(" ")+ ggtitle("Professional back. vs map 1") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")
g3p2_graph <- ggplot(g3p2, aes(fct_inorder(g3p2$parameters), g3p2$group3_data)) +xlab(" ")+ylab(" ")+ ggtitle("Professional back. vs map 2") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")
g3p3_graph <- ggplot(g3p3, aes(fct_inorder(g3p3$parameters), g3p3$group3_data)) +xlab(" ")+ylab(" ")+ ggtitle("Professional back. vs map 3") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")

# collects the graphs above into one figure
grid.arrange(g1p1_graph, g1p2_graph, g1p3_graph,
             g2p1_graph, g2p2_graph, g2p3_graph,
             g3p1_graph, g3p2_graph, g3p3_graph, ncol=3, nrow=3)
# Answers "how do people of different backgrounds interact with algorithmic crime analysis tools?"
# group 1: no background
#   no clear idea. most people changed the parameters just to change them and see the outcome
# group 2: technical background
#   if there was a change, most people changed the bandwidth.
#     are they changing it because they know it in relation to KDEs or the WiFi bandwidth definition?
# group 3: professional background (LEO)
#   nobody changed the parameters. they left the parameters as is and made the decisions based off of the defaults


#
# this section deals with a person's response to how many hotspots they see and how many circles they think is needed
#

#
# min and max hotspots seen compared to gold standard
#
map_data1 <- subset(map_data, min_hotspots1 < 75)
map_data1 <- subset(map_data1, min_hotspots2 < 75)
map_data1 <- subset(map_data1, min_hotspots3 < 75)
map_data1 <- subset(map_data1, max_hotspots1 < 75)
map_data1 <- subset(map_data1, max_hotspots2 < 75)
map_data1 <- subset(map_data1, max_hotspots3 < 75)
p1_min_hotspot_ <- ggplot(map_data1, aes(group_num, min_hotspots1)) + geom_hline(yintercept=8) +geom_text(aes(0,8,label = 8,vjust=-1))+xlab(" ")+ylab(" ")+ ggtitle("Min hotspots seen, m1")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p2_min_hotspot_ <- ggplot(map_data1, aes(group_num, min_hotspots2)) + geom_hline(yintercept=7) +geom_text(aes(0,7,label = 7,vjust=-1))+xlab(" ")+ylab(" ")+ ggtitle("Min hotspots seen, m2")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p3_min_hotspot_ <- ggplot(map_data1, aes(group_num, min_hotspots3)) + geom_hline(yintercept=5) +geom_text(aes(0,5,label = 5,vjust=-1))+xlab(" ")+ylab(" ")+ ggtitle("Min hotspots seen, m3")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p1_max_hotspot_ <- ggplot(map_data1, aes(group_num, max_hotspots1)) + geom_hline(yintercept=11) +geom_text(aes(0,11,label = 11,vjust=-1))+xlab(" ")+ylab(" ")+ ggtitle("Max hotspots seen, m1")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p2_max_hotspot_ <- ggplot(map_data1, aes(group_num, max_hotspots2)) + geom_hline(yintercept=9) +geom_text(aes(0,9,label = 9,vjust=-1))+xlab(" ")+ylab(" ")+ ggtitle("Max hotspots seen, m2")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p3_max_hotspot_ <- ggplot(map_data1, aes(group_num, max_hotspots3)) + geom_hline(yintercept=9) +geom_text(aes(0,9,label = 9,vjust=-1))+xlab(" ")+ylab(" ")+ ggtitle("Max hotspots seen, m3")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)

grid.arrange(p1_min_hotspot_, p2_min_hotspot_, p3_min_hotspot_,
             p1_max_hotspot_, p2_max_hotspot_, p3_max_hotspot_, ncol=3, nrow=2)
# "how do people of different backgrounds interpret algorithmic crime analysis models?"
# group 1: no background
#   most people overestimated the amount of hotspots seen, both on the minimum and maximum values
# group 2: technical background
#   most people still overestimated the amount of hotspots, but is much closer to the gold standard chosen
# group 3: professional background (LEO)
#   still overestimated the amount of hotspots seen, but was the closest to the gold standard of the other 2 groups


#
# min and max circles needed compared to gold standard
#
map_data1 <- subset(map_data1, min_circles1 < 51)
map_data1 <- subset(map_data1, min_circles2 < 51)
map_data1 <- subset(map_data1, min_circles3 < 51)
map_data1 <- subset(map_data1, max_circles1 < 51)
map_data1 <- subset(map_data1, max_circles2 < 51)
map_data1 <- subset(map_data1, max_circles3 < 51)
p1_min_circle_ <- ggplot(map_data1, aes(group_num, min_circles1)) + geom_hline(yintercept=8) +geom_text(aes(0,8,label = 8,vjust=-1))+xlab(" ")+ylab(" ")+ ggtitle("Min circles needed, m1")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p2_min_circle_ <- ggplot(map_data1, aes(group_num, min_circles2)) + geom_hline(yintercept=7) +geom_text(aes(0,7,label = 7,vjust=-1))+xlab(" ")+ylab(" ")+ ggtitle("Min circles needed, m2")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p3_min_circle_ <- ggplot(map_data1, aes(group_num, min_circles3)) + geom_hline(yintercept=6) +geom_text(aes(0,6,label = 6,vjust=-1))+xlab(" ")+ylab(" ")+ ggtitle("Min circles needed, m3")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p1_max_circle_ <- ggplot(map_data1, aes(group_num, max_circles1)) + geom_hline(yintercept=13) +geom_text(aes(0,13,label = 13,vjust=-1))+xlab(" ")+ylab(" ")+ ggtitle("Max circles needed, m1")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p2_max_circle_ <- ggplot(map_data1, aes(group_num, max_circles2)) + geom_hline(yintercept=10) +geom_text(aes(0,10,label = 10,vjust=-1))+xlab(" ")+ylab(" ")+ ggtitle("Max circles needed, m2")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p3_max_circle_ <- ggplot(map_data1, aes(group_num, max_circles3)) + geom_hline(yintercept=10) +geom_text(aes(0,10,label = 10,vjust=-1))+xlab(" ")+ylab(" ")+ ggtitle("Max circles needed, m3")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)

grid.arrange(p1_min_circle_, p2_min_circle_, p3_min_circle_,
             p1_max_circle_, p2_max_circle_, p3_max_circle_, ncol=3, nrow=2)
# "how do people of different backgrounds interpret algorithmic crime analysis models?"
# group 1: no background
#   almost normal distribution of points. about half overestimate and half underestimate, with some giving the correct answer
# group 2: technical background
#   very spread out overestimations, with some giving the correct answer
# group 3: professional background (LEO)
#   all respondents overestimated the amount of area circles needed. only 1 respondent underestimated and 1 got the correct answer on p3


# map1_g1
#
map1_g1_minHotspots <- 0
map1_g1_maxHotspots <- 0
map1_g1_minCircles <- 0
map1_g1_maxCircles <- 0
for (x in 1:(length(group1$min_hotspots1))){
  difference1 <- group1$min_hotspots1[x] - 8
  difference2 <- group1$max_hotspots1[x] - 11
  difference3 <- group1$min_circles1[x] - 8
  difference4 <- group1$max_circles1[x] - 13
  map1_g1_minHotspots <- map1_g1_minHotspots + difference1
  map1_g1_maxHotspots <- map1_g1_maxHotspots + difference2
  map1_g1_minCircles <- map1_g1_minCircles + difference3
  map1_g1_maxCircles <- map1_g1_maxCircles + difference4
}

# map1_g2
#
map1_g2_minHotspots <- 0
map1_g2_maxHotspots <- 0
map1_g2_minCircles <- 0
map1_g2_maxCircles <- 0
for (x in 1:(length(group2$min_hotspots1))){
  difference1 <- group2$min_hotspots1[x] - 8
  difference2 <- group2$max_hotspots1[x] - 11
  difference3 <- group2$min_circles1[x] - 8
  difference4 <- group2$max_circles1[x] - 13
  map1_g2_minHotspots <- map1_g2_minHotspots + difference1
  map1_g2_maxHotspots <- map1_g2_maxHotspots + difference2
  map1_g2_minCircles <- map1_g2_minCircles + difference3
  map1_g2_maxCircles <- map1_g2_maxCircles + difference4
}

# map1_g3
#
map1_g3_minHotspots <- 0
map1_g3_maxHotspots <- 0
map1_g3_minCircles <- 0
map1_g3_maxCircles <- 0
for (x in 1:(length(group3$min_hotspots1))){
  difference1 <- group3$min_hotspots1[x] - 8
  difference2 <- group3$max_hotspots1[x] - 11
  difference3 <- group3$min_circles1[x] - 8
  difference4 <- group3$max_circles1[x] - 13
  map1_g3_minHotspots <- map1_g3_minHotspots + difference1
  map1_g3_maxHotspots <- map1_g3_maxHotspots + difference2
  map1_g3_minCircles <- map1_g3_minCircles + difference3
  map1_g3_maxCircles <- map1_g3_maxCircles + difference4
}

# map2_g1
#
map2_g1_minHotspots <- 0
map2_g1_maxHotspots <- 0
map2_g1_minCircles <- 0
map2_g1_maxCircles <- 0
for (x in 1:(length(group1$min_hotspots2))){
  difference1 <- group1$min_hotspots2[x] - 7
  difference2 <- group1$max_hotspots2[x] - 9
  difference3 <- group1$min_circles2[x] - 7
  difference4 <- group1$max_circles2[x] - 10
  map2_g1_minHotspots <- map2_g1_minHotspots + difference1
  map2_g1_maxHotspots <- map2_g1_maxHotspots + difference2
  map2_g1_minCircles <- map2_g1_minCircles + difference3
  map2_g1_maxCircles <- map2_g1_maxCircles + difference4
}

# map2_g2
#
map2_g2_minHotspots <- 0
map2_g2_maxHotspots <- 0
map2_g2_minCircles <- 0
map2_g2_maxCircles <- 0
for (x in 1:(length(group2$min_hotspots2))){
  difference1 <- group2$min_hotspots2[x] - 7
  difference2 <- group2$max_hotspots2[x] - 9
  difference3 <- group2$min_circles2[x] - 7
  difference4 <- group2$max_circles2[x] - 10
  map2_g2_minHotspots <- map2_g2_minHotspots + difference1
  map2_g2_maxHotspots <- map2_g2_maxHotspots + difference2
  map2_g2_minCircles <- map2_g2_minCircles + difference3
  map2_g2_maxCircles <- map2_g2_maxCircles + difference4
}

# map2_g3
#
map2_g3_minHotspots <- 0
map2_g3_maxHotspots <- 0
map2_g3_minCircles <- 0
map2_g3_maxCircles <- 0
for (x in 1:(length(group3$min_hotspots2))){
  difference1 <- group3$min_hotspots2[x] - 7
  difference2 <- group3$max_hotspots2[x] - 9
  difference3 <- group3$min_circles2[x] - 7
  difference4 <- group3$max_circles2[x] - 10
  map2_g3_minHotspots <- map2_g3_minHotspots + difference1
  map2_g3_maxHotspots <- map2_g3_maxHotspots + difference2
  map2_g3_minCircles <- map2_g3_minCircles + difference3
  map2_g3_maxCircles <- map2_g3_maxCircles + difference4
}

# map3_g1
#
map3_g1_minHotspots <- 0
map3_g1_maxHotspots <- 0
map3_g1_minCircles <- 0
map3_g1_maxCircles <- 0
for (x in 1:(length(group1$min_hotspots3))){
  difference1 <- group1$min_hotspots3[x] - 8
  difference2 <- group1$max_hotspots3[x] - 11
  difference3 <- group1$min_circles3[x] - 8
  difference4 <- group1$max_circles3[x] - 13
  map3_g1_minHotspots <- map3_g1_minHotspots + difference1
  map3_g1_maxHotspots <- map3_g1_maxHotspots + difference2
  map3_g1_minCircles <- map3_g1_minCircles + difference3
  map3_g1_maxCircles <- map3_g1_maxCircles + difference4
}

# map3_g2
#
map3_g2_minHotspots <- 0
map3_g2_maxHotspots <- 0
map3_g2_minCircles <- 0
map3_g2_maxCircles <- 0
for (x in 1:(length(group2$min_hotspots3))){
  difference1 <- group2$min_hotspots3[x] - 5
  difference2 <- group2$max_hotspots3[x] - 9
  difference3 <- group2$min_circles3[x] - 6
  difference4 <- group2$max_circles3[x] - 10
  map3_g2_minHotspots <- map3_g2_minHotspots + difference1
  map3_g2_maxHotspots <- map3_g2_maxHotspots + difference2
  map3_g2_minCircles <- map3_g2_minCircles + difference3
  map3_g2_maxCircles <- map3_g2_maxCircles + difference4
}

# map3_g3
#
map3_g3_minHotspots <- 0
map3_g3_maxHotspots <- 0
map3_g3_minCircles <- 0
map3_g3_maxCircles <- 0
for (x in 1:(length(group3$min_hotspots3))){
  difference1 <- group3$min_hotspots3[x] - 5
  difference2 <- group3$max_hotspots3[x] - 9
  difference3 <- group3$min_circles3[x] - 6
  difference4 <- group3$max_circles3[x] - 10
  map3_g3_minHotspots <- map3_g3_minHotspots + difference1
  map3_g3_maxHotspots <- map3_g3_maxHotspots + difference2
  map3_g3_minCircles <- map3_g3_minCircles + difference3
  map3_g3_maxCircles <- map3_g3_maxCircles + difference4
}

# min hotspots compared to the gold standard
#
message(sprintf("map 1 min hotspots\ngold standard = 8\ng1: %s\ng2: %s\ng3: %s", 
                map1_g1_minHotspots, map1_g2_minHotspots, map1_g3_minHotspots))

message(sprintf("map 2 min hotspots\ngold standard = 7\ng1: %s\ng2: %s\ng3: %s", 
                map2_g1_minHotspots, map2_g2_minHotspots, map2_g3_minHotspots))

message(sprintf("map 3 min hotspots\ngold standard = 5\ng1: %s\ng2: %s\ng3: %s", 
                map3_g1_minHotspots, map3_g2_minHotspots, map3_g3_minHotspots))

# max hotspots compared to the gold standard
#
message(sprintf("map 1 max hotspots\ngold standard = 11\ng1: %s\ng2: %s\ng3: %s", 
                map1_g1_maxHotspots, map1_g2_maxHotspots, map1_g3_maxHotspots))

message(sprintf("map 2 max hotspots\ngold standard = 9\ng1: %s\ng2: %s\ng3: %s", 
                map2_g1_maxHotspots, map2_g2_maxHotspots, map2_g3_maxHotspots))

message(sprintf("map 3 max hotspots\ngold standard = 9\ng1: %s\ng2: %s\ng3: %s", 
                map3_g1_maxHotspots, map3_g2_maxHotspots, map3_g3_maxHotspots))

# min circles compared to the gold standard
#
message(sprintf("map 1 min circles\ngold standard = 8\ng1: %s\ng2: %s\ng3: %s", 
                map1_g1_minCircles, map1_g2_minCircles, map1_g3_minCircles))

message(sprintf("map 2 min circles\ngold standard = 7\ng1: %s\ng2: %s\ng3: %s", 
                map2_g1_minCircles, map2_g2_minCircles, map2_g3_minCircles))

message(sprintf("map 3 min circles\ngold standard = 6\ng1: %s\ng2: %s\ng3: %s", 
                map3_g1_minCircles, map3_g2_minCircles, map3_g3_minCircles))

# max circles compared to the gold standard
#
message(sprintf("map 1 max circles\ngold standard = 13\ng1: %s\ng2: %s\ng3: %s", 
                map1_g1_maxCircles, map1_g2_maxCircles, map1_g3_maxCircles))

message(sprintf("map 2 max circles\ngold standard = 10\ng1: %s\ng2: %s\ng3: %s", 
                map2_g1_maxCircles, map2_g2_maxCircles, map2_g3_maxCircles))

message(sprintf("map 3 max circles\ngold standard = 13\ng1: %s\ng2: %s\ng3: %s", 
                map3_g1_maxCircles, map3_g2_maxCircles, map3_g3_maxCircles))





