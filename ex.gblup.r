## execute this script with: Rscript ex.gblup.r 


source("/storage/evolgen/jan/gblub/gblub.r")
args <- commandArgs(trailingOnly = TRUE)
#args <- c("/storage/evolgen/jan/tens/maze.data/KE_pheno2.csv", "/storage/evolgen/jan/tens/maze.data/KE_18_1K2.csv")
args <- c("gent_pheno.csv","gent_geno.csv")

pheno.name <- args[1]
geno.name <- args[2]


gblup(pheno.name,geno.name)

