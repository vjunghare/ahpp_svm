# AHPP: SVM-based ACE-I inhibitory peptide classifier

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![DOI](https://img.shields.io/badge/DOI-10.1021%2Facs.jafc.1c04555-blue)](https://doi.org/10.1021/acs.jafc.1c04555)

MATLAB script for classifying peptides as potential angiotensin-converting enzyme-I (ACE-I) inhibitors (anti-hypertensive peptides) using a support vector machine (SVM). It is the first, classification-based modelling attempt developed during the **Anti-hypertensive Peptide Predictor (AHPP)** project.


## Background

Hypertension is a major risk factor for cardiovascular disease, and ACE-I is a key target of the renin–angiotensin–aldosterone system. Food-derived peptides can inhibit ACE-I, but identifying them experimentally is slow and costly. AHPP combines in silico gastrointestinal digestion of food proteins with machine-learning-based screening of the resulting peptides for ACE-I inhibitory potential.

- Web server: <http://hazralab.iitr.ac.in/ahpp/index.php>
- Anti-Hypertensive DataBase (AHDB): <http://hazralab.iitr.ac.in/ahdb/index.php>
- Article: [J. Agric. Food Chem. 2021, 69, 14995–15004](https://doi.org/10.1021/acs.jafc.1c04555)

## Method overview

| Step | Description |
|------|-------------|
| Classes | Positive (`PO`): potent peptides (low IC<sub>50</sub>). Negative (`NE`): peptides with IC<sub>50</sub> > 1000 µM, based on experimentally reported values. |
| Features | Sequence-based pseudo amino acid composition (PseAAC) features, combined with eight structure-derived descriptors computed from modelled peptide structures (see the article). |
| Classifier | Pretrained SVM model loaded from a `.mat` file and applied to blind-test peptides. |
| Output | One predicted label (`PO` or `NE`) per peptide. |

The article defines the structure-derived descriptors as molecular weight, the spherical-coordinate shape parameters (R, α, β), positive charge, negative charge, hydropathy (GRAVY), and volume. PseAAC features were generated with PseAAC-Builder.

## Repository contents

| File | Purpose |
|------|---------|
| [`SVM_ahpp_new.m`](SVM_ahpp_new.m) | Loads the feature tables, applies the pretrained SVM, and writes peptide predictions. |
| [`data/ml_csv.csv`](data/ml_csv.csv) | Structure-derived features for 104 peptides to be classified (AHDB, December 2021). |
| [`LICENSE`](LICENSE) | GNU General Public License v3.0. |

## Requirements

- MATLAB with the Statistics and Machine Learning Toolbox (provides `predict` for the SVM model).
- The input files listed below. Only part of them are included in [`data/`](data).

## Usage

1. Copy the missing input files into [`data/`](data).
2. In MATLAB, make `data/` the current folder and add the repository root to the path.
3. Run:

   ```matlab
   cd data
   addpath('..')
   SVM_ahpp_new
   ```

## Output

| File | Content |
|------|---------|
| `output_peptide.csv` | `peptide,label` rows, positive (`PO`) predictions first, followed by negative (`NE`). |
| `positive_peptide.csv` | Intended list of positive predictions (see notes below). |

Output files are written to the current folder (`data/` when run as above) and are excluded by `.gitignore`.

## Notes

- This file is for reference and was used to train AHPP predictor.
- The published AHPP web server uses a regression decision tree that predicts peptide IC<sub>50</sub> values. This repository preserves the earlier SVM approach for reference.
