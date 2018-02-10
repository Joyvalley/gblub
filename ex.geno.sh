#!/bin/bash

for i in *10K.csv
do
    Rscript ../../../../gblub/ex.gp.sh.r -x $i -y PE_pheno.csv -label bla ;
done

