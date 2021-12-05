function hmm = hmm_init(samples, N, M, trans_stay, trans_next, verbose)
%HMM_INIT Generate a HMM with given parameters.
% Input: feature - the feature sample for a dedicated digit
%        N - number of states
%        M - number of gaussian mixtures in emission model
%        trans_stay - transition probability from state i to i
%        trans_next - transition probability from state i to i+1
%        verbose - print additioanl information if true
% Output: hmm - the generated HMM model, MATLAB struct
%           hmm.N - number of hidden states
%           hmm.M - number of aussian mixtures in emission model
%           hmm.init - initial transition probability $pi$
%           hmm.trans - initial transition probability matrix
%           hmm.emission - initial observation probability
%             hmm.mix.M
%             hmm.mix.mean
%             hmm.mix.var
%             hmm.mix.weight
% Comments:
% 1) M - for this assignment, the emission model is a single Gaussian 
%    with diagonal covariance, so M = 1 for each state. So the default
%    value of M is 1 for each state.
% 2) By default, the HMM is a left-to-right model without skips, as 
%    described in the assignment.
% Author: Chengbin Wang@2021

  if sum(M)/N == 1
    fprintf('hmm_init: emission model is simple Gaussian\n');
  end

  hmm.N = N;
  hmm.M = M;

  hmm.init=zeros(N,1);
  hmm.init(1)=1;

  %% initializing state transition probability matrix
  hmm.trans=zeros(N,N);
  for i=1:N-1
    hmm.trans(i,i)  =trans_stay;
    hmm.trans(i,i+1)=trans_next;
  end
  hmm.trans(N,N)=1;

  %% initializing emission probability
  K = length(samples); % number of samples
  for k=1:K
    T=size(samples(k).features,1);
    samples(k).segment=floor([1:T/N:T T+1]);
  end

  for i=1:N
    vector=[];
    for k=1:K
        seg1=samples(k).segment(i);
        seg2=samples(k).segment(i+1)-1;
        vector=[vector;samples(k).features(seg1:seg2,:)];
    end
    mix(i)=gen_mixture(vector,M(i)); %调用getmix函数，返回结构体mix(i)
  end

  hmm.mix=mix;
end
