#!/bin/bash

# Quick and dirty extraction of the last line from all
# fix4melview_Standard_thr${fixThresh}.txt files so that FIX-identified noise components
# can be compared across registration methods and FIX thresholds.

parentDir='/data/panolocal/tempStowler'
tempFile=/tmp/fixResults.txt
columnFile=/tmp/fixColumns.txt

rm -f ${tempFile}
rm -f ${columnFile}


for methodEpiToStruct in BBR 12dof 7dof 6dof; do
   for methodStructToStd in 2mmNonlinear 2mmLinear None; do
      for fixThresh in 20 18 16; do
         classFile=${parentDir}/fixThresh${fixThresh}/melFromFeeds-struct${methodEpiToStruct}-standard${methodStructToStd}.ica/fix4melview_Standard_thr${fixThresh}.txt
         noiseList="`sed -n '$p' $classFile`"
         echo "struct${methodEpiToStruct} standard${methodStructToStd} fixThresh${fixThresh} ${noiseList}" >> ${tempFile}
      done # fixThresh
   done # methodStructToStd
done # methodEpiToStruct

column -t ${tempFile} > ${columnFile}
cat ${columnFile}
echo ""
ls -al ${columnFile}
