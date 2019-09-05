library(ggplot2)
#data$complexity <- ordered(data$complexity)
data$complexity<-factor(data$complexity,levels=1:3,labels = c("low","medium","high"),ordered=T)

####FOR KERNEL##############


k.model=glm(data$k ~ data$background+data$complexity, family = 'binomial')
summary(k.model)

k.anova=anova(k.model, test='Chisq')
k.anova


k.model2=glm(data$k ~ data$background*data$complexity, family = 'binomial')
summary(k.model2)

k.anova2=anova(k.model2, test='Chisq')
k.anova2

k.model3=glm(data$k ~ data$complexity+data$background, family = 'binomial')
summary(k.model3)

k3.anova=anova(k.model3, test='Chisq')
k3.anova


k.model=glm(data$k ~ data$background, family = 'binomial')
summary(k.model)

k.anova=anova(k.model, test='Chisq')
k.anova


k.model=glm(data$k ~ data$complexity, family = 'binomial')
summary(k.model)

k.anova=anova(k.model, test='Chisq')
k.anova

#######FOR BANDWIDTH##########

b.model=glm(data$b ~ data$background+data$complexity, family = 'binomial')
summary(b.model)

b.anova=anova(b.model, test='Chisq')
b.anova


b.model=glm(data$b ~ data$complexity+data$background, family = 'binomial')
summary(b.model)

b.anova=anova(b.model, test='Chisq')
b.anova


b.model=glm(data$b ~ data$background*data$complexity, family = 'binomial')
summary(b.model)

b.anova=anova(b.model, test='Chisq')
b.anova


b.model=glm(data$b ~ data$background, family = 'binomial')
summary(b.model)

b.anova=anova(b.model, test='Chisq')
b.anova


b.model=glm(data$b ~ data$complexity, family = 'binomial')
summary(b.model)

b.anova=anova(b.model, test='Chisq')
b.anova

######FOR DISTANCE METRIC###########

d.model=glm(data$d ~ data$background+data$complexity, family = 'binomial')
summary(d.model)

d.anova=anova(d.model, test='Chisq')
d.anova


d.model=glm(data$d ~ data$complexity+data$background, family = 'binomial')
summary(d.model)

d.anova=anova(d.model, test='Chisq')
d.anova


d.model=glm(data$d ~ data$background*data$complexity, family = 'binomial')
summary(d.model)

d.anova=anova(d.model, test='Chisq')
d.anova


d.model=glm(data$d ~ data$background, family = 'binomial')
summary(d.model)

d.anova=anova(d.model, test='Chisq')
d.anova


d.model=glm(data$d ~ data$complexity, family = 'binomial')
summary(d.model)

d.anova=anova(d.model, test='Chisq')
d.anova
