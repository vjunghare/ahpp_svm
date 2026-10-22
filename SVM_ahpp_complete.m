% AHPP SVM: classify peptides as potential ACE-I inhibitors (PO) or not (NE).
%
% This is the complete version of SVM_ahpp_new.m. The original script loaded a pretrained
% SVM from a .mat file that is no longer available. This script trains an SVM from the
% training data in data/train/data_regr2.mat every time it runs, so no saved model is
% needed, and then classifies the peptides in data/example_test/.
%
% The pretrained model itself is lost, so this is a new SVM trained from the same data. Its
% kernel (RBF), class definition and tuned parameters follow the description of the SVM in
% the AHPP web-server manuscript (Kalyan et al., section "Prediction of anti hypertensive
% peptides"), which reports them for three PseAAC weight factors.
%
% Requires MATLAB with the Statistics and Machine Learning Toolbox (fitcsvm, predict).
% Run it from any folder; the file locations below are relative to this script.

clear; clc;
here = fileparts(mfilename('fullpath'));

%% Settings
trainFile  = fullfile(here, 'data', 'train', 'data_regr2.mat');
structFile = fullfile(here, 'data', 'example_test', 'ml_csv.csv');             % 8 structure features per peptide
pseaacFile = fullfile(here, 'data', 'example_test', 'peptides.pfpseaac.csv');  % 23 sequence features per peptide
outDir     = here;

% Class definition, as in the manuscript: IC50 <= 20 uM is positive (PO), IC50 >= 1000 uM is
% negative (NE). Peptides in between are not used.
posCutoff = 20;      % uM
negCutoff = 1000;    % uM

% SVM parameters. The manuscript used an RBF kernel and tuned the box constraint C and the
% kernel scale by Bayesian optimisation for three PseAAC weight factors w, reporting:
%     w      C        kernel scale   best accuracy
%     0.25   13.011   787.59         84.97 %
%     0.5    8.5084   275.96         85.01 %
%     0.7    6.8475   253.82         85.35 %
% The stored training data does not say which w its PseAAC features were built with (the
% 2021 paper uses w = 0.05), so treat these values as a starting point and check the
% cross-validation result printed below. Set optimise = true to search for C and the kernel
% scale on this data instead.
weightFactor = 0.7;
reported = [0.25 13.011 787.59;  0.5 8.5084 275.96;  0.7 6.8475 253.82];   % w, C, kernel scale
optimise = false;

%% Build the training set
% ic50_train: 1466 x 1 IC50 values (uM); train_data_final: 1466 x 31 features
% (23 sequence features followed by 8 structure features).
load(trainFile, 'ic50_train', 'train_data_final');

isPos = ic50_train <= posCutoff;
isNeg = ic50_train >= negCutoff;
use   = isPos | isNeg;

Xtrain = train_data_final(use, :);
labels = repmat({'NE'}, nnz(use), 1);
labels(isPos(use)) = {'PO'};
fprintf('Training set: %d positive (PO) and %d negative (NE) peptides.\n', nnz(isPos), nnz(isNeg));

%% Train the SVM
% RBF kernel on the raw features, which is what the reported kernel scales (hundreds) imply.
rng default
if optimise
    model = fitcsvm(Xtrain, labels, ...
        'KernelFunction', 'rbf', 'Standardize', false, 'ClassNames', {'NE', 'PO'}, ...
        'OptimizeHyperparameters', {'BoxConstraint', 'KernelScale'}, ...
        'HyperparameterOptimizationOptions', struct('MaxObjectiveEvaluations', 100, ...
            'ShowPlots', false, 'Verbose', 0));
else
    row = reported(reported(:, 1) == weightFactor, :);
    if isempty(row)
        error('weightFactor must be one of %s.', mat2str(reported(:, 1)'));
    end
    model = fitcsvm(Xtrain, labels, ...
        'KernelFunction', 'rbf', 'Standardize', false, ...
        'BoxConstraint', row(2), 'KernelScale', row(3), 'ClassNames', {'NE', 'PO'});
end

% 5-fold cross-validation, to see how well this kind of model separates the two classes.
cvLabels    = kfoldPredict(crossval(model, 'KFold', 5));
isPoLabel   = strcmp(labels, 'PO');
accuracy    = mean(strcmp(cvLabels, labels));
sensitivity = mean(strcmp(cvLabels(isPoLabel), 'PO'));    % positives found
specificity = mean(strcmp(cvLabels(~isPoLabel), 'NE'));   % negatives found
fprintf('5-fold cross-validation: accuracy %.3f, sensitivity %.3f, specificity %.3f\n', ...
    accuracy, sensitivity, specificity);

%% Read the test peptides
% The two files list the same peptides in different orders, so they are matched by name.
[namesStruct, S] = read_table_csv(structFile,  true,  'first');   % name, then 8 features
[namesPseaac, P] = read_table_csv(pseaacFile, false, 'last');     % 23 features, then name

[found, loc] = ismember(namesPseaac, namesStruct);
if ~all(found)
    error('These peptides are in %s but not in %s: %s', pseaacFile, structFile, strjoin(namesPseaac(~found), ', '));
end

Xtest = [P, S(loc, :)];                      % same column order as the training matrix
if size(Xtest, 2) ~= size(Xtrain, 2)
    error('Test data has %d feature columns but the model was trained on %d.', size(Xtest, 2), size(Xtrain, 2));
end

%% Classify
[predicted, score] = predict(model, Xtest);   % score(:, 2) is the score for the PO class
poScore = score(:, 2);

result = table(namesPseaac, predicted, poScore, 'VariableNames', {'Peptide', 'Label', 'PO_score'});
% Positive predictions first, highest score first within each group.
[~, order] = sortrows([double(strcmp(result.Label, 'PO')), result.PO_score], [-1 -2]);
result = result(order, :);
disp(result)

writetable(result(:, {'Peptide', 'Label'}), fullfile(outDir, 'output_peptide.csv'));
writetable(result(strcmp(result.Label, 'PO'), {'Peptide'}), fullfile(outDir, 'positive_peptide.csv'));
fprintf('Predictions written to %s and %s\n', ...
    fullfile(outDir, 'output_peptide.csv'), fullfile(outDir, 'positive_peptide.csv'));


function [names, X] = read_table_csv(file, hasHeader, nameColumn)
% Read a comma-separated file of peptide names and numeric features.
% nameColumn is 'first' or 'last'. Spaces around the fields are ignored.
txt   = strtrim(fileread(file));
lines = strsplit(txt, {'\r\n', '\n', '\r'});
if hasHeader
    lines(1) = [];
end
lines = lines(~cellfun(@(l) isempty(strtrim(l)), lines));

n     = numel(lines);
nCols = numel(strsplit(lines{1}, ','));
names = cell(n, 1);
X     = zeros(n, nCols - 1);
for i = 1:n
    p = strtrim(strsplit(lines{i}, ','));
    if numel(p) ~= nCols
        error('Line %d of %s has %d fields, expected %d.', i, file, numel(p), nCols);
    end
    if strcmp(nameColumn, 'first')
        names{i} = p{1};
        X(i, :)  = str2double(p(2:end));
    else
        names{i} = p{end};
        X(i, :)  = str2double(p(1:end-1));
    end
end
if any(isnan(X(:)))
    error('Non-numeric value found in %s.', file);
end
end
