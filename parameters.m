% load this matlab file before executing the code
% ------------------------ main test parameters ---------------------------
flag_test_digit = 'nul'; % choose from 'nul' to 'negen'
verbose = true; % print additional information if true
% name and flags for saving intermediate results and plots
flag_save_hmm = false; % save the hmm model when true
name_save_hmm = './setup/hmm.mat'; % name of the hmm model file
dir_save_dataset = './setup/'; % prefix, eg './setup/train_een.mat'
train_iterations = 40; % number of iterations for training
% LUT for names: digits, dir_train_data, dir_test_data.
digits = ["nul","een","twee","drie","vier","vijf","zes","zeven","acht","negen"];
dir_train_data = {'./setup/train_nul.mat','./setup/train_een.mat', ...
                  './setup/train_twee.mat','./setup/train_drie.mat', ...
                  './setup/train_vier.mat','./setup/train_vijf.mat', ...
                  './setup/train_zes.mat','./setup/train_zeven.mat', ...
                  './setup/train_acht.mat','./setup/train_negen.mat'};
dir_test_data = {'./setup/test_nul.mat','./setup/test_een.mat', ...
                 './setup/test_twee.mat','./setup/test_drie.mat', ...
                 './setup/test_vier.mat','./setup/test_vijf.mat', ...
                 './setup/test_zes.mat','./setup/test_zeven.mat', ...
                 './setup/test_acht.mat','./setup/test_negen.mat'};
                 
% ---------------------- HMM structure related parameters --------------------
N = [3,2,3,3,3,4,3,5,3,5]; % number of states in HMMs for each digit (een-negen)
% regarding to the pronunciations denoted in the assignments. This setup is 
% needed to be examined whether useful. CAN BE CHANGED.
M = 1; % number of gaussian mixtures in each state, default 1
% Assume that the number of GMM in each state is the same. This assumption is 
% valid in this assignment setup. If GMM is used, then this is to be modified. 
% I left this option in the code in order to modify this code as a GMM version
% if time permits.
% transition probabilities, not re-estimated
trans_stay=[0.9,0.9,0.9,0.9,0.9,0.9,0.9,0.9,0.9,0.9]; % from state i to state i
trans_next=[0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1]; % from state i to state i+1


%% Viterbi related parameters
% training
epochs=40; % maximum training epochs. 
converge_prob_diff = 5e-4; % convergence criteria