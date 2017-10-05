source("gblub.r")
args <- commandArgs(trailingOnly = TRUE)


pheno.name <- args[1]
geno.name <- args[2]


pheno <- read.csv("gent_pheno.csv")
gblup("gent_pheno.csv","gent_geno.csv")

gblup(pheno.name,geno.name)


