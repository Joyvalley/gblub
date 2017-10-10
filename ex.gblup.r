## execute this script with: Rscript ex.gblup.r 

source("gblub.r")
args <- commandArgs(trailingOnly = TRUE)

pheno.name <- args[1]
geno.name <- args[2]

gblup(pheno.name,geno.name)



