library(qgraph)
library(tidyr)
library(readxl)
library(dplyr)
library(graphicalVAR)

#---------------------------------Load files-------------------------------
setwd("") #set the working directory to the location where you have stored the files.
df <- read_excel("Dataset_tutorial_2.xlsx")

#nodes
Vars=c("stress","mood", "sleep", "fatigue", "motivation", "intrusive",  "help", "social",  "organizing",  "feedback",  "evaluating", "anxiety", "enjoyment", "learning")

#-----------------------Detrend data-------------------------------------------------#
detrended <- df %>%
  mutate(across(all_of(Vars), ~ as.numeric(.))) %>%
  group_by(name) %>%
  mutate(Day = seq_along(name)) %>%
  mutate(across(all_of(Vars),
                ~ {
                  if(sum(!is.na(.)) > 2) { # check for enough data
                    resid(lm(. ~ Day, na.action = na.exclude))
                  } else {
                    . # To much missing data, keep data without detrending it
                  }
                })) %>% 
  ungroup()


#-----------------------Fit the model-------------------------------------------------------#
#gamma: control how much sparse is the model, set between 0 and 0.5, higher values more parsimonious model
#Takes 5 minutes
t <- 0.5 
GraphVAR_all <- mlGraphicalVAR(detrended, vars = Vars,
                               idvar = "name", 
                               lambda_beta = 0.1,
                               gamma = t,
                               subjectNetworks = TRUE, 
                               verbose = FALSE)




# --------------------Plot individual networks-------------------------------#
#5 individuals
for (i in 20:24) {
  par(mfrow = c(1, 2))
  
  # Contemporaneous network 
  qgraph(GraphVAR_all$subjectPCC[[i]], 
         minimum = 0.05, 
         labels = Vars,
         layout = "spring",
         title = paste("PCC:", GraphVAR_all$ids[[i]]))
  
  # Temporal network
  qgraph(GraphVAR_all$subjectPDC[[i]], 
         minimum = 0.05, 
         labels = Vars,
         layout = "circle",
         arrows = TRUE,
         title = paste("PDC:", GraphVAR_all$ids[[i]]))
}
par(mfrow = c(1, 1))



#-------------------------------Extract centrality measures--------------------------------------#
#one subjects 
centrality_subj1 <- centrality_auto(GraphVAR_all$subjectPCC[[5]])
centrality_subj1$node.centrality
centralityPlot(GraphVAR_all$subjectPCC[[1]], 
               include = c("Strength", "Betweenness", "Closeness"))

#--------------------------Contemporaneous network---------#
#Compare 'Strength across selected subjects from PCC
get_centralities <- function(matrix, id, vars) {
  cent <- centrality_auto(matrix)$node.centrality
  
  data.frame(
    ID = id,
    Variable = vars,
    Strength = cent$Strength,
    Betweenness = cent$Betweenness,
    Closeness = cent$Closeness
  )
}
centralities_all <- lapply(1:length(unique(df$name)), function(i) {
  get_centralities(GraphVAR_all$subjectPCC[[i]],
                   GraphVAR_all$ids[[i]],
                   Vars)
})

#summary table 
df_centralities_pcc <- do.call(rbind, centralities_all)
df_centralities_pcc

#best nodes for each subjects
get_top_nodes <- function(df) {
  df %>%
    group_by(ID) %>%
    summarise(
      Top_Strength = Variable[which.max(Strength)],
      Top_Betweenness = Variable[which.max(Betweenness)],
      Top_Closeness = Variable[which.max(Closeness)]
    )
}
df_top_nodes <- get_top_nodes(df_centralities_pcc)
df_top_nodes

#frequency of the nodes
#“The most frequent central node across subjects is: ”
top_strength=df_top_nodes %>%
  count(Top_Strength, sort = TRUE)


#Compare 'Strength across selected subjects from PDC
get_centralities_pdc <- function(matrix, id, vars) {
  cent <- centrality_auto(matrix)$node.centrality
  
  data.frame(
    ID = id,
    Variable = vars,
    InStrength = cent$InStrength,
    OutStrength = cent$OutStrength
  )
}
centralities_pdc_all <- lapply(1:length(GraphVAR_all$subjectPDC), function(i) {
  get_centralities_pdc(GraphVAR_all$subjectPDC[[i]],
                       GraphVAR_all$ids[[i]],
                       Vars)
})

#summary table
df_centralities_pdc <- do.call(rbind, centralities_pdc_all)
df_centralities_pdc

#best nodes for each subjects
get_top_nodes_pdc <- function(df) {
  df %>%
    group_by(ID) %>%
    summarise(
      Top_OutStrength = Variable[which.max(OutStrength)],
      Top_InStrength = Variable[which.max(InStrength)]
    )
}
df_top_nodes_pdc <- get_top_nodes_pdc(df_centralities_pdc)
df_top_nodes_pdc


#--------------------------Exercise--------------------#
# 1) Which the nodes with more frequen higher betweens?
# Top Betweenness frequency


# 2) Which are the subjects where the most strenghteness node is different?
#“The following subjects do not follow this pattern: ”


#3) Does changing the regularization parameter (gamma) modify node strength? Re-run the model with t = 0.25 and compare:



#Additional:
# --------------------Plot group levels networks-------------------------------#
#Between-person: average stationary relationships between variables across different subjects (Reflects stable differences between people)
layout(1) 
qgraph(GraphVAR_all$betweenNet, title = "Between-subjects Network", 
       layout = "spring", minimum = 0.05, labels = Vars)

#Fixed contemporaneous: which captures the average contemporaneous correlations across all individuals (“What moves together at the same time”)
qgraph(GraphVAR_all$fixedPCC, title = "Fixed Contemporaneous Network", 
       layout = "spring", minimum = 0.05, labels = Vars)

#Fixed temporal: captures the temporal relationships on average across the whole sample
qgraph(GraphVAR_all$fixedPDC, title = "Fixed Temporal Network", 
       layout = "circle", minimum = 0.01, labels = Vars, arrows = TRUE)
