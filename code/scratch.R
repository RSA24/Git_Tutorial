# Gene Expression Analysis

# Setting up the analysis
#dir.create("data")
#dir.create("output")
library(tidyverse)

### I need to 1) create a heat map from the mutural rank data and 2) a line graph from the tpm data by tissue type

# 1) Heat map

exp.data <- read_csv("data/Comparisson_Matrix_file.csv")


str(exp.data)
head(exp.data)

exp.heatmap <- ggplot(data = exp.data, mapping = aes(x = Node1_T,
                                                     y = Node2,
                                                     fill = Mutual_Rank)) +
  geom_tile()

exp.heatmap 

exp.data$log.expression <- log(exp.data$Mutual_Rank)

exp.heatmap.log <- ggplot(data = exp.data, mapping = aes(x = Node1_T,
                                                         y = Node2,
                                                         fill = log.expression)) +
  geom_tile() +
  xlab(label = "Gene1") + # Add a nicer x-axis title
  theme(axis.title.y = element_blank(), # Remove the y-axis title
        axis.text.x = element_text(angle = 45, vjust = 0.5)) # Rotate the x-axis labels

exp.heatmap.log





#-------------------------------------------------------------------------------
# For remixing your data file to get the columns you are interested in. 
#exp.long <- pivot_longer(data = exp.data,
#                         cols = everything(),
#                         names_to = "gene",
#                         values_to = "expression")

#exp.long <- pivot_longer(data = exp.data, 
#                         cols = -c(target_id, treatment),
#                         names_to = "gene", 
#                         values_to = "expression")
#head(exp.long)


exp.heatmap <- ggplot(data = exp.data, mapping = aes(x = treatment,
                                                     y = target_id,
                                                     fill = tpm)) +
  geom_tile()
exp.heatmap

# Adjusting the values so the lower expression isn't drowned out
exp.data$log.expression <- log(exp.data$Mutual_Rank)

exp.heatmap.log <- ggplot(data = exp.data, mapping = aes(x = treatment,
                                                         y = target_id,
                                                         fill = log.expression)) +
  geom_tile() +
  xlab(label = "Tissue Type") + # Add a nicer x-axis title
  theme(axis.title.y = element_blank(), # Remove the y-axis title
        axis.text.x = element_text(angle = 45, vjust = 0.5)) # Rotate the x-axis labels

exp.heatmap.log

### line graph

exp.line <- ggplot(data=exp.data, aes(x=treatment, y=tpm, group=target_id)) +
  geom_smooth(aes(color=target_id))

exp.line


#### Reorder the x-axis

levels(exp.data$treatment)
unique(exp.data$treatment)

# Reverse the order as follow
iris$Species <- factor(iris$Species, levels = rev(levels(iris$Species)))

# Or specify the factor levels in the order you want
exp.data$treatment <- factor(exp.data$treatment, levels = c("Seedling_DAG2", "Seedling_DAG4", "Seedling_DAG6", 
                                                            "Leaf-0", "Leaf-1", "Leaf-2", "Leaf-3", "Leaf-4", "Leaf-5",
                                                            "Sepal", "Stem", "Carpel", "Petal", "Stamen", "Root", "Seed-1",
                                                            "Seed-2", "Seed-3"))

