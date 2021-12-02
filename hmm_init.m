function hmm = hmm_init(obs, N, M)
%HMM_INIT Generate a HMM with given parameters.
% Input:
% Output: hmm - the generated HMM model
%           hmm.N - number of hidden states
%           hmm.M - number of observation symbols
%           hmm.init - initial state probability $pi$
%           hmm.trans - initial state transition probability matrix
%           hmm.mix - initial observation probability
%             hmm.mix.M
%             hmm.mix.mean
%             hmm.mix.var
%             hmm.mix.weight
