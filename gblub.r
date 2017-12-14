### gblup function that gblups
## returns list mod1 for blup and mod3 for bayesian lasso

gblup <- function(phenocsv, genocsv, cvfcsv, cvf=5, inst = FALSE, req = TRUE, BLUP = TRUE, BL = FALSE, gen.plot = TRUE, loot=FALSE){

    depends<- c('synbreed',"BGLR","doBy","doParallel","foreach","MASS","qtl","regress",'R.utils')
    if(inst == TRUE)    

        sapply(depends,function(X){install.packages(X)})
    
    if(req == TRUE)
        foo <- sapply(depends,function(X){suppressPackageStartupMessages(library(X,character.only=TRUE))})

    rm(depends)
    if(req == TRUE)
        rm(foo)
    
    geno.csv <- read.csv(genocsv)
    pheno.csv <- read.csv(phenocsv)
    cvf.csv <- read.csv(cvfcsv)
    my_cvf <- cvf.csv[,cvf+1]
    if(loot){
        my_cvf = 1:length(my_cvf)
    }
    my_pheno <- as.data.frame(pheno.csv[,2],row.names = rownames(pheno.csv))
    rownames(my_pheno) <- NULL
    my_pheno <- (cbind(my_pheno,my_pheno))
    colnames(my_pheno) <- c("Yield","pred")

    my_geno <- as.data.frame(geno.csv[,2:dim(geno.csv)[2]], col.names = colnames(geno.csv),row.names=rownames(geno.csv))
    my_geno <- as.matrix(my_geno)

    for(i in 1:max(my_cvf)){
        my_gp <- create.gpData(pheno=my_pheno[my_cvf != i,],geno=my_geno,cores=2)
        myC <- codeGeno(my_gp)
        K <- kin(myC, ret="realized")/2
        mod1 <- gpMod(myC,model="BLUP",kin=K,markerEffects=TRUE,trait=2,predict=TRUE)
        intercept <- mod1$fit$beta[,1]
        my_pheno$pred[my_cvf == i] <- (mod1$prediction + intercept)
    }

    if(gen.plot==TRUE){
        png('plot.png')
        plot(my_pheno$Yield,my_pheno$pred)
        abline(0,1)
        dev.off()
    }
# print(my_pheno)
    mse = mean((my_pheno$pred - my_pheno$Yield)^2)
    print(c("MSE: ",mse))
    correlation = cor(my_pheno$pred, my_pheno$Yield)
    print(c("correlation: ",correlation))
}







