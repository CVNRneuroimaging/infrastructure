#!/bin/bash

# Quick and dirty iteration of three FIX thresholds over 12 MELODIC outputs
# that were derived from FSL FEEDS fmri.nii.gz.

# Estimate of total time: 5.4 hours (9 minutes per run X 12 runs X 3 thresh)

# Work will be done on system drive instead of external or network:
rm -fr /tmp/fixThresh*

trainingFile=/opt/fix/training_files/Standard.RData

while read line; do
   icaRun=${line}
   for fixThresh in 20 18 16; do
      # Work will be done on system drive instead of external or network:
      mkdir /tmp/fixThresh${fixThresh}
      cp -R /data/panolocal/tempStowler/${icaRun} /tmp/fixThresh${fixThresh}/
      echo ""
      echo "######################################"
      date
      echo "Launching FIX:"
      echo "training file: ${trainingFile}"
      echo "ICA RUN:       ${icaRun}"
      echo "FIX threshold: ${fixThresh}"
      echo "FIX version:"
      which fix | xargs dirname | xargs ls -l
      echo "######################################"
      /usr/bin/time fix /tmp/fixThresh${fixThresh}/${icaRun} ${trainingFile} ${fixThresh} -m
      echo ""
      echo "FIX complete for thresh ${fixThresh} of ${icaRun}."
      echo "All related output directories:"
      du -sh /tmp/fixThresh*/*
      echo ""
   done #thresh loop
done <<EOM
melFromFeeds-structBBR-standard2mmNonlinear.ica
melFromFeeds-structBBR-standard2mmLinear.ica
melFromFeeds-structBBR-standardNone.ica
melFromFeeds-struct12dof-standard2mmNonlinear.ica
melFromFeeds-struct12dof-standard2mmLinear.ica
melFromFeeds-struct12dof-standardNone.ica
melFromFeeds-struct6dof-standard2mmNonlinear.ica
melFromFeeds-struct6dof-standard2mmLinear.ica
melFromFeeds-struct6dof-standardNone.ica
melFromFeeds-struct7dof-standard2mmNonlinear.ica
melFromFeeds-struct7dof-standard2mmLinear.ica
melFromFeeds-struct7dof-standardNone.ica
EOM
