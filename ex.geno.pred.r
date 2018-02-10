
## execute this script with: Rscript ex.gblup.r -x genofile -y phenofile -c cv file
source("~/jan_storage/gblub/bglr.r")


my.args <- commandArgs(trailingOnly = TRUE)
#my.args <- c("-x", "gent_geno.csv","-y" , "gent_pheno.csv")
### set defaults 
#cvf.name = NA

## parsing the command line options 
all.opts <- c("-x","-y","-label","-h")
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
    } else if(my.args[i] == "-label") {
        my_ph <- as.character(my.args[i+1])      
    } else if(my.args[i] == "-h") {
        print(" This script takes as a minimum two intputs\n")
        print(" -x genotypefile")
        print(" -y phenotypefile ")
        print(" -cv cross-valiadtion file : is optional if none is specified random 5 fold cv will be used")
        print(" -JobID : specify column number to use in your cross validation file")
        print(" -label : use header of phenotype file column you want to use")
        quit()
    }
}


#pheno.name <- my.args[1]
#geno.name <- my.args[2]
#cvf.name <- my.args[3]


for(i in c("BRR","BayesA","BayesB","BayesC","BL")){
    for(j in 1:5){
        geno_pred(phenocsv = pheno.name,genocsv=geno.name,label=my_ph,mod = i)
    }
}

