## execute this script with: Rscript ex.gblup.r 


source("gblub.r")
args <- commandArgs(trailingOnly = TRUE)

pheno.name <- args[1]
geno.name <- args[2]

pheno <- read.csv("gent_pheno.csv")

gblup(pheno.name,geno.name)

phenocsv <- "gent_pheno.csv"
genocsv <- "gent_geno.csv"
