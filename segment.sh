#!/bin/bash

# config inputs
anat=`jq -r '.anat' config.json`
mask=`jq -r '.mask' config.json`

[ ! -d mask ] && mkdir mask

[ ! -f t1_mask.nii.gz ] && fslmaths ${anat} -mas ${mask} t1_mask.nii.gz

fast -g -N -p t1_mask.nii.gz && mv *.nii.gz ./mask/

if [ ! -f ./mask/t1_mask_seg.nii.gz ]; then
	echo "something went wrong. check logs and derivatives"
	exit 1
fi

echo "complete"
mv ./mask/t1_mask_seg.nii.gz ./mask/mask.nii.gz
mv ./mask/t1_mask_prob_0.nii.gz ./mask/CSF-probseg.nii.gz
mv ./mask/t1_mask_prob_1.nii.gz ./mask/GM-probseg.nii.gz
mv ./mask/t1_mask_prob_2.nii.gz ./mask/WM-probseg.nii.gz

mv ./mask/t1_mask_seg_0.nii.gz ./mask/CSF-seg.nii.gz
mv ./mask/t1_mask_seg_1.nii.gz ./mask/GM-seg.nii.gz
mv ./mask/t1_mask_seg_2.nii.gz ./mask/WM-seg.nii.gz

mv ./mask/t1_mask_pve_0.nii.gz ./mask/CSF-pveseg.nii.gz
mv ./mask/t1_mask_pve_1.nii.gz ./mask/GM-pveseg.nii.gz
mv ./mask/t1_mask_pve_2.nii.gz ./mask/WM-pveseg.nii.gz
