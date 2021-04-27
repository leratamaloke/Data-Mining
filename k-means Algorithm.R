# Initalization
rep <- '[Downloads]/'
dfD <- places
ficD <- paste0(rep, ficD)
ficRes <- "clusters.txt"
ficR <- paste0(rep, ficRes)


# 1. Import dataset
dfD <- read.csv(file = "./Downloads/places.txt", header = FALSE, sep=',', dec = '.')

# 2. Have a look at the dataset
plot(dfD$V1, dfD$V2)

# 3. The plot gives a good indication for the the seeds
dfD1 <- dfD[which(dfD$V1 < -110 & dfD$V2 < 34),]
s1 <- apply(dfD1, 2, FUN=mean)

dfD2 <- dfD[which(dfD$V1 > -85 & dfD$V2 < 36),]
s2 <- apply(dfD2, 2, FUN=mean)

dfD3 <- dfD[which(dfD$V1 > -85 & dfD$V2 > 42),]
s3 <- apply(dfD3, 2, FUN=mean)

s <- rbind(s1, s2, s3)

# 4. Run the K-Means
res <- kmeans(dfD, s)

# Just to check the results
dfR_verif <- cbind(as.numeric(rownames(dfD)) - 1, res$cluster - 1)
cnames <- c("location_id","cluster_label")
colnames(dfR_verif) <- cnames

# 5. Export
# Results in the required format
dfR <- cbind(as.numeric(rownames(dfD)) - 1, res$cluster - 1)
colnames(dfR) <- c("location_id","cluster_label")

# File export
write.table(dfR, file = "cluster.txt", append = FALSE, row.names = FALSE, col.names = FALSE, sep='\t', dec=',', quote = FALSE)
