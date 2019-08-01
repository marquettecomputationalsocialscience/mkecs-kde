library(reshape2)
library(plyr)
library(tidyverse)
library(psych)
library(GPArotation)
library(corrplot)
library(nFactors)
library(ggplot2)

rm(list=ls())

map_data <- read.csv('/Users/Joey/Desktop/Experiments/map-data.csv')

picture1 <- matrix(list(), nrow=2, ncol=12)
picture1 <- c("epanechnikov", "gaussian", "linear", "tophat", "0.0075", "0.005", "0.0025", "0.01", "euclidean", "manhattan", "chebyshev",
              0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
picture2 <- matrix(list(), nrow=2, ncol=12)
picture2 <- c("epanechnikov", "gaussian", "linear", "tophat", "0.0075", "0.005", "0.0025", "0.01", "euclidean", "manhattan", "chebyshev",
              0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
picture3 <- matrix(list(), nrow=2, ncol=12)
picture3 <- c("epanechnikov", "gaussian", "linear", "tophat", "0.0075", "0.005", "0.0025", "0.01", "euclidean", "manhattan", "chebyshev",
              0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

# picture 1 kernel
epanechnikov_count_1 <- 0
gaussian_count_1 <- 0
linear_count_1 <- 0
tophat_count_1 <- 0
for (x in map_data$kernel1) {
  if (x == "epanechnikov") {
    epanechnikov_count_1 <- epanechnikov_count_1 + 1
  }
  else if (x == "gaussian") {
    gaussian_count_1 <- gaussian_count_1 + 1
  }
  else if (x == "linear") {
    linear_count_1 <- linear_count_1 + 1
  }
  else if (x == "tophat") {
    tophat_count_1 <- tophat_count_1 + 1
  }
}
picture1[12] <- epanechnikov_count_1
picture1[13] <- gaussian_count_1
picture1[14] <- linear_count_1
picture1[15] <- tophat_count_1

# picture 1 bandwidth
band1_count_1 <- 0  # 0.0075
band2_count_1 <- 0  # 0.005
band3_count_1 <- 0  # 0.0025
band4_count_1 <- 0  # 0.01
for (x in map_data$bandwidth1) {
  if (x == 0.0075) {
    band1_count_1 <- band1_count_1 + 1
  }
  else if (x == 0.005) {
    band2_count_1 <- band2_count_1 + 1
  }
  else if (x == 0.0025) {
    band3_count_1 <- band3_count_1 + 1
  }
  else if (x == 0.01) {
    band4_count_1 <- band4_count_1 + 1
  }
}
picture1[16] <- band1_count_1
picture1[17] <- band2_count_1
picture1[18] <- band3_count_1
picture1[19] <- band4_count_1

# picture 1 metric
euclidean_count_1 <- 0
manhattan_count_1 <- 0
chebyshev_count_1 <- 0
for (x in map_data$metric1) {
  if (x == "euclidean") {
    euclidean_count_1 <- euclidean_count_1 + 1
  }
  else if (x == "manhattan") {
    manhattan_count_1 <- manhattan_count_1 + 1
  }
  else if (x == "chebyshev") {
    chebyshev_count_1 <- chebyshev_count_1 + 1
  }
}
picture1[20] <- euclidean_count_1
picture1[21] <- manhattan_count_1
picture1[22] <- chebyshev_count_1

# picture 2 kernel
epanechnikov_count_2 <- 0
gaussian_count_2 <- 0
linear_count_2 <- 0
tophat_count_2 <- 0
for (x in map_data$kernel2) {
  if (x == "epanechnikov") {
    epanechnikov_count_2 <- epanechnikov_count_2 + 1
  }
  else if (x == "gaussian") {
    gaussian_count_2 <- gaussian_count_2 + 1
  }
  else if (x == "linear") {
    linear_count_2 <- linear_count_2 + 1
  }
  else if (x == "tophat") {
    tophat_count_2 <- tophat_count_2 + 1
  }
}
picture2[12] <- epanechnikov_count_2
picture2[13] <- gaussian_count_2
picture2[14] <- linear_count_2
picture2[15] <- tophat_count_2

# picture 2 bandwidth
band1_count_2 <- 0  # 0.0075
band2_count_2 <- 0  # 0.005
band3_count_2 <- 0  # 0.0025
band4_count_2 <- 0  # 0.01
for (x in map_data$bandwidth2) {
  if (x == 0.0075) {
    band1_count_2 <- band1_count_2 + 1
  }
  else if (x == 0.005) {
    band2_count_2 <- band2_count_2 + 1
  }
  else if (x == 0.0025) {
    band3_count_2 <- band3_count_2 + 1
  }
  else if (x == 0.01) {
    band4_count_2 <- band4_count_2 + 1
  }
}
picture2[16] <- band1_count_2
picture2[17] <- band2_count_2
picture2[18] <- band3_count_2
picture2[19] <- band4_count_2

# picture 2 metric
euclidean_count_2 <- 0
manhattan_count_2 <- 0
chebyshev_count_2 <- 0
for (x in map_data$metric2) {
  if (x == "euclidean") {
    euclidean_count_2 <- euclidean_count_2 + 1
  }
  else if (x == "manhattan") {
    manhattan_count_2 <- manhattan_count_2 + 1
  }
  else if (x == "chebyshev") {
    chebyshev_count_2 <- chebyshev_count_2 + 1
  }
}
picture2[20] <- euclidean_count_2
picture2[21] <- manhattan_count_2
picture2[22] <- chebyshev_count_2

# picture 3 kernel
epanechnikov_count_3 <- 0
gaussian_count_3 <- 0
linear_count_3 <- 0
tophat_count_3 <- 0
for (x in map_data$kernel3) {
  if (x == "epanechnikov") {
    epanechnikov_count_3 <- epanechnikov_count_3 + 1
  }
  else if (x == "gaussian") {
    gaussian_count_3 <- gaussian_count_3 + 1
  }
  else if (x == "linear") {
    linear_count_3 <- linear_count_3 + 1
  }
  else if (x == "tophat") {
    tophat_count_3 <- tophat_count_3 + 1
  }
}
picture3[12] <- epanechnikov_count_3
picture3[13] <- gaussian_count_3
picture3[14] <- linear_count_3
picture3[15] <- tophat_count_3

# picture 3 bandwidth
band1_count_3 <- 0  # 0.0075
band2_count_3 <- 0  # 0.005
band3_count_3 <- 0  # 0.0025
band4_count_3 <- 0  # 0.01
for (x in map_data$bandwidth3) {
  if (x == 0.0075) {
    band1_count_3  <- band1_count_3 + 1
  }
  else if (x == 0.005) {
    band2_count_3 <- band2_count_3 + 1
  }
  else if (x == 0.0025) {
    band3_count_3 <- band3_count_3 + 1
  }
  else if (x == 0.01) {
    band4_count_3 <- band4_count_3 + 1
  }
}
picture3[16] <- band1_count_3
picture3[17] <- band2_count_3
picture3[18] <- band3_count_3
picture3[19] <- band4_count_3

# picture 3 metric
euclidean_count_3 <- 0
manhattan_count_3 <- 0
chebyshev_count_3 <- 0
for (x in map_data$metric3) {
  if (x == "euclidean") {
    euclidean_count_3 <- euclidean_count_3 + 1
  }
  else if (x == "manhattan") {
    manhattan_count_3 <- manhattan_count_3 + 1
  }
  else if (x == "chebyshev") {
    chebyshev_count_3 <- chebyshev_count_3 + 1
  }
}
picture3[20] <- euclidean_count_3
picture3[21] <- manhattan_count_3
picture3[22] <- chebyshev_count_3

picture1
picture2
picture3

parameterNames <- c('epanechnikov', 'gaussian', 'linear', 'tophat', '0.0075', '0.005', '0.0025', '0.01', 'euclidean', 'manhattan', 'chebyshev')
picture1 <- c(1, 39, 3, 2, 1, 33, 1, 0, 42, 3, 0)
picture2 <- c(2, 36, 4, 3, 3, 31, 1, 0, 41, 4, 0)
picture3 <- c(0, 36, 3, 3, 4, 28, 0, 3, 42, 2, 1)


mydata <- data.frame(picture1, picture2, picture3)
par(xpd = T, mar=par()$mar + c(0,0,0,7))
barplot(as.matrix(mydata), main="Do people prefer defaults?", ylab="Counts", beside=TRUE, col=terrain.colors(11))
legend(40, 40, c("epanechnikov","gaussian","linear","tophat","0.0075","0.005","0.0025","0.01","euclidean","manhattan","chebyshev"), fill=terrain.colors(11))
par(mar=c(5,4,4,2) + 0.1)
