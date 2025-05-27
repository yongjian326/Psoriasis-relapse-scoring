# Psoriasis Relapse Scoring using AUCell

This repository demonstrates how to compute AUCell-based enrichment scores for relapse-associated gene sets in single-cell RNA-seq data (Seurat object).

## Structure

- `AUCell_scoring.R`: Main R script to calculate AUCell scores and add them to the Seurat object.
- `gene_sets/`: Contains RDS files of gene lists for different relapse-associated modules (`risk`, `protect`, `trm`).
- `example_exprMat.rds`: (Optional) Example expression matrix.
- `scRNA_with_AUCell.rds`: Output Seurat object with AUCell scores added to metadata.

## How to use

1. Replace `scRNA` with your Seurat object.
2. Edit the gene sets or add your own in the `gene_sets/` folder.
3. Run `AUCell_scoring.R`.
4. The result is a Seurat object with `AUCell_risk`, `AUCell_protect`, etc., in `@meta.data`.

## Requirements

- R packages: `Seurat`, `AUCell`
