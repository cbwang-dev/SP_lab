% load this matlab file before executing the code

%% HMM structure related parameters
N = 4; % number of states in HMM
M = repmat(2,1,N); % number of probability density functions in each state, default 3 per state
% transition probabilities, not re-estimated
trans_stay = 0.9; % from state i to state i
trans_next = 0.1; % from state i to state i+1

%% Viterbi related parameters

%% name and flags for saving intermediate results and plots