function [nul,een,twee,drie,vier,vijf,zes,zeven,acht,negen] = preprocess(dataset, flag_save, dir_save)
%PREPROCESS - preprocesses the dataset
% Input: dataset - the dataset to be preprocessed, given in train_layer8.mat or test_layer8.mat
%        flag_save - if "train", save the results in train_$TRANSCRIPT$.mat
%                    if "test", save the results in test_$TRANSCRIPT$.mat
%                    else not save anything (default)
%        dir_save - the prefix of the file to be saved 
%                    (default: '' -> './train_nul.mat')
% Output: preprocessed_dataset - 

  nul=struct();nul.features=[]; een=struct();een.features=[];
  twee=struct();twee.features=[]; drie=struct();drie.features=[];
  vier=struct();vier.features=[]; vijf=struct();vijf.features=[];
  zes=struct();zes.features=[]; zeven=struct();zeven.features=[];
  acht=struct();acht.features=[]; negen=struct();negen.features=[];
  
  num_of_samples = size(dataset, 2);
  for i = 1:num_of_samples
    if strcmp(dataset(i).transcription, 'nul')
      % fprintf("processint %dth sample, which is %s\n", i, dataset(i).transcription);
      if logical(size(getfield(nul,'features'),1))
        nul(end+1).features = dataset(i).features;
      else
        nul(1).features = dataset(i).features;
      end
    elseif strcmp(dataset(i).transcription, 'een')
      % fprintf("processint %dth sample, which is %s\n", i, dataset(i).transcription);
      if logical(size(getfield(een,'features'),1))
        een(end+1).features = dataset(i).features;
      else
        een(1).features = dataset(i).features;
      end
    elseif strcmp(dataset(i).transcription, 'twee')
      % fprintf("processint %dth sample, which is %s\n", i, dataset(i).transcription);
      if logical(size(getfield(twee,'features'),1))
        twee(end+1).features = dataset(i).features;
      else
        twee(1).features = dataset(i).features;
      end
    elseif strcmp(dataset(i).transcription, 'drie')
      % fprintf("processint %dth sample, which is %s\n", i, dataset(i).transcription);
      if logical(size(getfield(drie,'features'),1))
        drie(end+1).features = dataset(i).features;
      else
        drie(1).features = dataset(i).features;
      end
    elseif strcmp(dataset(i).transcription, 'vier')
      % fprintf("processint %dth sample, which is %s\n", i, dataset(i).transcription);
      if logical(size(getfield(vier,'features'),1))
        vier(end+1).features = dataset(i).features;
      else
        vier(1).features = dataset(i).features;
      end
    elseif strcmp(dataset(i).transcription, 'vijf')
      % fprintf("processint %dth sample, which is %s\n", i, dataset(i).transcription);
      if logical(size(getfield(vijf,'features'),1))
        vijf(end+1).features = dataset(i).features;
      else
        vijf(1).features = dataset(i).features;
      end
    elseif strcmp(dataset(i).transcription, 'zes')
      % fprintf("processint %dth sample, which is %s\n", i, dataset(i).transcription);
      if logical(size(getfield(zes,'features'),1))
        zes(end+1).features = dataset(i).features;
      else
        zes(1).features = dataset(i).features;
      end
    elseif strcmp(dataset(i).transcription, 'zeven')
      % fprintf("processint %dth sample, which is %s\n", i, dataset(i).transcription);
      if logical(size(getfield(zeven,'features'),1))
        zeven(end+1).features = dataset(i).features;
      else
        zeven(1).features = dataset(i).features;
      end
    elseif strcmp(dataset(i).transcription, 'acht')
      % fprintf("processint %dth sample, which is %s\n", i, dataset(i).transcription);
      if logical(size(getfield(acht,'features'),1))
        acht(end+1).features = dataset(i).features;
      else
        acht(1).features = dataset(i).features;
      end
    elseif strcmp(dataset(i).transcription, 'negen')
      % fprintf("processint %dth sample, which is %s\n", i, dataset(i).transcription);
      if logical(size(getfield(negen,'features'),1))
        negen(end+1).features = dataset(i).features;
      else
        negen(1).features = dataset(i).features;
      end
    end
  end
  
  if ischar(flag_save)
    save(strcat(dir_save, flag_save, '_', 'nul', '.mat'), 'nul');
    save(strcat(dir_save, flag_save, '_', 'een', '.mat'), 'een');
    save(strcat(dir_save, flag_save, '_', 'twee', '.mat'), 'twee');
    save(strcat(dir_save, flag_save, '_', 'drie', '.mat'), 'drie');
    save(strcat(dir_save, flag_save, '_', 'vier', '.mat'), 'vier');
    save(strcat(dir_save, flag_save, '_', 'vijf', '.mat'), 'vijf');
    save(strcat(dir_save, flag_save, '_', 'zes', '.mat'), 'zes');
    save(strcat(dir_save, flag_save, '_', 'zeven', '.mat'), 'zeven');
    save(strcat(dir_save, flag_save, '_', 'acht', '.mat'), 'acht');
    save(strcat(dir_save, flag_save, '_', 'negen', '.mat'), 'negen');
  end

end