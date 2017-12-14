### gblup function that gblups

## returns list mod1 for blup and mod3 for bayesian lasso
gblup <- function(phenocsv, genocsv, inst = FALSE, req = TRUE, BLUP = TRUE, BL = FALSE, gen.plot = TRUE, m = 2){

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
    my_pheno <- as.data.frame(pheno.csv[,m],row.names = rownames(pheno.csv))
    rownames(my_pheno) <- NULL
    my_pheno <- (cbind(my_pheno,my_pheno))
    colnames(my_pheno) <- c("Yield","Yield2")
    
    my_geno <- as.data.frame(geno.csv[,2:dim(geno.csv)[2]], col.names = colnames(geno.csv),row.names=rownames(geno.csv))
    my_geno <- as.matrix(my_geno)
      

    my_gp <- create.gpData(pheno=my_pheno,geno=my_geno,cores=2)
    myC <- codeGeno(my_gp)
    K <- kin(myC, ret="realized")/2
    
    if(BLUP==TRUE){
        mod1 <- gpMod(myC,model="BLUP",kin=K,markerEffects=TRUE,trait=2)
        y <- mod1$y
        g <- mod1$g
        intercept <- mod1[1][[1]][5][1][[1]][,1]
        pred <- g + intercept
        mod1[[7]] <- pred
        mod1[[8]] <- cor(pred,y)
        names(mod1)[7:8] <- c("Predicted Phenotypes","Prediction Accuracy")
        cat("Prediction accuracy of Genomic BLUP is ", mod1[[8]]*100, 'percent\n')
        
        if(gen.plot==TRUE){
            png('plot.png')
            plot(pred,y)
	    abline(0,1)
	    dev.off()
        }
        mod1 <<- mod1
    }
    
    if(BL==TRUE){
        prior <- list(varE=list(df=3,S=35),lambda = list(shape=0.52,rate=1e-4,value=20,type='random'))
        mod3 <<- gpMod(myC,model="BL",prior=prior,nIter=6000,burnIn=1000,thin=5)}
         
    
}







