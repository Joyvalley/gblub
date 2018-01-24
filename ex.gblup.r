## execute this script with: Rscript ex.gblup.r -x genofile -y phenofile -c cv file
source("gblub.r")

my.args <- commandArgs(trailingOnly = TRUE)
#my.args <- c("-x", "gent_geno.csv","-y" , "gent_pheno.csv")
### set defaults 
cvf.name = NA

## parsing the command line options 
for(i in 1:length(my.args)){
    if(my.args[i] == "-x"){
        geno.name <- as.character(my.args[i+1])
    } else if(my.args[i] == "-y") {
        pheno.name <- as.character(my.args[i+1])
    } else if(my.args[i] == "-c") {
        cvf.name <- as.character(my.args[i+1])
    } else if(my.args[i] == "-h") {
        print(" This script takes as a minimum two intputs\n")
        print(" -x genotypefile")
        print(" -y phenotypefile ")
        print(" -v cross-valiadtion file : is optional if none is specified random 5 fold cv will be used ")
        quit()
    }
}


#pheno.name <- my.args[1]
#geno.name <- my.args[2]
#cvf.name <- my.args[3]
#cvf = 2

gblup(pheno.name,geno.name,cvf.name,cvf, loot = F, gen.plot=FALSE)
