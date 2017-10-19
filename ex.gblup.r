## execute this script with: Rscript ex.gblup.r 

source("gblub.r")
args <- commandArgs(trailingOnly = TRUE)

pheno.name <- args[1]
geno.name <- args[2]
cvf.name <- args[3]
cvf = 5
if(length(args) > 3){
    cvf = as.numeric(args[4])
}

gblup(pheno.name,geno.name,cvf.name,cvf)



