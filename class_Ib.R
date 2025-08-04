dir.create("raw_data")
dir.create("clean_data")
dir.create("scripts")
dir.create("results")
dir.create("plots")


data = read.csv(file.choose())
View(data)
str(data)

# convert gender from character to factor data type

data$gender_fac = as.factor(data$gender)
str(data)

# convert diagnosis from character data type to factor data type

data$diagnosis_fac = as.factor(data$diagnosis)
str(data)

# creating a new variable for smoking status as a factor

data$smoker_fac = as.factor(data$smoker)
str(data)

# creating a new variable for smoking status as a binary factor and assigning 1 for Yes and 0 for No

data$smoker_num = ifelse(data$smoker_fac == "Yes", 1, 0)

# save cleaned data set into clean_data folder with name patient_info_clean.csv

write.csv(data, file = "clean_data/patient_info_clean.csv")
