### glub 
## borrowed functions from synbreed ... install.packages("synbreed") doesnt work so Download the functions from https://cran.r-project.org/web/packages/synbreed/index.html
### you just have to change the directory unless you put in ~/R/synbree

## uncomment the next two lines for first time use to load required packages
depends <- c("abind","BGLR","doBy","doParallel","foreach","MASS","qtl","regress")
sapply(depends,function(X){install.packages(X)})

sapply(depends, library, character.only = TRUE)


setwd("~/R/synbreed/R")
syn_funcs <- dir()
sapply(syn_funcs, function(X) {source(X)})

names(maize)

maizeC <- codeGeno(maize)
K <- kin(maizeC,ret="kin",DH=maize$covar$DH)
U <- kin(maizeC,ret="realized")/2

mod1 <- gpMod(maizeC,model="BLUP",kin=K)
mod2 <- gpMod(maizeC,model="BLUP",kin=U)
prior <- list(varE=list(df=3,S=35),lambda = list(shape=0.52,rate=1e-4,value=20,type='random'))
mod3 <- gpMod(maizeC,model="BL",prior=prior,nIter=6000,burnIn=1000,thin=5)

names(mod1)
mod2[[3]]
