# gblub

The Genomic BLUP as executed in the gblup.r function is performed by the algorithms of the R-package synbreed http://synbreed.r-forge.r-project.org/

You might or might not encounter problems when installing the synbreed package. In my case this was due to a dependency of synbreed
to a package not available in CRAN: chopsticks. 'chopsticks' however is available on Bioconductor.
To install chopsticks exectue the following commands in R:

```R
source("https://bioconductor.org/biocLite.R")
biocLite("chopsticks")
```

Now install.packages("synbreed") should work. If it doesnt, please look in the documentation for synbreed

The function in gblub.r needs as input aat least two files: 1. a file with genotypes 2. a file with phenotypes the files need to be in your current working directory

The phenotype csv is 2*n  matrix where the first column contains the names of the genotypes and the second column harbors the phenotype values
n equals the number of genotypes that were phenotyped

The genotype csv is matrix of size n_genotypes*n_makers +1 coded  as 0 and 1 the first row contains the names of the genotypes the second to nth row 
are the SNP_markers.

It is not necassary to manually read the csv files into your environment the function does that for you, just enter the filenames when executin the function

```R
gblup("gent_pheno.csv","gent_geno.csv")
```

If everything works it should print the accuaracy ( 99.something for this case) and return a list called mod1.






