# ==============================================================================
# R Script: Retrieval, Preprocessing, and EDA of Microarray Data (GSE5583)
# ==============================================================================

# --- 1. SETUP ENVIRONMENT ---
# Set the working directory to save all plots and data automatically
# Note: R uses forward slashes (/) or double backslashes (\\) for paths
setwd("D:/DOWNLOADS")
print(paste("Working directory set to:", getwd()))

# Load necessary library
if (!require("RCurl")) install.packages("RCurl")
library(RCurl)

# --- 2. DATA RETRIEVAL ---
print("--- Downloading Data for GSE5583 ---")
# Retrieve data from the specific URL
url_path <- "http://bit.ly/GSE5583_data"
url_content <- getURL(url_path, followlocation = TRUE)

# Read into a matrix
data <- as.matrix(read.table(text = url_content, row.names = 1, header = T))

# --- 3. INITIAL DATA INSPECTION ---
print("--- GSE5583 Dimensions (Rows x Columns) ---")
print(dim(data))

print("--- GSE5583 First 6 Rows ---")
print(head(data))

print("--- GSE5583 Last 6 Rows ---")
print(tail(data))

# --- 4. RAW DATA VISUALIZATION ---
# Save Histogram of Raw Data
png(file = "GSE5583_Histogram_Raw.png", width = 800, height = 600)
hist(data, col = "gray", main = "GSE5583 - Histogram (Raw Data)")
dev.off()
print("✅ Saved: GSE5583_Histogram_Raw.png")

# --- 5. DATA PREPROCESSING (LOG2 TRANSFORMATION) ---
# Apply log2 transformation to normalize distribution
data2 <- log2(data)

# --- 6. TRANSFORMED DATA VISUALIZATION (EDA) ---

# 6.1 Histogram of Log2 Data
png(file = "GSE5583_Histogram_log2.png", width = 800, height = 600)
hist(data2, col = "gray", main = "GSE5583 (log2) - Histogram")
dev.off()
print("✅ Saved: GSE5583_Histogram_log2.png")

# 6.2 Boxplots
# Define colors for the plot (assuming a specific experimental design)
box_colors <- c("darkgreen", "darkgreen", "darkgreen", 
                "darkred", "darkred", "darkred")

png(file = "GSE5583_Boxplots_log2.png", width = 800, height = 600)
boxplot(data2, col = box_colors, 
        main = "GSE5583 - Boxplots (log2 Transformed)", las = 2)
dev.off()
print("✅ Saved: GSE5583_Boxplots_log2.png")

# 6.3 Hierarchical Clustering
# Calculate distance based on correlation
# 1 - correlation is a common distance metric for gene expression
hc <- hclust(as.dist(1 - cor(data2)))

png(file = "GSE5583_Hierarchical_Clustering.png", width = 800, height = 600)
plot(hc, main = "GSE5583 - Hierarchical Clustering (Sample Correlation)")
dev.off()
print("✅ Saved: GSE5583_Hierarchical_Clustering.png")

# --- 7. SAVE PROCESSED DATA ---
# Export the log2 transformed matrix to CSV
write.csv(data2, file = "GSE5583_log2_processed_data.csv")
print("✅ Saved: GSE5583_log2_processed_data.csv")

print("--- Script Completed Successfully ---")
