% load this matlab file before executing the code

% -------------------------------------------------------------------------
% ------------------------ main test parameters ---------------------------
% -------------------------------------------------------------------------
flag_test_digit = 'nul'; % choose from 'nul' to 'negen'
verbose = true; % print additional information if true
% name and flags for saving intermediate results and plots
flag_save_hmm = false; % save the hmm model when true
name_save_hmm = './setup/hmm.mat'; % name of the hmm model file
flag_save_dataset = 'test'; % 0, 'train' or 'test'
dir_save_dataset = './setup/'; % prefix, eg './setup/train_een.mat'
% -------------------------------------------------------------------------
% ------------------------ for digit 'nul' --------------------------------
% -------------------------------------------------------------------------
%% HMM structure related parameters
N = 4; % number of states in HMM
M = repmat(1,1,N); % number of gaussian mixtures in each state, default 1
% transition probabilities, not re-estimated
trans_stay = 0.9; % from state i to state i
trans_next = 0.1; % from state i to state i+1

%% Viterbi related parameters




