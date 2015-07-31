#!/usr/bin/Rscript
library(ggplot2)

setwd("/Users//labuser//Documents/PartekFormat_GeneLevel/")
GeneLevel_AVGSignal = read.table("GeneLevel_AVGSignal.txt", header = TRUE, sep = "\t")
dim(GeneLevel_AVGSignal)

GeneLevelControl.m<-t(GeneLevel_AVGSignal[1:3, 118:ncol(GeneLevel_AVGSignal)])
colnames(GeneLevelControl.m) <- c("Readout 1","Readout 2","Readout 3")

GeneLevelControl.stat <- transform(GeneLevelControl.m,MEAN=apply(GeneLevelControl.m,1,mean,na.rm=T),SD=apply(GeneLevelControl.m,1,sd,na.rm=T))

GeneLevelControl.df <- data.frame(Gene = factor(rownames(GeneLevelControl.m), levels =rownames(GeneLevelControl.m)), GeneLevelControl.stat)

ggplot(data = GeneLevelControl.df, aes(x= Gene, y = MEAN, fill="#DD8888")) +
  guides(fill=FALSE) +
  geom_bar(position=position_dodge(),stat="identity") +
  #geom_errorbar(aes(ymin=MEAN-SD, ymax=MEAN+SD), 
  #width=0.2,
  #position=position_dodge(0.9)) +
  coord_cartesian(ylim=c(floor(min(GeneLevelControl.m)),round(max(GeneLevelControl.m)))) +
  xlab("Gene") + ylab("Readout")
  ggtitle("Gene expression in 16HBE cells")

ggplot(data = GeneLevelControl.df, aes(x = MEAN, fill="#DD8888")) +
  guides(fill=FALSE) +
  geom_histogram(binwidth=.05) +
  geom_vline(aes(xintercept=mean(MEAN, na.rm=T)), color="black", linetype="dashed", size=0.5) +
  ylab("Count") +
  ggtitle("Histogram of gene expression in 16HBE cells")