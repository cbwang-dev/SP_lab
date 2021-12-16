function hmm = hmm_init(samples, N, M, trans_stay, trans_next, verbose)
%HMM_INIT Generate a HMM with given parameters.
% Input: feature - the feature sample for a dedicated digit
%        N - number of states, integer
%        M - number of gaussian mixtures in emission model. Default: [1]*N
%        trans_stay - transition probability from state i to i
%        trans_next - transition probability from state i to i+1
%        verbose - print additional information if true
% Output: hmm - the generated HMM model, MATLAB struct
%           hmm.N - number of hidden states
%           hmm.M - number of Gaussian mixtures in emission model
%           hmm.init - initial transition probability matrix $\pi$
%           hmm.trans - initial transition probability matrix $a_{ij}$
%           hmm.emis - initial emission probability $b_i(x)$, with index i=1:N
%             hmm.emis{i}.mean - mean vector of the pdf in the i-th layer
%             hmm.emis{i}.cov - covariance matrix in the i-th layer
% Comments:
% 1) emission model - for this assignment, the emission model is a single 
%    Gaussian with diagonal covariance (by default). 
% 2) By default, the HMM is a left-to-right model without skips, as described in
%    the assignment.
% 3) Several methods for initializing emission probability are evaluated. TODO
% 4) The transition probabilities (stay and next) are fixed as described in the 
%    assignment. 
% Author: Chengbin Wang 2021 KU Leuven

  hmm.N = N;
  hmm.M = M; 

  hmm.init=zeros(N,1); % $\pi_i$ slide 3.8. because this is a left-to-right HMM, the 
  % initial state is always the first state.
  hmm.init(1)=1; % always start in the first state

  %% initializing state transition probability matrix, slide 3.8
  hmm.trans=zeros(N,N);
  for i=1:N-1
    hmm.trans(i,i)  =trans_stay;
    hmm.trans(i,i+1)=trans_next;
  end
  hmm.trans(N,N)=1; % 100% transfer to last state if at the last state

  %% initializing emission probability $b_i(x)=f(x|q_t=i)$, slide 3.8
  % first truncate each sample into N parts, to estimate emission probabilities 
  % in each state. NOTE the truncation part can be motivated. Here the samples
  % are truncated into N parts whose length is roughly the same. If time is not
  % limited, we can try to use different length regarding to phonemes.
  K = length(samples); % number of samples
  for k=1:K
    T=size(samples(k).features,1); % number of frames in one sample
    samples(k).segment=floor([1:T/N:T T+1]);
  end
 if verbose
    fprintf('hmm_init: HMM model generated, details below:\n');
    fprintf("          number of states: %d;\n", N);
    fprintf("          trans a_{i,i}   : %.2f;\n", trans_stay);
    fprintf("          trans a_{i,i+1} : %.2f;\n", trans_next);
  end
  for i=1:N
    vector=[];
    for k=1:K % for each state, get all the samples in the state-constrained set
      seg1=samples(k).segment(i);
      seg2=samples(k).segment(i+1)-1;
      vector=[vector;samples(k).features(seg1:seg2,:)];
    end
    if verbose
      fprintf('          state %d, use (%d,%d) to calculate emission probability.\n',...
              i,size(vector,1),size(vector,2));
    end
    emis(i)=gen_gaussian(vector,verbose); 
  end
  hmm.emis=emis;
end
