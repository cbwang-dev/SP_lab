function trained_hmm = hmm_train(data,initialized_hmm,verbose,epochs,converge_prob_diff,name_save_hmm,flag_save_hmm)
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

  trained_hmm=initialized_hmm; 
  prob_epochs=zeros(epochs+1,1); % store viterbi probability for each epoch
  prob_epochs(1)=viterbi_test(data,trained_hmm);
  if verbose
    fprintf('hmm_train: epoch 0, probability is %.3f.\n',prob_epochs(1));
  end
  for index_epoch=1:epochs
    old_hmm=trained_hmm;
    new_hmm=viterbi_train(data,old_hmm);
    
    prob_epochs(index_epoch+1)=viterbi_test(data,new_hmm);
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
        trained_hmm=new_hmm;
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
    trained_hmm=new_hmm;
    if flag_save_hmm
        save(name_save_hmm,'trained_hmm');
        fprintf('hmm_train: trained HMM saved to %s.\n',name_save_hmm);
    if index_epoch==epochs
      if verbose
        fprintf('hmm_train: all epochs reached. consider adding more epochs.\n');
      end
    end
  end
end
