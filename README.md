# AHPP: SVM-based ACE-I inhibitory peptide classifier

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![DOI](https://img.shields.io/badge/DOI-10.1021%2Facs.jafc.1c04555-blue)](https://doi.org/10.1021/acs.jafc.1c04555)

MATLAB script for classifying peptides as potential angiotensin-converting enzyme-I (ACE-I) inhibitors (anti-hypertensive peptides) using a support vector machine (SVM). The SVM is trained each time the script runs, from the training data included here. It is the first, classification-based modelling attempt developed during the **Anti-hypertensive Peptide Predictor (AHPP)** project.


## Background

Hypertension is a major risk factor for cardiovascular disease, and ACE-I is a key target of the renin–angiotensin–aldosterone system. Food-derived peptides can inhibit ACE-I, but identifying them experimentally is slow and costly. AHPP combines in silico gastrointestinal digestion of food proteins with machine-learning-based screening of the resulting peptides for ACE-I inhibitory potential.

- Web server: <http://hazralab.iitr.ac.in/ahpp/index.php>
- Anti-Hypertensive DataBase (AHDB): <http://hazralab.iitr.ac.in/ahdb/index.php>
- Article: [J. Agric. Food Chem. 2021, 69, 14995–15004](https://doi.org/10.1021/acs.jafc.1c04555)

## Method overview

| Step | Description |
|------|-------------|
| Classes | Positive (`PO`): IC<sub>50</sub> ≤ 20 µM. Negative (`NE`): IC<sub>50</sub> ≥ 1000 µM. Peptides in between are not used. |
| Features | Sequence-based pseudo amino acid composition (PseAAC) features, combined with eight structure-derived descriptors computed from modelled peptide structures (see the article). |
| Classifier | An SVM with an RBF kernel on the raw features, trained from the 1,466-peptide data set (773 peptides fall in the two classes) and applied to the test peptides. The kernel, class definition and tuned parameters follow the AHPP web-server manuscript. The original script loaded a pretrained model that is no longer available; see the notes. |
| Output | One predicted label (`PO` or `NE`) per peptide. |

The article defines the structure-derived descriptors as molecular weight, the spherical-coordinate shape parameters (R, α, β), positive charge, negative charge, hydropathy (GRAVY), and volume. PseAAC features were generated with PseAAC-Builder.

## Repository contents

| File | Purpose |
|------|---------|
| [`SVM_ahpp_complete.m`](SVM_ahpp_complete.m) | The complete script: trains the SVM from the training data, reports a cross-validation check, classifies the test peptides and writes the predictions. |
| [`SVM_ahpp_new.m`](SVM_ahpp_new.m) | The original script, unchanged. It loads a pretrained SVM from a `.mat` file that is not available, so it cannot run (see the notes). |
| [`data/train/data_regr2.mat`](data/train/data_regr2.mat) | Training data: `ic50_train` (1466 × 1) and `train_data_final` (1466 × 31 features). Also in the `ahpp_reg` repository. |
| [`data/example_test/`](data/example_test) | 25 example test peptides: `ml_csv.csv` (8 structure features) and `peptides.pfpseaac.csv` (23 sequence features). |
| [`data/ml_csv.csv`](data/ml_csv.csv) | Structure-derived features for 104 peptides (AHDB, December 2021). Their sequence features are not included, so they cannot be classified until those are generated. |

## Requirements

- MATLAB with the Statistics and Machine Learning Toolbox (`fitcsvm`, `predict`).

## Usage

Open MATLAB and run:

```matlab
SVM_ahpp_complete
```

The script finds its data relative to its own location, so it can be run from any folder. It trains the SVM, prints the training-set size and a 5-fold cross-validation check (accuracy, sensitivity, specificity), classifies the peptides in `data/example_test/` and writes the results next to the script.

To classify your own peptides, replace the two files in `data/example_test/` with files in the same format. Both files must list the same peptides; the order can differ.

## Output

| File | Content |
|------|---------|
| `output_peptide.csv` | `Peptide,Label` rows, positive (`PO`) predictions first, then negative (`NE`). |
| `positive_peptide.csv` | The peptides predicted positive. |
