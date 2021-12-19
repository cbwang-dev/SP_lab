function param = gen_fwd_bwd(hmm, features)
%GEN_FWD_BWD Generate forward and backward probability matrix
% inputs: hmm - initialized hmm struct
%         features - feature matrix for one instance. eg. [X 96]
% outputs: param - struct containing forward and backward probability
%          param.alpha - forward probability matrix
%          param.beta - backward probability matrix
%          param.psi - transition probability matrix
%          param.gamma - posterior state distribution matrix
% Comments: 1) if numerical error, change it into log domainn like viterbi_test

  %% initialization
  T=size(features,1); % the length of observed sequence
  init=hmm.init;
  trans=hmm.trans;
  emis=hmm.emis;
  N=hmm.N;
  alpha=zeros(T,N);
  beta=zeros(T,N);
  c=zeros(T,1);
  psi=zeros(T-1,N,N);
  gamma=zeros(T,N);

  %% calculate alpha, forward procedure, slide 3.37
  % calculate initial alphas at t=1 for all states i
  for i=1:N
    alpha(1,i)=init(i)*... % = pi_i
               gen_pdf(features(1,:),emis(i).mean,emis(i).cov); % = b_i(O_1)
  end
  c(1)=1/sum(alpha(1,:));
  alpha(1,:)=alpha(1,:)*c(1);
  for t=2:T % calculate alphas for each time t
    for j=1:N % at each time t calculate alphas for all states j
      temp_alpha=0;
      for i=1:N
        temp_alpha=temp_alpha+alpha(t-1,i)*trans(i,j);
      end
      alpha(t,j)=temp_alpha*...
                 gen_pdf(features(t,:),emis(j).mean,emis(j).cov); % = b_j(O_t)
    end
    c(t)=1/sum(alpha(t,:));
    alpha(t,:)=c(t)*alpha(t,:);
  end

  %% calculate beta, backward procedure, slide 3.39
  % calculate initial betas at t=T for all states i
  for i=1:N
    beta(T,i)=c(T);
  end
  for t=T-1:-1:1 % calculate betas for each time t
    for i=1:N  % at each time t calculate betas for all states i
      temp_beta=0;
      for j=1:N
        temp_beta=temp_beta+beta(t+1,j)*trans(i,j)*...
                  gen_pdf(features(t+1,:),emis(j).mean,emis(j).cov); % = b_j(O_t)
      end
      beta(t,i)=temp_beta;
    end
    beta(t,:)=beta(t,:)*c(t);
  end

  %% calculate psi
  for t=1:T-1
    denorm=sum(alpha(t,:).*beta(t,:));
    for n=1:N-1
      for j=n:n+1
        norm=alpha(t,n)*trans(n,j)*beta(t+1,j)*...
             gen_pdf(features(t+1,:),emis(j).mean,emis(j).cov);
        psi(t,n,j)=c(t)*norm/denorm;
      end
    end  
  end

  %% calculate gamma, posterior state distribution, slide 3.40
  for t=1:T
    alpha_beta=zeros(N,1);
    for i=1:N
      alpha_beta(i)=alpha(tin)*beta(t,i);
    end
    for n=1:N
      gamma(t,i)=alpha_beta(i)/sum(alpha_beta);
    end
  end


  % save the results
  param.c=c; 
  param.alpha=alpha; 
  param.beta=beta; 
  param.psi=psi; 
  param.gamma=gamma;
end



