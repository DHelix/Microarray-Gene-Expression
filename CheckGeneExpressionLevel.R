#!/usr/bin/Rscript

# This R script is for extracting gene expression information from Jo's microarray data.
# It needs the data files present in the same folder: GeneLevelMatrix.rds
# Run this script from Terminal by typing: ./CheckGeneExpressionLevel.R

print("Loading database...")
#GeneLevel_AVGSignal = read.table("GeneLevel_AVGSignal.txt", header = TRUE, sep = "\t")
#GeneLevel_AVGSignal=readRDS("GeneLevel_AVGSignal.rds")

#GeneLevel.m<-t(GeneLevel_AVGSignal[, 118:ncol(GeneLevel_AVGSignal)])
#colnames(GeneLevel.m) <- GeneLevel_AVGSignal[,"Sample.ID"]
GeneLevel.m=readRDS("./GeneLevelMatrix.rds")
print("Loading is done!")

continue <- TRUE
cat("Enter your gene's name: ")
GeneList <- readLines(file("stdin"),1)

while((GeneList == "")){
  cat("Gene name cannot be empty. Enter your gene's name: ")
  GeneList <- readLines(file("stdin"),1)
}
#closeAllConnections()

GeneName <- strsplit(GeneList, split = " ")


while(continue){
    
  cat("\n")
  
  for (i in 1:length(GeneName[[1]])){
    if(is.na(match(GeneName[[1]][i], rownames(GeneLevel.m))))
      cat(GeneName[[1]][i], "is not found, please check your spell and try again. \n\n")
    else{
      cat(GeneName[[1]][i], "\n")
      print(GeneLevel.m[GeneName[[1]][i],])
      cat("\n")
    }
    closeAllConnections()
  }
  
  cat("Check more genes, or press [Q] to quit: ")
  GeneList <- readLines(file("stdin"),1)
  while((GeneList == "")){
    cat("\nGene name cannot be empty.\n")
    cat("Check more genes, or press [Q] to quit: ")
    GeneList <- readLines(file("stdin"),1)
  }
  closeAllConnections()
  
  GeneName <- strsplit(GeneList, split = " ")
  
  continue <- !((GeneList == "Q") | (GeneList == "q"))
  
}


#GeneLevelControl.stat <- transform(GeneLevelControl.m,MEAN=apply(GeneLevelControl.m,1,mean,na.rm=T),SD=apply(GeneLevelControl.m,1,sd,na.rm=T))

closeAllConnections()
on.exit()
