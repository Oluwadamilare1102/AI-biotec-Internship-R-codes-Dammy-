# Write a function classify_gene() 

# that takes:
# - logFC (log2FoldChange)
# - padj  (adjusted p-value)

# and returns:
# - "Upregulated" if log2FC > 1 and padj < 0.05
# - "Downregulated" if log2FC < -1 and padj < 0.05
# - "Not_Significant" otherwise

classify_gene <- function(log2FC, padj){
  ifelse(log2FC > 1 & padj < 0.05, "Upregulated",
         ifelse(log2FC < -1 & padj < 0.05, "Downregulated", "Not_Significant")
         )
}



# - Apply it in a for-loop to process both datasets (DEGs_data_1.csv, DEGs_data_2.csv)
  
setwd("C:/Users/Damilare/Desktop/AI_Omics_Internship_2025/Module I")

input_dir <- "raw_data"
output_dir <- "results"

if(!dir.exists(output_dir)){
  dir.create(output_dir)
}


files_to_process <- c("DEGs_Data_1.csv", "DEGs_Data_2.csv")

result_list <- list()

for (file_names in files_to_process){
  cat("\nProcessing:", file_names, "\n")
  
  input_file_path <- file.path(input_dir, file_names)
  
  data <- read.csv(input_file_path, header = TRUE)
  cat("file imported, checking for missing value...\n")
  
# - Replace missing padj values with 1  
 
  if("padj" %in% names(data)){
    missing_count <- sum(is.na(data$padj))
    if(missing_count > 0){
      data$padj[is.na(data$padj)] <- 1
    }
    
  }
#- Add a new column 'status'
    
    data$status <- classify_gene(data$logFC, data$padj)
    cat("gene has been classified successfully. \n")
    
    
#- Save processed files into Results folder   
    
    result_list[[file_names]] <- data
    
    output_file_path <- file.path(output_dir, paste0("classified_gene_expression_", file_names))
    write.csv(data, output_file_path, row.names = FALSE)
    cat("Results saved to:", output_file_path, "\n")
    

    }

c

results_1 <- result_list[[1]]
results_2 <- result_list[[2]]


for (file_names in names(result_list)) {
  cat("\nSummary counts for", file_names, ":\n")
  print(table(result_list[[file_names]]$status))
}

c
