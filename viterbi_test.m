function [probability, query] = viterbi_test(data, hmm, verbose)
%VITERBI_TEST conduct inference on speech features
% inputs: data - a single speech feature vector, observations, size [T features]
%         hmm - a hmm model, struct (not cell)
%         verbose - a flag to print out the results
% outputs: probability - the probability of the data given the model, scalar
%          query - the most likely sequence of states 
% Author: Chengbin Wang 2021 KU Leuven
% Comments: information can be found in slide 5.14
  if iscell(hmm)
    fprintf('viterbi_test: error hmm is a cell, not a struct\n');
  end
  if verbose
    fprintf("viterbi_test: #utterances: %d, feature: %d\n", length(data), length(data(1).features));
  end
  
  %% step 1: initialization. 
  % Use hard copy to prevent from modifing the original hmm model
  init = hmm.init; % initial state distribution
  trans = hmm.trans; % transition probability matrix
  emis = hmm.emis; % emission related parameters, mean and covariance
  N = hmm.N; % number of states
  T = zeros(1,length(data));
  for i=1:length(data)
    T(i)=size(data(i).features,1);
  end % number of frames in each observation

  %% calculate log(init)
  ind1=find(init>0);
  ind0=find(init<=0);
  init(ind1)=log(init(ind1));
  init(ind0)=-inf;

  %% calculate log(trans)
  ind1 = find(trans>0);
  ind0 = find(trans<=0);
  trans(ind1) = log(trans(ind1));
  trans(ind0) = -inf;
  prob=zeros(1,length(data));
  for i=1:length(data)
    delta = zeros(T(i),N);
    psi = zeros(T(i),N);
    q = zeros(T(i),1);

    for j=1:N
      delta(1,j)=init(j)+...
      log(gen_pdf(data(i).features(1,:),emis(j).mean,emis(j).cov));
    end
    for t=2:T(i)
      for j=1:N
        [delta(t,j),psi(t,j)]=max(delta(t-1,:)+trans(:,j)');
        delta(t,j)=delta(t,j)+...
        log(gen_pdf(data(i).features(t,:),emis(j).mean,emis(j).cov));
      end
    end
    [prob(i) q(T(i))]=max(delta(T(i),:)); % most likely model, slide 3.33
    % choose the most probable model that generate the observations
    for t=T(i)-1:-1:1
      q(t)=psi(t+1,q(t+1));
    end
  end
  probability=mean(prob);
  fprintf("the average probability is %.2f\n",probability);
end