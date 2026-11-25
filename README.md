<h1 align="center">FSL FAST tissue segmentation</h1>

<p align="center">
  CSF, gray matter and white matter segmentations and partial-volume maps from a brain-masked T1-weighted image, with FSL FAST.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.771"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.771-blue.svg" alt="Run on brainlife.io"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="MIT license"></a>
</p>

## At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Segments a brain-masked T1-weighted image into CSF, gray matter and white matter with FSL FAST, producing hard segmentations and partial-volume maps.**

Applies the brain mask to the T1 with fslmaths and runs FSL fast (-g -N -p), writing the labelled segmentation as mask.nii.gz plus per-tissue binary, probability and partial-volume images. Use it for tissue masks or partial-volume estimates.

| | |
|---|---|
| **Inputs** | `neuro/anat/t1w` · `neuro/mask` |
| **Outputs** | `neuro/mask` |
| **Container** | `brainlife/fsl:6.0.4-patched2` |
| **Resources** | 4 CPUs · 0.5 h walltime |
| **Run it** | [doi.org/10.25663/brainlife.app.771](https://doi.org/10.25663/brainlife.app.771) |

#### Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `anat` | `neuro/anat/t1w` | yes | T1-weighted image. Must be on the same voxel grid as the brain mask. |
| `mask` | `neuro/mask` (anat, brain) | yes | Brain mask of the T1, used to skull-strip it before FAST. |

#### Outputs

| Output | Datatype | Description |
|---|---|---|
| `mask` | `neuro/mask` | Tissue segmentation (mask.nii.gz) plus CSF/GM/WM-seg, -probseg and -pveseg images. |

<!-- brainlife-app:end -->

## Running the App

### On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.771](https://doi.org/10.25663/brainlife.app.771), choose a T1-weighted image (`neuro/anat/t1w`) and its brain mask (`neuro/mask` tagged `anat` and `brain`) from your project, and press **Execute**. The App writes a `neuro/mask` dataset tagged `fsl_fast` and `tissue_types` to your project. Use it for tissue masks or partial-volume estimates.

The T1 and the brain mask must be on the same voxel grid. The App applies the mask to the T1 with `fslmaths -mas` and runs `fast -g -N -p` (separate binary images per tissue, no bias-field correction output, probability maps).

### Locally

You need [Singularity/Apptainer](https://apptainer.org/) and [`jq`](https://jqlang.github.io/jq/). The App runs in the `brainlife/fsl:6.0.4-patched2` container.

1. Clone this repository.
2. Create `config.json` with the paths to your inputs:

   ```json
   {
       "anat": "testdata/t1.nii.gz",
       "mask": "testdata/mask.nii.gz"
   }
   ```

3. Run the App:

   ```bash
   ./main
   ```

## Outputs

```text
mask/
├── mask.nii.gz                 labelled tissue segmentation (1 = CSF, 2 = GM, 3 = WM)
├── CSF-seg.nii.gz, GM-seg.nii.gz, WM-seg.nii.gz           binary masks per tissue
├── CSF-probseg.nii.gz, GM-probseg.nii.gz, WM-probseg.nii.gz   tissue probability maps
└── CSF-pveseg.nii.gz, GM-pveseg.nii.gz, WM-pveseg.nii.gz      partial-volume estimates
```

The remaining FAST outputs (for example the mixel type and restored image) are kept in `mask/` with their original FAST names.

## Troubleshooting

- **`something went wrong. check logs and derivatives`**: FAST did not produce a segmentation. Check that the T1 and the mask are aligned and on the same grid, and that the mask is not empty.

## Citing

> [!TIP]
> If you use this App in your work, please cite the App, the software it builds on and brainlife.io (below). GitHub's **Cite this repository** button gives the App citation in APA and BibTeX.

- Segment tissue types using FSL Fast. brainlife.io App. [doi:10.25663/brainlife.app.771](https://doi.org/10.25663/brainlife.app.771)
- Jenkinson et al. FSL. *NeuroImage* 62:782-790 (2012). [doi:10.1016/j.neuroimage.2011.09.015](https://doi.org/10.1016/j.neuroimage.2011.09.015)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. *Scientific Data* 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## Authors

- Brad Caron

## Funding

[![Wellcome-226486/Z/22/Z](https://img.shields.io/badge/Wellcome-226486%2FZ%2F22%2FZ-purple.svg)](https://wellcome.org/)
[![NIH-NINDS-U24NS140384](https://img.shields.io/badge/NIH_NINDS-U24NS140384-green.svg)](https://reporter.nih.gov/project-details/11261037)
[![NIH-NINDS-UM1NS132207](https://img.shields.io/badge/NIH_NINDS-UM1NS132207-green.svg)](https://reporter.nih.gov/project-details/11411328)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://reporter.nih.gov/project-details/10262925)
[![NIH-NIBIB-R01EB030896](https://img.shields.io/badge/NIH_NIBIB-R01EB030896-green.svg)](https://reporter.nih.gov/project-details/10428625)
[![NIH-NIMH-R01MH126699](https://img.shields.io/badge/NIH_NIMH-R01MH126699-green.svg)](https://reporter.nih.gov/project-details/10460628)
[![NIH-NIDCD-R01DC020088](https://img.shields.io/badge/NIH_NIDCD-R01DC020088-green.svg)](https://reporter.nih.gov/project-details/11140284)
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-2203524](https://img.shields.io/badge/NSF_BCS-2203524-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2203524)
[![NSF-IIS-1636893](https://img.shields.io/badge/NSF_IIS-1636893-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-OAC-2148729](https://img.shields.io/badge/NSF_OAC-2148729-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148729)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-IIS-2148700](https://img.shields.io/badge/NSF_IIS-2148700-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148700)
[![NSF-OAC-1916518](https://img.shields.io/badge/NSF_OAC-1916518-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1916518)

<sub>brainlife.io is publicly funded, and acknowledging that support helps keep it running. This App was developed with support from Wellcome, the U.S. National Institutes of Health (including the BRAIN Initiative BRAIN CONNECTS program: The Axonal Projectome EXchange, U24NS140384, and the Center for Mesoscale Connectomics, UM1NS132207) and the U.S. National Science Foundation.</sub>

## License

MIT. FSL is distributed under its own [license](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Licence).
