#!/bin/bash

# config inputs
anat=`jq -r '.anat' config.json`
mask=`jq -r '.mask' config.json`

[ ! -d mask ] && mkdir mask

[ ! -f t1_mask.nii.gz ] && fslmaths ${anat} -mas ${mask} t1_mask.nii.gz

fast -g -N -p t1_mask.nii.gz && cp -v *.nii.gz ./mask/

if [ ! -f ./mask/t1_mask_seg.nii.gz ]; then
	echo "something went wrong. check logs and derivatives"
	exit 1
fi

echo "complete"
mv ./mask/t1_mask_seg.nii.gz ./mask/mask.nii.gz
