#!/bin/bash

# Quick and dirty extraction of the last line from all
# fix4melview_Standard_thr${fixThresh}.txt files so that FIX-identified noise components
# can be compared across registration methods and FIX thresholds.

parentDir='/data/panolocal/tempStowler'



for methodEpiToStruct in BBR 12dof 7dof 6dof; do
   for methodStructToStd in 2mmNonlinear 2mmLinear None; do
      for fixThresh in 20 18 16; do
         echo ${parentDir}/fixThresh${fixThresh}/melFromFeeds-struct${methodEpiToStruct}-standard${methodStructToStd}.ica/filtered_func_data_clean.nii.gz
      done # fixThresh
   done # methodStructToStd
done # methodEpiToStruct

