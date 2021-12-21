function [probability, query] = viterbi_test_bonus(data, hmm, verbose)
%VITERBI_TEST conduct inference on speech features
% inputs: data - a single speech feature vector, observations, size [T features]
%         hmm - a hmm model, struct (not cell)
%         verbose - a flag to print out the results
% outputs: probability - the probability of the data given the model, scalar
%          query - the most likely sequence of states
% Comments: information can be found in slide 5.14
  global phonemes;
  if iscell(hmm)
    fprintf('viterbi_test: error hmm is a cell, not a struct\n');
  end
  if verbose
    fprintf("viterbi_test: #utterances: %d, feature: %d\n", ...
            length(data), length(data(1).features));
  end
  
  %% step 1: initialization. 
  % Use hard copy to prevent from modifing the original hmm model
  init = hmm.init; % initial state distribution
  trans = hmm.trans; % transition probability matrix
  emis.mean = [];
  emis.cov = [];
  counter = 1;
  for i=1:numel(hmm.phonemes)
    for j=1:3
        mu = phonemes.(hmm.phonemes(i)).mean;
        cov = phonemes.(hmm.phonemes(i)).cov;
        emis(counter).mean = mu;
        emis(counter).cov = cov;
        counter = counter+1;

    end
  end
  
  N = hmm.N; % number of states
  T = zeros(1,length(data));
  for i=1:length(data)
    T(i)=size(data(i).features,1);
  end % number of frames in each observation

  %% calculate log(init)
  % after log, the multiplication can be described in addition.
  ind1=find(init>0);
  ind0=find(init<=0);
  init(ind1)=log(init(ind1));
  init(ind0)=-inf;

  %% calculate log(trans)
  % after log, the multiplication can be described in addition.
  % keep notation the same as slide 5.14
  ind1 = find(trans>0);
  ind0 = find(trans<=0);
  trans(ind1) = log(trans(ind1));
  trans(ind0) = -inf;
  prob=zeros(1,length(data));
  for i=1:length(data)
    % psi: for state n in time t, document the biggest probability
    psi = zeros(T(i),N);
    % PSI: the index of the transition which has the biggest probability
    PSI = zeros(T(i),N);
    q = zeros(T(i),1);

    for n=1:N % initialization of psi when t=1, slide 5.14
      psi(1,n)=init(n)+...
      gen_log_pdf(data(i).features(1,:),emis(n).mean,emis(n).cov);
    end
    for t=2:T(i) % recursion, slide 5.14
      for n=1:N
        [psi(t,n),PSI(t,n)]=max(psi(t-1,:)+trans(:,n)');
        psi(t,n)=psi(t,n)+...
        gen_log_pdf(data(i).features(t,:),emis(n).mean,emis(n).cov);
      end
    end
    [prob(i), q(T(i))]=max(psi(T(i),:)); % termination, slide 5.14
    % choose the most probable model that generate the observations
    for t=T(i)-1:-1:1
      q(t)=PSI(t+1,q(t+1));
    end
  end
  probability=mean(prob);
  query=q;
  if verbose
    fprintf("the average probability is %.2f\n",probability);
  end
end