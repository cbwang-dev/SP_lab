function hmm = hmm_init_bonus(data, digit, trans_stay, trans_next, verbose)
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
  global digits;
  global phonemes;
 
  hmm.digit=digit; %string
  hmm.phonemes = digits.(digit);
  hmm.N = 3*length(hmm.phonemes);
  N = hmm.N;

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
  % first truncate each utterance into N parts, to estimate emission probabilities 
  % in each state. NOTE the truncation part can be motivated. Here the
  % utterances are truncated into N parts whose length is roughly the same. If time is not
  % limited, we can try to use different length regarding to phonemes.
  U = length(data); % number of utterances
  for u=1:U
    T=size(data(u).features,1); % number of frames in one utterance
    data(u).segment=floor([1:T/N:T T+1]);
  end
 if verbose
    fprintf('hmm_init: HMM model generated, details below:\n');
    fprintf("          number of states: %d;\n", N);
    fprintf("          trans a_{i,i}   : %.2f;\n", trans_stay);
    fprintf("          trans a_{i,i+1} : %.2f;\n", trans_next);
 end
  
  segment_counter = 0;
  for i=1:numel(hmm.phonemes)
      segment_counter = segment_counter + 1;
      phoneme_char = hmm.phonemes(i);
    if size(phonemes.(phoneme_char).mean,1) == 0
        for j=1:3
            vector=[];
            for u=1:U % for each utterance u, get all the samples in the state i
              seg1=data(u).segment(segment_counter);
              seg2=data(u).segment(segment_counter+1)-1;
              vector=[vector;data(u).features(seg1:seg2,:)];
            end
            emis =gen_gaussian(vector,verbose); 
            phonemes.(phoneme_char)(j).mean = emis.mean;
            phonemes.(phoneme_char)(j).cov = emis.cov;
        end
    end
  end
%   hmm.emis=emis;
end
