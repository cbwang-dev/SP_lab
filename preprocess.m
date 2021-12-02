function [nul, een, twee, drie, vier, vijf, zes, zeven, acht, negen] = preprocess(dataset, flag_save=0)
%PREPROCESS - preprocesses the dataset
% Input: dataset - the dataset to be preprocessed, given in train_layer8.mat or test_layer8.mat
%        flag_save - if "train", save the results in train_$TRANSCRIPTION$.mat
%                    if "test", save the results in test_$TRANSCRIPTION$.mat
%                    else not save anything (default)
% Output: nul - the dataset contained only "nul"
%         een - the dataset contained only "een"
%         twee - the dataset contained only "twee"
%         drie - the dataset contained only "drie"
%         vier - the dataset contained only "vier"
%         vijf - the dataset contained only "vijf"
%         zes - the dataset contained only "zes"
%         zeven - the dataset contained only "zeven"
%         acht - the dataset contained only "acht"
%         negen - the dataset contained only "negen"

num_of_samples = size(dataset, 2);
for i = 1:num_of_samples
  if dataset(i).transcription == 'nul'
    
  end
end