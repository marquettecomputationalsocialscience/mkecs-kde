library(reshape2)
library(plyr)
library(tidyverse)
library(psych)
library(GPArotation)
library(corrplot)
library(nFactors)
library(ggplot2)

rm(list=ls())

map_data <- read.csv('/Users/Joey/mkecs-kde/Analysis/data/map-data.csv')

group1 <- subset(map_data, group_num==1)
group2 <- subset(map_data, group_num==2)
group3 <- subset(map_data, group_num==3)

group1_counts <- data.frame( matrix(ncol=6, nrow=3) )
group2_counts <- data.frame( matrix(ncol=6, nrow=3) )
group3_counts <- data.frame( matrix(ncol=6, nrow=3) )

colNames <- c('keptDefKernel', 'changedKernel',
              'keptDefBandwidth', 'changedBandwidth',
              'keptDefMetric', 'changedMetric')
rowNames <- c('picture1', 'picture2', 'picture3')

colnames(group1_counts) <- colNames
row.names(group1_counts) <- rowNames
colnames(group2_counts) <- colNames
row.names(group2_counts) <- rowNames
colnames(group3_counts) <- colNames
row.names(group3_counts) <- rowNames

group1_counts[1,2] <- 0

group1$kernel1

for (i in 1:6){
  group1_counts[1,i] = 0
  group1_counts[2,i] = 0
  group1_counts[3,i] = 0
  
  group2_counts[1,i] = 0
  group2_counts[2,i] = 0
  group2_counts[3,i] = 0
  
  group3_counts[1,i] = 0
  group3_counts[2,i] = 0
  group3_counts[3,i] = 0
}

for (x in group1$kernel1){
    if (x == "gaussian") {
      group1_counts[1,1] <- group1_counts[1,1] + 1
    }
    else {
      group1_counts[1,2] <- group1_counts[1,2] + 1
    }
  }
for (x in group1$bandwidth1){
    if (x == 0.005){
      group1_counts[1,3] <- group1_counts[1,3] + 1
    }
    else {
      group1_counts[1,4] <- group1_counts[1,4] + 1
    }
  }
for (x in group1$metric1){
    if (x == "euclidean"){
      group1_counts[1,5] <- group1_counts[1,5] + 1
    }
    else {
      group1_counts[1,6] <- group1_counts[1,6] + 1
    }
  }
for (x in group1$kernel2){
    if (x == "gaussian"){
      group1_counts[2,1] <- group1_counts[2,1] + 1
    }
    else {
      group1_counts[2,2] <- group1_counts[2,2] + 1
    }
  }
for (x in group1$bandwidth2){
    if (x == 0.005){
      group1_counts[2,3] <- group1_counts[2,3] + 1
    }
    else{
      group1_counts[2,4] <- group1_counts[2,4] + 1
    }
  }
for (x in group1$metric2){
    if (x == "euclidean"){
      group1_counts[2,5] <- group1_counts[2,5] + 1
    }
    else{
      group1_counts[2,6] <- group1_counts[2,6] + 1
    }
  }
for (x in group1$kernel3){
    if (x == "gaussian"){
      group1_counts[3,1] <- group1_counts[3,1] + 1
    }
    else {
      group1_counts[3,2] <- group1_counts[3,2] + 1
    }
  }
for (x in group1$bandwidth3){
    if (x == 0.005){
      group1_counts[3,3] <- group1_counts[3,3] + 1
    }
    else{
      group1_counts[3,4] <- group1_counts[3,4] + 1
    }
  }
for (x in group1$metric3){
    if (x == "euclidean"){
      group1_counts[3,5] <- group1_counts[3,5] + 1
    }
    else{
      group1_counts[3,6] <- group1_counts[3,6] + 1
    }
  }

for (x in group2$kernel1){
    if (x == "gaussian") {
      group2_counts[1,1] <- group2_counts[1,1] + 1
    }
    else {
      group2_counts[1,2] <- group2_counts[1,2] + 1
    }
  }
for (x in group2$bandwidth1){
    if (x == 0.0050){
      group2_counts[1,3] <- group2_counts[1,3] + 1
    }
    else {
      group2_counts[1,4] <- group2_counts[1,4] + 1
    }
  }
for (x in group2$metric1){
    if (x == "euclidean"){
      group2_counts[1,5] <- group2_counts[1,5] + 1
    }
    else {
      group2_counts[1,6] <- group2_counts[1,6] + 1
    }
  }
for (x in group2$kernel2){
    if (x == "gaussian"){
      group2_counts[2,1] <- group2_counts[2,1] + 1
    }
    else {
      group2_counts[2,2] <- group2_counts[2,2] + 1
    }
  }
for (x in group2$bandwidth2){
    if (x == 0.0050){
      group2_counts[2,3] <- group2_counts[2,3] + 1
    }
    else{
      group2_counts[2,4] <- group2_counts[2,4] + 1
    }
  }
for (x in group2$metric2){
    if (x == "euclidean"){
      group2_counts[2,5] <- group2_counts[2,5] + 1
    }
    else{
      group2_counts[2,6] <- group2_counts[2,6] + 1
    }
  }
for (x in group2$kernel3){
    if (x == "gaussian"){
      group2_counts[3,1] <- group2_counts[3,1] + 1
    }
    else {
      group2_counts[3,2] <- group2_counts[3,2] + 1
    }
  }
for (x in group2$bandwidth3){
    if (x == 0.0050){
      group2_counts[3,3] <- group2_counts[3,3] + 1
    }
    else{
      group2_counts[3,4] <- group2_counts[3,4] + 1
    }
  }
for (x in group2$metric3){
    if (x == "euclidean"){
      group2_counts[3,5] <- group2_counts[3,5] + 1
    }
    else{
      group2_counts[3,6] <- group2_counts[3,6] + 1
    }
  }

for (x in group3$kernel1){
    if (x == "gaussian") {
      group3_counts[1,1] <- group3_counts[1,1] + 1
    }
    else {
      group3_counts[1,2] <- group3_counts[1,2] + 1
    }
  }
for (x in group3$bandwidth1){
    if (x == 0.005){
      group3_counts[1,3] <- group3_counts[1,3] + 1
    }
    else {
      group3_counts[1,4] <- group3_counts[1,4] + 1
    }
  }
for (x in group3$metric1){
    if (x == "euclidean"){
      group3_counts[1,5] <- group3_counts[1,5] + 1
    }
    else {
      group3_counts[1,6] <- group3_counts[1,6] + 1
    }
  }
for (x in group3$kernel2){
    if (x == "gaussian"){
      group3_counts[2,1] <- group3_counts[2,1] + 1
    }
    else {
      group3_counts[2,2] <- group3_counts[2,2] + 1
    }
  }
for (x in group3$bandwidth2){
    if (x == 0.005){
      group3_counts[2,3] <- group3_counts[2,3] + 1
    }
    else{
      group3_counts[2,4] <- group3_counts[2,4] + 1
    }
  }
for (x in group3$metric2){
    if (x == "euclidean"){
      group3_counts[2,5] <- group3_counts[2,5] + 1
    }
    else{
      group3_counts[2,6] <- group3_counts[2,6] + 1
    }
  }
for (x in group3$kernel3){
    if (x == "gaussian"){
      group3_counts[3,1] <- group3_counts[3,1] + 1
    }
    else {
      group3_counts[3,2] <- group3_counts[3,2] + 1
    }
  }
for (x in group3$bandwidth3){
    if (x == 0.005){
      group3_counts[3,3] <- group3_counts[3,3] + 1
    }
    else{
      group3_counts[3,4] <- group3_counts[3,4] + 1
    }
  }
for (x in group3$metric3){
    if (x == "euclidean"){
      group3_counts[3,5] <- group3_counts[3,5] + 1
    }
    else{
      group3_counts[3,6] <- group3_counts[3,6] + 1
    }
  }


barplot(as.matrix(group1_counts))

barplot(as.matrix(group2_counts[1, 1:2]), beside=T)

g1p1 <- data.frame(Kernel=group1_counts[1, 1:2], Bandwidth=group1_counts[1, 3:4], Metric=group1_counts[1, 5:6])
g2p1 <- data.frame(Kernel=group2_counts[1, 1:2], Bandwidth=group2_counts[1, 3:4], Metric=group2_counts[1, 5:6])
g3p1 <- data.frame(Kernel=group3_counts[1, 1:2], Bandwidth=group3_counts[1, 3:4], Metric=group3_counts[1, 5:6])

g1p2 <- data.frame(Kernel=group1_counts[2, 1:2], Bandwidth=group1_counts[2, 3:4], Metric=group1_counts[2, 5:6])
g2p2 <- data.frame(Kernel=group2_counts[2, 1:2], Bandwidth=group2_counts[2, 3:4], Metric=group2_counts[2, 5:6])
g3p2 <- data.frame(Kernel=group3_counts[2, 1:2], Bandwidth=group3_counts[2, 3:4], Metric=group3_counts[2, 5:6])

g1p3 <- data.frame(Kernel=group1_counts[3, 1:2], Bandwidth=group1_counts[3, 3:4], Metric=group1_counts[2, 5:6])
g2p3 <- data.frame(Kernel=group2_counts[3, 1:2], Bandwidth=group2_counts[3, 3:4], Metric=group2_counts[2, 5:6])
g3p3 <- data.frame(Kernel=group3_counts[3, 1:2], Bandwidth=group3_counts[3, 3:4], Metric=group3_counts[2, 5:6])

par(mar=c(5,7,5,2), mfrow=c(3,3))

barplot(as.matrix(g1p1), main="No background vs picture 1", col=terrain.colors(2), beside=TRUE, 
        names.arg=c('kernel', '', 'bandwidth', '', 'distance metric', ''), cex.names=.7125, las=1)
barplot(as.matrix(g2p1), main="Technical background vs picture 1", col=terrain.colors(2), beside=TRUE, 
        names.arg=c('kernel', '', 'bandwidth', '', 'distance metric', ''), cex.names=.7125)
barplot(as.matrix(g3p1), main="Professional background vs picture 1", col=terrain.colors(2), beside=TRUE, 
        names.arg=c('kernel', '', 'bandwidth', '', 'distance metric', ''), cex.names=.7125)
barplot(as.matrix(g1p2), main="No background vs picture 2", col=terrain.colors(2), beside=TRUE, 
        names.arg=c('kernel', '', 'bandwidth', '', 'distance metric', ''), cex.names=.7125)
barplot(as.matrix(g2p2), main="Technical background vs picture 2", col=terrain.colors(2), beside=TRUE, 
        names.arg=c('kernel', '', 'bandwidth', '', 'distance metric', ''), cex.names=.7125)
barplot(as.matrix(g3p2), main="Professional background vs picture 2", col=terrain.colors(2), beside=TRUE, 
        names.arg=c('kernel', '', 'bandwidth', '', 'distance metric', ''), cex.names=.7125)
barplot(as.matrix(g1p3), main="No background vs picture 3", col=terrain.colors(2), beside=TRUE, 
        names.arg=c('kernel', '', 'bandwidth', '', 'distance metric', ''), cex.names=.7125)
barplot(as.matrix(g2p3), main="Technical background vs picture 3", col=terrain.colors(2), beside=TRUE, 
        names.arg=c('kernel', '', 'bandwidth', '', 'distance metric', ''), cex.names=.7125)
barplot(as.matrix(g3p3), main="Professional background vs picture 3", col=terrain.colors(2), beside=TRUE, 
        names.arg=c('kernel', '', 'bandwidth', '', 'distance metric', ''), cex.names=.7125)

mtext("Green = those who kept default\nWhite = those who changed default", 
      side=2, outer=TRUE, line=-4.5, cex=0.75)
#legend(-85,-5,c("kept default", "changed default"), cex=0.75, fill=terrain.colors(2))

par(mar=c(5,4,4,2) + 0.1)

