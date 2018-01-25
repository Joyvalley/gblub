## gblub function used by ex.gblub
## use: Rscript ex.gblup.r -x gent_geno.csv -y gent_pheno.csv -c gent_cvf.csv -JobId 2 -label value



gblup <- function(phenocsv, genocsv, cvfcsv, cvf=5, label = my_ph, inst = FALSE, req = TRUE, BLUP = TRUE, BL = FALSE, gen.plot = TRUE, loot=FALSE){

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
    
    ## init cross-validation
    if(is.character(cvfcsv)){
       cvf.csv <- read.csv(cvfcsv)
       my_cvf <- cvf.csv[,cvf+1]
    }
    if(is.na(cvfcsv))
        my_cvf = sample(1:5,dim(pheno.csv)[1],replace = T)
    if(loot){
        my_cvf = 1:(dim(pheno.csv)[1])
    }
    
    ## select phenotype
    if(any(colnames(pheno.csv)== label)){
        index <- which(colnames(pheno.csv) == label)
    }else{
        cat("you used a wrong phenotype")
        quit()
    }
    
    my_pheno <- as.data.frame(pheno.csv[,index],row.names = rownames(pheno.csv))
    rownames(my_pheno) <- NULL
    my_pheno <- (cbind(my_pheno,my_pheno))
    colnames(my_pheno) <- c("Yield","pred")

    my_geno <- as.data.frame(geno.csv[,2:dim(geno.csv)[2]], col.names = colnames(geno.csv),row.names=rownames(geno.csv))
    my_geno <- as.matrix(my_geno)

    for(i in 1:max(my_cvf)){
        cat("Predicting cv fold", i, "\n")
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







