#---------------------------------Load libraries-------------------------------#
library("qgraph") 
library("bootnet") 
library("NetworkComparisonTest")
library("ggplot2")
library("readxl")
library("dplyr")

#---------------------------------Load files-------------------------------#
setwd("") #set the working directory to the location where you have stored the files.
data <- read_excel("Dataset_tutorial_2.xlsx")


nodes=grep("item", names(data), value = TRUE)
data <- data %>%
  mutate_at(vars(nodes), as.numeric)



#--------------------Regularized network (bootnet estimation)-------------------------------#
#to limit spurious edges

#---------------------------------Set regularization parameters--------------------------#
#gamma: control how much sparse is the model, set between 0 and 0.5, higher values more parsimonious model
t <- 0.5 

control <- subset(data, data$Arm == "Control") #select only control

network1 <- estimateNetwork(
  data = control[, nodes],
  default = "EBICglasso",
  corMethod = "cor",
  corArgs = list(method = "spearman"),
  tuning = t,              # gamma
  lambda.min.ratio = 0.01,   # minimum lambda
  missing = "pairwise"
)



#------- Small summary of estimated network-------------------------------#
network1
network1$graph
cs=sum(abs(network1$graph))/2 #connectivity strenght 

#--Plot estimated netwotk---#
qgraph(network1$graph,
       layout = "spring",
       labels = nodes,
       color = "orange",
       vsize = 8,
       label.cex = 0.8)


#--------------------------Stability of edge weights------------------------------------#
#non-parametric bootstrap: sampling cases randomly with replacement

#Are our edge weights? How much do they change as we change our sample? 
bootnet_edge_weights <- bootnet(network1, 
                          nBoots = 1000, # number of boot samples
                          nCores = 8)

# Looking at the width of variation
plot(bootnet_edge_weights,
     labels = TRUE,
     order = "sample")



#---Stability of centrality measures---#
#case-dropping bootstrap: randomly exclude cases from our original dataset, creating a new dataset

centralityPlot(network1, include = c("Strength", "Closeness", "Betweenness"))


#Are our centrality indices realiable? How much do they change as we change our sample? 
bootnet_centrality <- bootnet(network1, 
                                 nBoots = 1000,
                                 type = "case",
                                 nCores = 8,
                                 statistics = c('strength',
                                                'expectedInfluence',
                                                'betweenness',
                                                'closeness'))

plot(bootnet_centrality, 'all')


#Correlation-Stability Coefficient (CS-Coefficient)
corStability(bootnet_case_dropping)

#You can drop up to ~67% of cases and still retain stable strength centrality estimates
#Betweenness becomes unstable if more than ~44% of data is dropped.

#----------------------------------------------------Network comparison-------------------------------------------------------#
treated <- subset(data, data$Arm == "Treatment")
network2 <- estimateNetwork(
  data = treated [, nodes],
  default = "EBICglasso",
  corMethod = "cor",
  corArgs = list(method = "spearman"),
  tuning = t,              # gamma
  lambda.min.ratio = lmr,   # minimum lambda
  missing = "pairwise"
)


ntc <- NCT(network1, network2, it=1000, binary.data=FALSE, test.edges=TRUE, edges='all', progressbar=TRUE)


#-------------------Global strength comparison------------------------#
ntc$glstrinv.sep   #connectivity value 
ntc$glstrinv.real  #difference in connectivity
ntc$glstrinv.pval  #p-value


#-----------------No regularized network------------------#
network3=estimateNetwork(control[, nodes], default = "pcor", corMethod = "cor", corArgs = list(method = "spearman"))


#--------------------------Exercise--------------------#
#1) How does changing the gamma parameter affect 'control'?
#Test gamma values of 0.25 and 0.10
#plot the graphs.
#examine how connectivity strength changes.
#compare edge weight stability 

#2) Compare global connectivity strength between smokers and non-smokers.


#3) Which is the most central node for subjects treated with SSRI







