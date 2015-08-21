#!/bin/bash

# Generate a controlled-order list of ICA sessions to be used as inputs for
# MELODIC group ICA.

parentDir='/data/panolocal/tempStowler'

for methodEpiToStruct in BBR 12dof 7dof 6dof; do
   for methodStructToStd in 2mmNonlinear 2mmLinear None; do
      for fixThresh in 20 18 16; do
         echo ${parentDir}/fixThresh${fixThresh}/melFromFeeds-struct${methodEpiToStruct}-standard${methodStructToStd}.ica/filtered_func_data_clean.nii.gz
      done # fixThresh
   done # methodStructToStd
done # methodEpiToStruct

