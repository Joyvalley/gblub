## execute this script with: Rscript ex.gblup.r -x genofile -y phenofile -c cv file
source("gblub.r")

my.args <- commandArgs(trailingOnly = TRUE)
#my.args <- c("-x", "gent_geno.csv","-y" , "gent_pheno.csv")
### set defaults 
cvf.name = NA
cvf = 2

## parsing the command line options 
all.opts <- c("-x","-y","-c","-JobId","-label","-h")
for(i in 1:length(my.args)){
    if( i %% 2 == 1){
        if(!my.args[i] %in%  all.opts){
            cat("unknown option", my.args[i], "Use only", all.opts , "\n")
            cat("use -h for help \n")
            quit()
        }
    }    
    if(my.args[i] == "-x"){
        geno.name <- as.character(my.args[i+1])
    } else if(my.args[i] == "-y") {
        pheno.name <- as.character(my.args[i+1])
    } else if(my.args[i] == "-c") {
        cvf.name <- as.character(my.args[i+1])
    } else if(my.args[i] == "-JobId") {
        cvf = as.numeric(my.args[i+1])
    } else if(my.args[i] == "-label") {
        my_ph <- as.character(my.args[i+1])      
    } else if(my.args[i] == "-h") {
        print(" This script takes as a minimum two intputs\n")
        print(" -x genotypefile")
        print(" -y phenotypefile ")
        print(" -v cross-valiadtion file : is optional if none is specified random 5 fold cv will be used")
        print(" -JobID : specify column number to use in your cross validation file")
        print(" -label : use header of phenotype file column you want to use")
        quit()
    }
}


#pheno.name <- my.args[1]
#geno.name <- my.args[2]
#cvf.name <- my.args[3]

gblup(pheno.name,geno.name,cvf.name,cvf, my_ph, loot = F, gen.plot=FALSE)

