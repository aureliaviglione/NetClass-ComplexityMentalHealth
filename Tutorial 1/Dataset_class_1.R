set.seed(123) 
ID <- 1:2000
Age <- sample(18:65, 2000, replace = TRUE)  
Gender <- sample(c("Female", "Male"), 2000, TRUE)
MDD_diagnosis <- sample(0:1, 2000, replace = TRUE) 
Smoking_status <- sample(0:1, 2000, replace = TRUE) 
Antidepressant <- sample(c("SSRI", "NA"), 2000, TRUE)
Arm <- sample(c("Control", "Treatment"), 2000, TRUE)
CRP <- sample(0:10, 2000, replace = TRUE) 
item_1_sadness <- round(runif(2000, min = 0, max = 4))
item_2_pessimism <- round(runif(2000, min = 0, max = 4)) 
item_3_fail <- round(runif(2000, min = 0, max = 4)) 
item_4_agitation <- round(runif(2000, min = 0, max = 4))  
item_5_guilt <- round(runif(2000, min = 0, max = 4))  
item_6_tiredness <- round(runif(2000, min = 0, max = 4)) 
item_7_loss_interest <- round(runif(2000, min = 0, max = 4))  
item_8_concentration <- round(runif(2000, min = 0, max = 4)) 
item_9_indecisivenes <- round(runif(2000, min = 0, max = 4)) 	
item_10_insomnia <- round(runif(2000, min = 0, max = 4)) 
item_11_appetite <- round(runif(2000, min = 0, max = 4)) 



df <- data.frame(ID,Antidepressant, Arm, Age,Gender,CRP,MDD_diagnosis,Smoking_status,item_1_sadness,item_2_pessimism,item_3_fail,item_4_agitation,item_5_guilt, item_6_tiredness,
                 item_7_loss_interest,item_8_concentration, item_9_indecisivenes, item_10_insomnia, item_11_appetite )
library(dplyr)
df <- df %>% mutate(Total_score_baseline = rowSums(across(starts_with("item"))))
df$Total_score_w4 <- round(runif(2000, min = 13, max = 44)) 

library(writexl)
write_xlsx(df, "Dataset_class_1.xlsx")


