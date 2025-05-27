library(Seurat)
library(AUCell)

# --- Load Seurat object or expression matrix ---
# Replace with your own Seurat object
# scRNA <- readRDS("your_seurat_object.rds")
exprMatrix <- GetAssayData(scRNA, slot = "data")

# --- Load gene sets (each set as an RDS file) ---
risk_genes <- readRDS("gene_sets/relapse_geneset_risk.rds")
protect_genes <- readRDS("gene_sets/relapse_geneset_protect.rds")
trm_genes <- readRDS("gene_sets/relapse_geneset_trm.rds")

geneSets <- list(
  risk = risk_genes,
  protect = protect_genes,
  trm = trm_genes
)

# --- AUCell ranking ---
cells_rankings <- AUCell_buildRankings(exprMatrix, nCores = 1, plotStats = TRUE)

# --- Calculate AUC scores ---
cells_AUC <- AUCell_calcAUC(geneSets, cells_rankings)

# --- Add AUC scores to Seurat metadata ---
auc <- getAUC(cells_AUC)
for (set in rownames(auc)) {
  scRNA <- AddMetaData(scRNA, metadata = as.vector(auc[set, ]), col.name = paste0("AUCell_", set))
}

# --- Save result ---
saveRDS(scRNA, file = "scRNA_with_AUCell.rds")
