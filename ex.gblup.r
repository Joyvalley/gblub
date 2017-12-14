## execute this script with: Rscript ex.gblup.r 


source("/storage/evolgen/jan/gblub/gblub.r")
args <- commandArgs(trailingOnly = TRUE)
#args <- c("/storage/evolgen/jan/tens/maze.data/KE_pheno2.csv", "/storage/evolgen/jan/tens/maze.data/KE_18_1K2.csv")
args <- c("gent_pheno.csv","gent_geno.csv")

pheno.name <- args[1]
geno.name <- args[2]
cvf.name <- args[3]
cvf = 5
if(length(args) > 3){
    cvf = as.numeric(args[4])
}


gblup(pheno.name,geno.name,cvf.name,cvf,m=2)

