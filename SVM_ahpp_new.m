clear all; clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TRAIN INPUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PseAAC_neg_data_1 = double(fopen(fullfile(pwd, 'ic_gr1000_pseaac.csv')));
PseAAC_pos_data_1 = double(fopen(fullfile(pwd, 'ic_less20_pseaac.csv')));

neg_data_2 = double(csvread(fullfile(pwd, 'pep_gr1000.csv'), 1,1));
pos_data_2 = double(csvread(fullfile(pwd, 'pep_less20.csv'), 1,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PseAAC_neg_data_11 = cell(textscan(PseAAC_neg_data_1,...
    '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s','Delimiter',','));
PseAAC_pos_data_11 = cell(textscan(PseAAC_pos_data_1,...
    '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s','Delimiter',','));
fclose(PseAAC_neg_data_1);
fclose(PseAAC_pos_data_1);

list_11_neg = cell(PseAAC_neg_data_11{1,1});
list_12_neg = cell(PseAAC_neg_data_11{1,2});
list_13_neg = cell(PseAAC_neg_data_11{1,3});
list_14_neg = cell(PseAAC_neg_data_11{1,4});
list_15_neg = cell(PseAAC_neg_data_11{1,5});
list_16_neg = cell(PseAAC_neg_data_11{1,6});
list_17_neg = cell(PseAAC_neg_data_11{1,7});
list_18_neg = cell(PseAAC_neg_data_11{1,8});
list_19_neg = cell(PseAAC_neg_data_11{1,9});
list_110_neg = cell(PseAAC_neg_data_11{1,10});
list_111_neg = cell(PseAAC_neg_data_11{1,11});
list_112_neg = cell(PseAAC_neg_data_11{1,12});
list_113_neg = cell(PseAAC_neg_data_11{1,13});
list_114_neg = cell(PseAAC_neg_data_11{1,14});
list_115_neg = cell(PseAAC_neg_data_11{1,15});
list_116_neg = cell(PseAAC_neg_data_11{1,16});
list_117_neg = cell(PseAAC_neg_data_11{1,17});
list_118_neg = cell(PseAAC_neg_data_11{1,18});
list_119_neg = cell(PseAAC_neg_data_11{1,19});
list_120_neg = cell(PseAAC_neg_data_11{1,20});
list_121_neg = cell(PseAAC_neg_data_11{1,21});
list_122_neg = cell(PseAAC_neg_data_11{1,22});
list_123_neg = cell(PseAAC_neg_data_11{1,23});
list_124_neg = cell(PseAAC_neg_data_11{1,24});
train_trash_neg_11 = {};
train_idx_neg_11 = double([]);
[train_trash_neg_11,train_idx_neg_11] = sort(list_124_neg);
train_trash_12_neg = str2double(list_11_neg(train_idx_neg_11));
train_trash_13_neg = str2double(list_12_neg(train_idx_neg_11));
train_trash_14_neg = str2double(list_13_neg(train_idx_neg_11));
train_trash_15_neg = str2double(list_14_neg(train_idx_neg_11));
train_trash_16_neg = str2double(list_15_neg(train_idx_neg_11));
train_trash_17_neg = str2double(list_16_neg(train_idx_neg_11));
train_trash_18_neg = str2double(list_17_neg(train_idx_neg_11));
train_trash_19_neg = str2double(list_18_neg(train_idx_neg_11));
train_trash_110_neg = str2double(list_19_neg(train_idx_neg_11));
train_trash_111_neg = str2double(list_110_neg(train_idx_neg_11));
train_trash_112_neg = str2double(list_111_neg(train_idx_neg_11));
train_trash_113_neg = str2double(list_112_neg(train_idx_neg_11));
train_trash_114_neg = str2double(list_113_neg(train_idx_neg_11));
train_trash_115_neg = str2double(list_114_neg(train_idx_neg_11));
train_trash_116_neg = str2double(list_115_neg(train_idx_neg_11));
train_trash_117_neg = str2double(list_116_neg(train_idx_neg_11));
train_trash_118_neg = str2double(list_117_neg(train_idx_neg_11));
train_trash_119_neg = str2double(list_118_neg(train_idx_neg_11));
train_trash_120_neg = str2double(list_119_neg(train_idx_neg_11));
train_trash_121_neg = str2double(list_120_neg(train_idx_neg_11));
train_trash_122_neg = str2double(list_121_neg(train_idx_neg_11));
train_trash_123_neg = str2double(list_122_neg(train_idx_neg_11));
train_trash_124_neg = str2double(list_123_neg(train_idx_neg_11));

train_trash_neg = [train_trash_12_neg, train_trash_13_neg, train_trash_14_neg, train_trash_15_neg, train_trash_16_neg,...
    train_trash_17_neg, train_trash_18_neg, train_trash_19_neg, train_trash_110_neg, train_trash_111_neg,...
    train_trash_112_neg, train_trash_113_neg, train_trash_114_neg, train_trash_115_neg, train_trash_116_neg, ...
    train_trash_117_neg, train_trash_118_neg, train_trash_119_neg, train_trash_120_neg, train_trash_121_neg, ...
    train_trash_122_neg, train_trash_123_neg, train_trash_124_neg];

list_11_pos = cell(PseAAC_pos_data_11{1,1});
list_12_pos = cell(PseAAC_pos_data_11{1,2});
list_13_pos = cell(PseAAC_pos_data_11{1,3});
list_14_pos = cell(PseAAC_pos_data_11{1,4});
list_15_pos = cell(PseAAC_pos_data_11{1,5});
list_16_pos = cell(PseAAC_pos_data_11{1,6});
list_17_pos = cell(PseAAC_pos_data_11{1,7});
list_18_pos = cell(PseAAC_pos_data_11{1,8});
list_19_pos = cell(PseAAC_pos_data_11{1,9});
list_110_pos = cell(PseAAC_pos_data_11{1,10});
list_111_pos = cell(PseAAC_pos_data_11{1,11});
list_112_pos = cell(PseAAC_pos_data_11{1,12});
list_113_pos = cell(PseAAC_pos_data_11{1,13});
list_114_pos = cell(PseAAC_pos_data_11{1,14});
list_115_pos = cell(PseAAC_pos_data_11{1,15});
list_116_pos = cell(PseAAC_pos_data_11{1,16});
list_117_pos = cell(PseAAC_pos_data_11{1,17});
list_118_pos = cell(PseAAC_pos_data_11{1,18});
list_119_pos = cell(PseAAC_pos_data_11{1,19});
list_120_pos = cell(PseAAC_pos_data_11{1,20});
list_121_pos = cell(PseAAC_pos_data_11{1,21});
list_122_pos = cell(PseAAC_pos_data_11{1,22});
list_123_pos = cell(PseAAC_pos_data_11{1,23});
list_124_pos = cell(PseAAC_pos_data_11{1,24});
train_trash_pos_11 = {};
train_idx_pos_11 = double([]);
[train_trash_pos_11,train_idx_pos_11] = sort(list_124_pos);
train_trash_12_pos = str2double(list_11_pos(train_idx_pos_11));
train_trash_13_pos = str2double(list_12_pos(train_idx_pos_11));
train_trash_14_pos = str2double(list_13_pos(train_idx_pos_11));
train_trash_15_pos = str2double(list_14_pos(train_idx_pos_11));
train_trash_16_pos = str2double(list_15_pos(train_idx_pos_11));
train_trash_17_pos = str2double(list_16_pos(train_idx_pos_11));
train_trash_18_pos = str2double(list_17_pos(train_idx_pos_11));
train_trash_19_pos = str2double(list_18_pos(train_idx_pos_11));
train_trash_110_pos = str2double(list_19_pos(train_idx_pos_11));
train_trash_111_pos = str2double(list_110_pos(train_idx_pos_11));
train_trash_112_pos = str2double(list_111_pos(train_idx_pos_11));
train_trash_113_pos = str2double(list_112_pos(train_idx_pos_11));
train_trash_114_pos = str2double(list_113_pos(train_idx_pos_11));
train_trash_115_pos = str2double(list_114_pos(train_idx_pos_11));
train_trash_116_pos = str2double(list_115_pos(train_idx_pos_11));
train_trash_117_pos = str2double(list_116_pos(train_idx_pos_11));
train_trash_118_pos = str2double(list_117_pos(train_idx_pos_11));
train_trash_119_pos = str2double(list_118_pos(train_idx_pos_11));
train_trash_120_pos = str2double(list_119_pos(train_idx_pos_11));
train_trash_121_pos = str2double(list_120_pos(train_idx_pos_11));
train_trash_122_pos = str2double(list_121_pos(train_idx_pos_11));
train_trash_123_pos = str2double(list_122_pos(train_idx_pos_11));
train_trash_124_pos = str2double(list_123_pos(train_idx_pos_11));

train_trash_pos = [train_trash_12_pos, train_trash_13_pos, train_trash_14_pos, train_trash_15_pos, train_trash_16_pos,...
    train_trash_17_pos, train_trash_18_pos, train_trash_19_pos, train_trash_110_pos, train_trash_111_pos,...
    train_trash_112_pos, train_trash_113_pos, train_trash_114_pos, train_trash_115_pos, train_trash_116_pos, ...
    train_trash_117_pos, train_trash_118_pos, train_trash_119_pos, train_trash_120_pos, train_trash_121_pos, ...
    train_trash_122_pos, train_trash_123_pos, train_trash_124_pos];

data_1 = double([train_trash_neg; train_trash_pos]);
data_2 = double([neg_data_2; pos_data_2]);
data_all_train = double([data_1, data_2]);
size_pos = double(size(pos_data_2));
size_neg = double(size(neg_data_2));
sign_neg= char(['NE']);
label_neg = char(repmat(sign_neg, size_neg(1), 1));
sign_pos= char(['PO']);
label_pos = char(repmat(sign_pos, size_pos(1), 1));

label = char([label_neg; label_pos]);

SVMModel.BoxConstraints=double([]);
SVMModel.CacheInfo=struct([]);
SVMModel.ConvergenceInfo=struct([]); 
SVMModel.Gradient=double([]); 
SVMModel.IsSupportVector=logical([]); 
SVMModel.Nu=double([]); 
SVMModel.NumIterations=double([]); 
SVMModel.OutlierFraction=double([]); 
SVMModel.ShrinkagePeriod=double([]); 
SVMModel.Solver=char([]); 
SVMModel.Y=char([]); 
SVMModel.X=double([]); 
SVMModel.RowsUsed=double([]); 
SVMModel.W=double([]);  
SVMModel.NumObservations=double([]); 
SVMModel.HyperparameterOptimizationResults=double([]); 
SVMModel.PredictorNames={}; 
SVMModel.CategoricalPredictors=double([]); 
SVMModel.ResponseName=char([]); 
SVMModel.ExpandedPredictorNames={}; 
SVMModel.ClassNames=char([]); 
SVMModel.Prior=double([]); 
SVMModel.Cost=double([]); 
SVMModel.ScoreTransform=char([]); 
SVMModel.Alpha=double([]); 
SVMModel.Beta=double([]); 
SVMModel.Bias=double([]); 
SVMModel.KernelParameters=struct([]); 
SVMModel.Mu=double([]); 
SVMModel.Sigma=double([]); 
SVMModel.SupportVectors=double([]); 
SVMModel.SupportVectorLabels=double([]);

SVMModel.ModelParameters.Alpha=double([]); 
SVMModel.ModelParameters.BoxConstraint=double([]); 
SVMModel.ModelParameters.CacheSize=double([]); 
SVMModel.ModelParameters.CachingMethod=char([]); 
SVMModel.ModelParameters.ClipAlphas=logical([]); 
SVMModel.ModelParameters.DeltaGradientTolerance=double([]); 
SVMModel.ModelParameters.Epsilon=double([]); 
SVMModel.ModelParameters.GapTolerance=double([]); 
SVMModel.ModelParameters.KKTTolerance=double([]); 
SVMModel.ModelParameters.IterationLimit=double([]); 
SVMModel.ModelParameters.KernelFunction=char([]); 
SVMModel.ModelParameters.KernelScale=char([]); 
SVMModel.ModelParameters.KernelOffset=double([]); 
SVMModel.ModelParameters.KernelPolynomialOrder=double([]); 
SVMModel.ModelParameters.NumPrint=double([]); 
SVMModel.ModelParameters.Nu=double([]); 
SVMModel.ModelParameters.OutlierFraction=double([]); 
SVMModel.ModelParameters.RemoveDuplicates=logical([]); 
SVMModel.ModelParameters.ShrinkagePeriod=double([]); 
SVMModel.ModelParameters.Solver=char([]); 
SVMModel.ModelParameters.StandardizeData=logical([]); 
SVMModel.ModelParameters.SaveSupportVectors=logical([]); 
SVMModel.ModelParameters.VerbosityLevel=double([]); 
SVMModel.ModelParameters.Version=double([]); 
SVMModel.ModelParameters.Method=char([]); 
SVMModel.ModelParameters.Type=char([]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SVM LOAD INPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('biotech_electric_pretrainSVM_16_05_20.mat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TEST INPUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
blind_data_for_testing_1= double(fopen(fullfile(pwd, 'ml_csv.csv')));
blind_data_for_testing_2 = double(fopen(fullfile(pwd, 'peptides.pfpseaac.csv')));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


blind_data_for_testing_11 = cell(textscan(blind_data_for_testing_1,'%s %s %s %s %s %s %s %s %s','Delimiter',','));
fclose(blind_data_for_testing_1);
list_11 = cell(blind_data_for_testing_11{1,1});
list_12 = cell(blind_data_for_testing_11{1,2});
list_13 = cell(blind_data_for_testing_11{1,3});
list_14 = cell(blind_data_for_testing_11{1,4});
list_15 = cell(blind_data_for_testing_11{1,5});
list_16 = cell(blind_data_for_testing_11{1,6});
list_17 = cell(blind_data_for_testing_11{1,7});
list_18 = cell(blind_data_for_testing_11{1,8});
list_19 = cell(blind_data_for_testing_11{1,9});

blind_trash_11 = {};
blind_idx_11 = double([]);
[blind_trash_11,blind_idx_11] = sort(list_11(2:end));
blind_trash_12 = str2double(list_12(2:end));
blind_trash_13 = str2double(list_13(2:end));
blind_trash_14 = str2double(list_14(2:end));
blind_trash_15 = str2double(list_15(2:end));
blind_trash_16 = str2double(list_16(2:end));
blind_trash_17 = str2double(list_17(2:end));
blind_trash_18 = str2double(list_18(2:end));
blind_trash_19 = str2double(list_19(2:end));
blind_trash_12x = blind_trash_12(blind_idx_11);
blind_trash_13x = blind_trash_13(blind_idx_11);
blind_trash_14x = blind_trash_14(blind_idx_11);
blind_trash_15x = blind_trash_15(blind_idx_11);
blind_trash_16x = blind_trash_16(blind_idx_11);
blind_trash_17x = blind_trash_17(blind_idx_11);
blind_trash_18x = blind_trash_18(blind_idx_11);
blind_trash_19x = blind_trash_19(blind_idx_11);


blind_data_for_testing_21 = cell(textscan(blind_data_for_testing_2,...
    '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s','Delimiter',','));
fclose(blind_data_for_testing_2);
list_21 = cell(blind_data_for_testing_21{1,1});
list_22 = cell(blind_data_for_testing_21{1,2});
list_23 = cell(blind_data_for_testing_21{1,3});
list_24 = cell(blind_data_for_testing_21{1,4});
list_25 = cell(blind_data_for_testing_21{1,5});
list_26 = cell(blind_data_for_testing_21{1,6});
list_27 = cell(blind_data_for_testing_21{1,7});
list_28 = cell(blind_data_for_testing_21{1,8});
list_29 = cell(blind_data_for_testing_21{1,9});
list_210 = cell(blind_data_for_testing_21{1,10});
list_211 = cell(blind_data_for_testing_21{1,11});
list_212 = cell(blind_data_for_testing_21{1,12});
list_213 = cell(blind_data_for_testing_21{1,13});
list_214 = cell(blind_data_for_testing_21{1,14});
list_215 = cell(blind_data_for_testing_21{1,15});
list_216 = cell(blind_data_for_testing_21{1,16});
list_217 = cell(blind_data_for_testing_21{1,17});
list_218 = cell(blind_data_for_testing_21{1,18});
list_219 = cell(blind_data_for_testing_21{1,19});
list_220 = cell(blind_data_for_testing_21{1,20});
list_221 = cell(blind_data_for_testing_21{1,21});
list_222 = cell(blind_data_for_testing_21{1,22});
list_223 = cell(blind_data_for_testing_21{1,23});
list_224 = cell(blind_data_for_testing_21{1,24});

blind_trash_21 = {};
blind_idx_21 = double([]);
[blind_trash_21,blind_idx_21] = sort(list_224);
blind_trash_22 = str2double(list_21(blind_idx_21));
blind_trash_23 = str2double(list_22(blind_idx_21));
blind_trash_24 = str2double(list_23(blind_idx_21));
blind_trash_25 = str2double(list_24(blind_idx_21));
blind_trash_26 = str2double(list_25(blind_idx_21));
blind_trash_27 = str2double(list_26(blind_idx_21));
blind_trash_28 = str2double(list_27(blind_idx_21));
blind_trash_29 = str2double(list_28(blind_idx_21));
blind_trash_210 = str2double(list_29(blind_idx_21));
blind_trash_211 = str2double(list_210(blind_idx_21));
blind_trash_212 = str2double(list_211(blind_idx_21));
blind_trash_213 = str2double(list_212(blind_idx_21));
blind_trash_214 = str2double(list_213(blind_idx_21));
blind_trash_215 = str2double(list_214(blind_idx_21));
blind_trash_216 = str2double(list_215(blind_idx_21));
blind_trash_217 = str2double(list_216(blind_idx_21));
blind_trash_218 = str2double(list_217(blind_idx_21));
blind_trash_219 = str2double(list_218(blind_idx_21));
blind_trash_220 = str2double(list_219(blind_idx_21));
blind_trash_221 = str2double(list_220(blind_idx_21));
blind_trash_222 = str2double(list_221(blind_idx_21));
blind_trash_223 = str2double(list_222(blind_idx_21));
blind_trash_224 = str2double(list_223(blind_idx_21));

blind_data_for_testing = double([blind_trash_22, blind_trash_23, blind_trash_24, blind_trash_25,...
    blind_trash_26,blind_trash_27, blind_trash_28, blind_trash_29, blind_trash_210, blind_trash_211,...
    blind_trash_212, blind_trash_213, blind_trash_214, blind_trash_215,...
    blind_trash_216,blind_trash_217, blind_trash_218, blind_trash_219, blind_trash_220, blind_trash_221,...
    blind_trash_222, blind_trash_223, blind_trash_224,...
    blind_trash_12x, blind_trash_13x, blind_trash_14x, blind_trash_15x, blind_trash_16x, blind_trash_17x,...
    blind_trash_18x, blind_trash_19x]);
[label_test] = char(predict(SVMModel,blind_data_for_testing));
write_out1 = cell(blind_trash_21);
write_out2 = cell(cellstr(label_test));
write_out2 = string(write_out2);
PO = char('PO');
NE = char('NE');
for ii = 1: double(length(write_out2))
    out_PO_list(ii) = logical(strcmp(PO,write_out2(ii)));
end
val_PO = double([]);
idx_PO = double([]);
[val_PO idx_PO]=find(out_PO_list==1);
out_PO_string = string(write_out2([idx_PO]));
out_PO_peptide = cell(write_out1([idx_PO]));
val_NE = double([]);
idx_NE = double([]);
[val_NE idx_NE]=find(out_PO_list~=1);
out_NE_string = string(write_out2([idx_NE]));
out_NE_peptide = cell(write_out1([idx_NE]));
fid = fopen( fullfile(pwd, 'output_peptide.csv'), 'w' );
for jj = 1 : length(out_PO_string)
    fprintf( fid, '%s,%s\n', out_PO_peptide{jj}, out_PO_string{jj} );
end
for jj = 1 : length(out_NE_string)
    fprintf( fid, '%s,%s\n', out_NE_peptide{jj}, out_NE_string{jj} );
end
fclose( fid );
fid2 = fopen( fullfile(pwd, 'positive_peptide.csv'), 'w' );
for jj = 1 : length(out_PO_string)
    fprintf( fid, '%s,%s\n', out_PO_peptide{jj}, out_PO_string{jj} );
end
fclose( fid2 );
