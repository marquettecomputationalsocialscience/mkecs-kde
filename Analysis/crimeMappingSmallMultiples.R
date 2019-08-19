library(ggplot2)
library(gridExtra)

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
g1p1_graph <- ggplot(g1p1, aes(fct_inorder(g1p1$parameters), g1p1$group1_data)) +xlab(" ")+ylab(" ")+ ggtitle("No background vs pic 1") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")
g1p2_graph <- ggplot(g1p2, aes(fct_inorder(g1p2$parameters), g1p2$group1_data)) +xlab(" ")+ylab(" ")+ ggtitle("No background vs pic 2") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")
g1p3_graph <- ggplot(g1p3, aes(fct_inorder(g1p3$parameters), g1p3$group1_data)) +xlab(" ")+ylab(" ")+ ggtitle("No background vs pic 3") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")
g2p1_graph <- ggplot(g2p1, aes(fct_inorder(g2p1$parameters), g2p1$group2_data)) +xlab(" ")+ylab(" ")+ ggtitle("Technical back. vs pic 1") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")
g2p2_graph <- ggplot(g2p2, aes(fct_inorder(g2p2$parameters), g2p2$group2_data)) +xlab(" ")+ylab(" ")+ ggtitle("Technical back. vs pic 2") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")
g2p3_graph <- ggplot(g2p3, aes(fct_inorder(g2p3$parameters), g2p3$group2_data)) +xlab(" ")+ylab(" ")+ ggtitle("Technical back. vs pic 3") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")
g3p1_graph <- ggplot(g3p1, aes(fct_inorder(g3p1$parameters), g3p1$group3_data)) +xlab(" ")+ylab(" ")+ ggtitle("Professional back. vs pic 1") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")
g3p2_graph <- ggplot(g3p2, aes(fct_inorder(g3p2$parameters), g3p2$group3_data)) +xlab(" ")+ylab(" ")+ ggtitle("Professional back. vs pic 2") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")
g3p3_graph <- ggplot(g3p3, aes(fct_inorder(g3p3$parameters), g3p3$group3_data)) +xlab(" ")+ylab(" ")+ ggtitle("Professional back. vs pic 3") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + geom_bar(stat="identity")

# collects the graphs above into one figure
grid.arrange(g1p1_graph, g1p2_graph, g1p3_graph,
             g2p1_graph, g2p2_graph, g2p3_graph,
             g3p1_graph, g3p2_graph, g3p3_graph, ncol=3, nrow=3)


#
# this section deals with a person's response to how many hotspots they see and how many circles they think is needed
#

# remove rows with answers > 55 (helps with looking at the graphs for now)
#test_data <- map_data[!(map_data$min_hotspots1 > 55 & map_data$min_hotspots2 > 55 & map_data$min_hotspots3 > 55),]
#map_data <- test_data[!(test_data$min_circles1 > 55 & test_data$min_circles2 > 55 & test_data$min_circles3 > 55),]

#
# min and max hotspots seen compared to gold standard
#
p1_min_hotspot <- ggplot(map_data, aes(new_part_id, min_hotspots1)) + geom_hline(yintercept=8) +xlab(" ")+ylab(" ")+ ggtitle("Min hotspots seen, p1")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p2_min_hotspot <- ggplot(map_data, aes(new_part_id, min_hotspots2)) + geom_hline(yintercept=7) +xlab(" ")+ylab(" ")+ ggtitle("Min hotspots seen, p2")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p3_min_hotspot <- ggplot(map_data, aes(new_part_id, min_hotspots3)) + geom_hline(yintercept=5) +xlab(" ")+ylab(" ")+ ggtitle("Min hotspots seen, p3")+ geom_point(aes(color=group_num))
p1_max_hotspot <- ggplot(map_data, aes(new_part_id, max_hotspots1)) + geom_hline(yintercept=11) +xlab(" ")+ylab(" ")+ ggtitle("Max hotspots seen, p1")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p2_max_hotspot <- ggplot(map_data, aes(new_part_id, max_hotspots2)) + geom_hline(yintercept=9) +xlab(" ")+ylab(" ")+ ggtitle("Max hotspots seen, p2")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p3_max_hotspot <- ggplot(map_data, aes(new_part_id, max_hotspots3)) + geom_hline(yintercept=9) +xlab(" ")+ylab(" ")+ ggtitle("Max hotspots seen, p3")+ geom_point(aes(color=group_num))

grid.arrange(p1_min_hotspot, p2_min_hotspot, p3_min_hotspot,
             p1_max_hotspot, p2_max_hotspot, p3_max_hotspot, ncol=3, nrow=2)

# same graph of data as above, but does not show every person's response. gives more of an idea of what the deviation is
#
p1_min_hotspot_ <- ggplot(map_data, aes(group_num, min_hotspots1)) + geom_hline(yintercept=8) +xlab(" ")+ylab(" ")+ ggtitle("Min hotspots seen, p1")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p2_min_hotspot_ <- ggplot(map_data, aes(group_num, min_hotspots2)) + geom_hline(yintercept=7) +xlab(" ")+ylab(" ")+ ggtitle("Min hotspots seen, p2")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p3_min_hotspot_ <- ggplot(map_data, aes(group_num, min_hotspots3)) + geom_hline(yintercept=5) +xlab(" ")+ylab(" ")+ ggtitle("Min hotspots seen, p3")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p1_max_hotspot_ <- ggplot(map_data, aes(group_num, max_hotspots1)) + geom_hline(yintercept=11) +xlab(" ")+ylab(" ")+ ggtitle("Max hotspots seen, p1")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p2_max_hotspot_ <- ggplot(map_data, aes(group_num, max_hotspots2)) + geom_hline(yintercept=9) +xlab(" ")+ylab(" ")+ ggtitle("Max hotspots seen, p2")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p3_max_hotspot_ <- ggplot(map_data, aes(group_num, max_hotspots3)) + geom_hline(yintercept=9) +xlab(" ")+ylab(" ")+ ggtitle("Max hotspots seen, p3")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)

grid.arrange(p1_min_hotspot_, p2_min_hotspot_, p3_min_hotspot_,
             p1_max_hotspot_, p2_max_hotspot_, p3_max_hotspot_, ncol=3, nrow=2)

#
# min and max circles needed compared to gold standard
#
p1_min_circle <- ggplot(map_data, aes(new_part_id, min_circles1)) + geom_hline(yintercept=8) +xlab(" ")+ylab(" ")+ ggtitle("Min circles needed, p1")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p2_min_circle <- ggplot(map_data, aes(new_part_id, min_circles2)) + geom_hline(yintercept=7) +xlab(" ")+ylab(" ")+ ggtitle("Min circles needed, p2")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p3_min_circle <- ggplot(map_data, aes(new_part_id, min_circles3)) + geom_hline(yintercept=6) +xlab(" ")+ylab(" ")+ ggtitle("Min circles needed, p3")+ geom_point(aes(color=group_num))
p1_max_circle <- ggplot(map_data, aes(new_part_id, max_circles1)) + geom_hline(yintercept=13) +xlab(" ")+ylab(" ")+ ggtitle("Max circles needed, p1")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p2_max_circle <- ggplot(map_data, aes(new_part_id, max_circles2)) + geom_hline(yintercept=10) +xlab(" ")+ylab(" ")+ ggtitle("Max circles needed, p2")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p3_max_circle <- ggplot(map_data, aes(new_part_id, max_circles3)) + geom_hline(yintercept=10) +xlab(" ")+ylab(" ")+ ggtitle("Max circles needed, p3")+ geom_point(aes(color=group_num))

grid.arrange(p1_min_circle, p2_min_circle, p3_min_circle,
             p1_max_circle, p2_max_circle, p3_max_circle, ncol=3, nrow=2)

# same graph of data as above, but does not show every person's response. gives more of an idea of what the deviation is
#
p1_min_circle_ <- ggplot(map_data, aes(new_part_id, min_circles1)) + geom_hline(yintercept=8) +xlab(" ")+ylab(" ")+ ggtitle("Min circles needed, p1")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p2_min_circle_ <- ggplot(map_data, aes(new_part_id, min_circles2)) + geom_hline(yintercept=7) +xlab(" ")+ylab(" ")+ ggtitle("Min circles needed, p2")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p3_min_circle_ <- ggplot(map_data, aes(new_part_id, min_circles3)) + geom_hline(yintercept=6) +xlab(" ")+ylab(" ")+ ggtitle("Min circles needed, p3")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p1_max_circle_ <- ggplot(map_data, aes(new_part_id, max_circles1)) + geom_hline(yintercept=13) +xlab(" ")+ylab(" ")+ ggtitle("Max circles needed, p1")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p2_max_circle_ <- ggplot(map_data, aes(new_part_id, max_circles2)) + geom_hline(yintercept=10) +xlab(" ")+ylab(" ")+ ggtitle("Max circles needed, p2")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)
p3_max_circle_ <- ggplot(map_data, aes(new_part_id, max_circles3)) + geom_hline(yintercept=10) +xlab(" ")+ylab(" ")+ ggtitle("Max circles needed, p3")+ geom_point(aes(color=group_num)) + scale_colour_continuous(guide = FALSE)

grid.arrange(p1_min_circle_, p2_min_circle_, p3_min_circle_,
             p1_max_circle_, p2_max_circle_, p3_max_circle_, ncol=3, nrow=2)