library(ggplot2)

setwd("/Users//labuser//Documents/PartekFormat_GeneLevel/")
GeneLevel_AVGSignal = read.table("GeneLevel_AVGSignal.txt", header = TRUE, sep = "\t")
dim(GeneLevel_AVGSignal)

GeneLevel.matrix <- matrix(,nrow = 10, ncol = 3)
colnames(GeneLevel.matrix) <- c("Readout 1","Readout 2","Readout 3")
rownames(GeneLevel.matrix) <- c(1:10)

for (i in 1:10){
  geneName = paste("TLR", as.character(i), sep='')
  rownames(GeneLevel.matrix)[i] <- geneName
  GeneLevel.matrix[i,] <- GeneLevel_AVGSignal[1:3,geneName]
}

GeneLevel.stat <- transform(GeneLevel.matrix,MEAN=apply(GeneLevel.matrix,1,mean,na.rm=T),SD=apply(GeneLevel.matrix,1,sd,na.rm=T))

GeneLevel.df <- data.frame(Gene = factor(rownames(GeneLevel.matrix), levels =rownames(GeneLevel.matrix)), GeneLevel.stat)

ggplot(data = GeneLevel.df, aes(x= Gene, y = MEAN, fill="#DD8888")) +
  guides(fill=FALSE) +
  geom_bar(position=position_dodge(),stat="identity") +
  geom_errorbar(aes(ymin=MEAN-SD, ymax=MEAN+SD), 
                width=0.2,
                position=position_dodge(0.9)) +
  coord_cartesian(ylim=c(6,6.75)) +
  xlab("Gene") + ylab("Readout") +
  ggtitle("TLR expression in 16HBE cells")