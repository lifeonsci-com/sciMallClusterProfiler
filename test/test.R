

library(sciMallClusterProfiler)
library(org.Hs.eg.db)

setwd('~/GitProject/生物信息/ClusterProfileTest/')
Enrichment <- read.table("Enrichment.txt",sep = "\t",stringsAsFactors = F,check.names=F,header = T)
Module <- data.frame(unique(Enrichment[,1]))#对模块列去重

for (i in 1:nrow(Module)){
  Enrich_Source <- Enrichment[Enrichment$Module == Module[i,1],]
  gene <- as.character(Enrich_Source[,2])
  
  KEGG <- enrichKEGG(gene = gene, organism = "hsa", keyType = "kegg",
                     pvalueCutoff = 0.05, pAdjustMethod = "BH", minGSSize = 1,
                     qvalueCutoff = 0.05, use_internal_data = FALSE)
  KEGG = setReadable(KEGG, OrgDb = org.Hs.eg.db, keyType = "ENTREZID")
  KEGG_Pathway <- as.data.frame(KEGG @ result)
  write.table(KEGG_Pathway , paste('KEGG_Pathway_', Module[i,1], '.txt', sep=""),row.names = F,quote = F,sep="\t")
}






