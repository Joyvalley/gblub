# gblub

The Genomic BLUP as executed in the gblup.r function is performed by the algorithms of the R-package BGLR, it is also possible to do BayesA, BayesB, BayesC BL.

It should install the required packages automatically, when executed the first time


The phenotype csv is 2*n  matrix where the first column contains the names of the genotypes and the second column harbors the phenotype values
n equals the number of genotypes that were phenotyped

The genotype csv is matrix of size n_genotypes*n_makers +1 coded  as 0 and 1 the first row contains the names of the genotypes the second to nth row 
are the SNP_markers.

It is not necassary to manually read the csv files into your environment the function does that for you, just enter the filenames when executin the function

```R
gblup("gent_pheno.csv","gent_geno.csv")
```

it will write an output file called gp_results.csv that stores all the relevant information


## command line usage
`Rscript ex.gblup.r -x gent_geno.csv -y gent_pheno.csv -label value `
type `Rscript ex.gblup -h` for help



