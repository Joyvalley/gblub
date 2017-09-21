### gblup function that gblups
## works fine if you returns list mod1 for blup and mod3 for bayesian lasso



pheno <- read.csv("gent_pheno.csv")
head(pheno)

gblup("gent_pheno.csv","gent_geno.csv")

y <- mod1$y
g <- mod1$g

pred <- y + g
plot(pred,y)
cor(pred)



gblup <- function(phenocsv, genocsv, inst = FALSE, req = TRUE, BLUP = TRUE, BL = FALSE){

    depends<- c('synbreed',"BGLR","doBy","doParallel","foreach","MASS","qtl","regress",'R.utils')
    if(inst == TRUE)    
        sapply(depends,function(X){install.packages(X)})
    
    if(req == TRUE)
        foo <- sapply(depends,library, character.only = TRUE)

    rm(depends)
    if(req == TRUE)
        rm(foo)
    


    geno.csv <- read.csv(genocsv)
    pheno.csv <- read.csv(phenocsv)
    my_pheno <- as.data.frame(pheno.csv[,2],row.names = rownames(pheno.csv))
    colnames(my_pheno) <- "Yield"
    my_geno <- as.data.frame(geno.csv[,2:dim(geno.csv)[2]], col.names = colnames(geno.csv),row.names=rownames(geno.csv))
    my_geno <- as.matrix(my_geno)
      

    my_gp <- create.gpData(pheno=my_pheno,geno=my_geno)
    myC <- codeGeno(my_gp)
    K <- kin(myC, ret="realized")/2

    if(BLUP==TRUE)
        mod1 <<- gpMod(myC,model="BLUP",kin=K)

    if(BL==TRUE){
        prior <- list(varE=list(df=3,S=35),lambda = list(shape=0.52,rate=1e-4,value=20,type='random'))
        mod3 <<- gpMod(myC,model="BL",prior=prior,nIter=6000,burnIn=1000,thin=5)}
         
}







