library(ggplot2)
library(gridExtra)
library(forcats)

survey_data <- read.csv('/Users/Joey/mkecs-kde/Analysis/data/Questionnaire_August 22, 2019_11.47.csv')

income <- survey_data[3:9,60]


test_data <- survey_data[ -c(0,1,2), ]

# age distribution
#
ggplot(test_data, aes(test_data$Q30_1)) + theme(axis.text.x = element_text(angle = 45, hjust = 1))+ geom_histogram(stat="count")+xlab(" ")+ylab(" ")+ ggtitle("Age")


# race distribution
#
ggplot(test_data, aes(test_data$Q32)) + theme(axis.text.x = element_text(angle = 65, hjust = 1))+ geom_histogram(stat="count")+xlab(" ")+ylab(" ")+ ggtitle("Race distribution")

# gender distribution
#
ggplot(test_data, aes(test_data$Q33)) + theme(axis.text.x = element_text(angle = 30, hjust = 1))+ geom_histogram(stat="count")+xlab(" ")+ylab(" ")+ ggtitle("Gender")

# education level distribution
#
test_data$Q34 <- factor(test_data$Q34, levels=c('High school diploma or GED','Some college',
                                                'Currently enrolled in college','Bachelor\'s degree',
                                                'Master\'s degree','Doctorate degree'))
ggplot(test_data, aes(test_data$Q34)) + theme(axis.text.x = element_text(angle = 60, hjust = 1))+ geom_histogram(stat="count")+xlab(" ")+ylab(" ")+ ggtitle("Education Level")

# employment status
#
ggplot(test_data, aes(test_data$Q36)) + theme(axis.text.x = element_text(angle = 60, hjust = 1))+ geom_histogram(stat="count")+xlab(" ")+ylab(" ")+ ggtitle("Employment status")

# household income distribution
#
test_data$Q38 <- factor(test_data$Q38, levels=c('Less than $25,000', '$25,000 to $34,999',
                                                '$35,000 to $49,999','$50,000 to $74,999',
                                                '$75,000 to $99,999','$100,000 to $149,999',
                                                '$150,000 or more'))

ggplot(data=test_data, aes(test_data$Q38)) + theme(axis.text.x = element_text(angle = 60, hjust = 1))+ geom_histogram(stat="count")+xlab(" ")+ylab(" ")+ ggtitle("Household Income")

# "have you or a family member ever served in military or law enforcement?"
#
ggplot(test_data, aes(test_data$Q39)) +  geom_histogram(stat="count")+xlab(" ")+ylab(" ")+ ggtitle("Military or LEO involvement")

# "have you ever participated in any conflict resolution or peace education programs?"
#
ggplot(test_data, aes(test_data$Q40)) +  geom_histogram(stat="count")+xlab(" ")+ylab(" ")+ ggtitle("Conflict resolution or peace education programs?")

# "involved in a protest?"
#
ggplot(test_data, aes(test_data$Q41)) +  geom_histogram(stat="count")+xlab(" ")+ylab(" ")+ ggtitle("Involved in a protest?")

# "more gov funds should be allocated to police crime labs"
#
test_data$Q42 <- factor(test_data$Q42, levels=c('Strongly agree','Agree','Somewhat agree',
                                                'Neither agree nor disagree','Somewhat disagree','Disagree',
                                                'Strongly disagree'))
ggplot(test_data, aes(test_data$Q42)) + theme(axis.text.x = element_text(angle = 60, hjust = 1))+ geom_histogram(stat="count")+xlab(" ")+ylab(" ")+ ggtitle("\"More gov funds should be allocated to police crime labs\"")    

# "more gov funds should be allocated to putting police officers on the streets"
#
test_data$Q43 <- factor(test_data$Q43, levels=c('Strongly agree','Agree','Somewhat agree',
                                                'Neither agree nor disagree','Somewhat disagree','Disagree',
                                                'Strongly disagree'))
ggplot(test_data, aes(test_data$Q43)) + theme(axis.text.x = element_text(angle = 60, hjust = 1))+ geom_histogram(stat="count")+xlab(" ")+ylab(" ")+ ggtitle("\"More gov funds should be allocated to putting officers on the streets\"")

# political affiliation
#
ggplot(test_data, aes(test_data$Q44_1))+ geom_histogram(stat="count")+xlab(" ")+ylab(" ")+ ggtitle("Political affiliation")




