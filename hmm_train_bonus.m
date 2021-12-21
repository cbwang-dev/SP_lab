function trained_hmm = hmm_train_bonus(data,initialized_hmm,verbose,epochs,converge_prob_diff,name_save_hmm,flag_save_hmm)
%HMM_TRAIN Trains a HMM using Viterbi algorithm.
% input: data - a cell array of sequences, each sequence is a column vector
%        initialized_hmm - a HMM structure with initialized parameters
%        verbose - a boolean variable to indicate whether to print the
%                  information about the training process
%        epochs - the number of epochs to train the HMM
%        converge_prob_diff - the convergence threshold for the probability
%                             difference between two consecutive epochs
%        name_save_hmm - the name of the file to save the trained HMM
%        flag_save_hmm - a boolean variable to indicate whether to save the
% output: trained_hmm - the trained HMM
  global phonemes;
  diagonal = 0; % use diagonal (1) or full (0) covariance matrix;

  trained_hmm=initialized_hmm; 
  prob_epochs=zeros(epochs+1,1); % store viterbi probability for each epoch
  prob_epochs(1)=viterbi_test_bonus(data,trained_hmm,verbose);
  if verbose
    fprintf('hmm_train: epoch 0, probability is %.3f.\n',prob_epochs(1));
  end

  N=initialized_hmm.N;
  U=length(data);
  nb_features = size(data(1).features,2);
  for index_epoch=1:epochs
    old_hmm=trained_hmm;

    %%%%%%%%%%%%%%%%%%
    %% HMM training %%
    %%%%%%%%%%%%%%%%%%

    mu = zeros(N, nb_features);
    if diagonal
        sigma = zeros(nb_features, 1); % vector representing diagonal elements of covariance matrix -> we assume diagonal covariance matrix
    else
        sigma = zeros(nb_features);
    end

    for p=1:numel(trained_hmm.phonemes) % p is phoneme index
        phoneme_char = old_hmm.phonemes(p);
        for i=1:3 % i is state index for each phoneme
            mu_temp = 0;
            sigma_temp = 0;
            normalization = 0;
            for u=1:U
                T = size(data(u).features, 1);
                d.features = data(u).features;
                [~, q_opt] = viterbi_test_bonus(d, trained_hmm, 0);
                time = 1:T;
                for t = time(q_opt==i) % loop only over times where state i is the most likely state
                    o = data(u).features(t, :);
                  
                    % estimate mu
                    mu_temp = mu_temp + o;
    
                    % estimate sigma
                    mu_i =  phonemes.(phoneme_char)(i).mean;
                    if diagonal
                        sigma_temp = sigma_temp + (o-mu_i).^2;
                    else
                        sigma_temp = sigma_temp + (o-mu_i)'*(o-mu_i);
                    end
                end
                normalization = normalization + sum(q_opt==i);
            end
    
            mu(i,:) = mu_temp / normalization;
            sigma(:,:,i) = sigma_temp / normalization;
        end

        % adjust mean and cov for this phoneme
        for i=1:3
            phonemes.(phoneme_char)(i).mean = mu(i, :);
            if diagonal
               phonemes.(phoneme_char)(i).cov = diag(sigma(:,:,i));
            else
               phonemes.(phoneme_char)(i).cov = sigma(:,:,i);
            end
        end
    end

   
    prob_epochs(index_epoch+1)=viterbi_test_bonus(data,trained_hmm,verbose);
    if verbose
      fprintf('hmm_train: epoch %d, probability is %.3f.\n',...
              index_epoch,prob_epochs(index_epoch+1));
    end

    % stop training criterias
    if index_epoch>2
      if abs(prob_epochs(index_epoch+1)-prob_epochs(index_epoch))/...
        prob_epochs(index_epoch+1)<converge_prob_diff
        if verbose
          fprintf('hmm_train: convergence reached in epoch %d.\n', ...
                  index_epoch);
        end
        if flag_save_hmm
          save(name_save_hmm,'trained_hmm');
          fprintf('hmm_train: trained HMM saved to %s.\n',name_save_hmm);
        end
        break;
      end
    end
    if prob_epochs(index_epoch+1)==0
      if verbose
        fprintf('hmm_train: probability is low in epoch %d. return model in epoch %d.\n',...
                index_epoch,index_epoch-1);
      end
      trained_hmm=old_hmm;
      if flag_save_hmm
        save(name_save_hmm,'trained_hmm');
        fprintf('hmm_train: trained HMM saved to %s.\n',name_save_hmm);
      end
      break;
    end
    if flag_save_hmm
      save(name_save_hmm,'trained_hmm');
      fprintf('hmm_train: trained HMM saved to %s.\n',name_save_hmm);
    end
    if index_epoch==epochs
      if verbose
        fprintf('hmm_train: all epochs reached. consider adding more epochs.\n');
      end
    end
  end
end
