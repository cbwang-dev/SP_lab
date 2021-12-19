% Author: Chengbin Wang 2021 KU Leuven
clear;
% clc;
fprintf('=============== preprocessing and sanity check ==============\n');
%% check whether the files `test_layer8.mat` and `train_layer8.mat` exist in root
if ~(isfile('test_layer8.mat') && isfile('train_layer8.mat'))
  fprintf("main: NO DATA, please put the files `test_layer8.mat` and `train_layer8.mat` in the root folder\n");
  return;
else
  fprintf("main: `test_layer8.mat` and `train_layer8.mat` are in the root folder.\n");
end

%% check whether the data is partitioned
parameters % initialize parameters
if ~isfolder('setup')
  mkdir('setup');
end
if ~isfile('./setup/train_nul.mat')
  fprintf("main: training data not partitioned, please wait...\n");
  flag_save_dataset = 'train'; load train_layer8.mat;
  preprocess(data, flag_save_dataset, dir_save_dataset);
else
  fprintf("main: training data partitioned.\n");
end
if ~isfile('./setup/test_nul.mat')
  fprintf("main: test data not partitioned, please wait...\n");
  flag_save_dataset = 'test'; load test_layer8.mat;
  preprocess(data, flag_save_dataset, dir_save_dataset);
else
  fprintf("main: test data partitioned.\n");
end

%% train 10 HMMs for each digit
fprintf('============================= train ========================\n');
for i=1:length(digits)
  load(dir_train_data{i});
  if verbose
    fprintf("main: initializing HMM for digit '%s'.\n", digits(i));
    fprintf("main: %d pieces of data for digit '%s'.\n", length(data), digits(i));
  end
  initialized_hmm = hmm_init(data, N(i), M, trans_stay(i), trans_next(i), verbose);
  fprintf("main: training HMM for digit '%s'.\n", digits(i));
  hmm{i} = hmm_train(data,initialized_hmm,verbose,epochs,converge_prob_diff,name_save_hmm,flag_save_hmm); 
  return
  fprintf('============= finish training HMM for digit %s =============\n', digits(i));
end
fprintf("main: finish training 10 HMMs.\n");

%% test the HMM ensemble on test set
fprintf('========================= test =============================\n');
result_by_digit=zeros(1,10);
for index_digit=1:length(digits)
  temp_right_prediction=0;
  load(dir_test_data{index_digit}); % data
  temp_overall_prediction=length(data);
  for index_sample_in_data=1:length(data)
    prob=zeros(1,length(digits));
    for index_model=1:length(digits)
      prob(index_model) = viterbi_test(data(index_sample_in_data),hmm{index_model});
    end
    [~,n] = max(prob);
    if n==index_digit
      temp_right_prediction=temp_right_prediction+1;
    end
  end
  result_by_digit(index_digit)=temp_right_prediction/temp_overall_prediction;
  fprintf("main: test accuracy on digit '%s' is\t%.3f (%d/%d).\n", ...
          digits(index_digit), result_by_digit(index_digit), ...
          temp_right_prediction, temp_overall_prediction);
end
fprintf('============================================================\n');
fprintf("main: test accuracy on all digits is\t%.3f.\n", mean(result_by_digit));
fprintf("main: finish testing HMM ensemble.\n");