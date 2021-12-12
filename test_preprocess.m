clear;
parameters
% flag_save_dataset = 'train'; load train_layer8.mat
flag_save_dataset = 'test'; load test_layer8.mat
fprintf("test_preprocess: number of samples in the dataset is %d.\n", length(data));

% calculate number of samples in each class before processing
count_transcription = zeros(1,10);
for i=1:length(data)
  if strcmp(data(i).transcription, 'nul')
    count_transcription(1) = count_transcription(1) + 1;
  elseif strcmp(data(i).transcription, 'een')
    count_transcription(2) = count_transcription(2) + 1;
  elseif strcmp(data(i).transcription, 'twee')
    count_transcription(3) = count_transcription(3) + 1;
  elseif strcmp(data(i).transcription, 'drie')
    count_transcription(4) = count_transcription(4) + 1;
  elseif strcmp(data(i).transcription, 'vier')
    count_transcription(5) = count_transcription(5) + 1;
  elseif strcmp(data(i).transcription, 'vijf')
    count_transcription(6) = count_transcription(6) + 1;
  elseif strcmp(data(i).transcription, 'zes')
    count_transcription(7) = count_transcription(7) + 1;
  elseif strcmp(data(i).transcription, 'zeven')
    count_transcription(8) = count_transcription(8) + 1;
  elseif strcmp(data(i).transcription, 'acht')
    count_transcription(9) = count_transcription(9) + 1;
  elseif strcmp(data(i).transcription, 'negen')
    count_transcription(10) = count_transcription(10) + 1;
  else
    fprintf("test_preprocess: unknown transcription %s.\n", data(i).transcription);
  end
end

[nul,een,twee,drie,vier,vijf,zes,zeven,acht,negen] = preprocess(data, flag_save_dataset, dir_save_dataset);
% preprocess(data, flag_save_dataset, dir_save_dataset);

fprintf("test_preprocess: before preprocessing, class 'nul' has %d samples.\n",   count_transcription(1));
fprintf("test_preprocess: after  preprocessing, class 'nul' has %d samples.\n",   length(nul));
fprintf("test_preprocess: before preprocessing, class 'een' has %d samples.\n",   count_transcription(2));
fprintf("test_preprocess: after  preprocessing, class 'een' has %d samples.\n",   length(een));
fprintf("test_preprocess: before preprocessing, class 'twee' has %d samples.\n",  count_transcription(3));
fprintf("test_preprocess: after  preprocessing, class 'twee' has %d samples.\n",  length(twee));
fprintf("test_preprocess: before preprocessing, class 'drie' has %d samples.\n",  count_transcription(4));
fprintf("test_preprocess: after  preprocessing, class 'drie' has %d samples.\n",  length(drie));
fprintf("test_preprocess: before preprocessing, class 'vier' has %d samples.\n",  count_transcription(5));
fprintf("test_preprocess: after  preprocessing, class 'vier' has %d samples.\n",  length(vier));
fprintf("test_preprocess: before preprocessing, class 'vijf' has %d samples.\n",  count_transcription(6));
fprintf("test_preprocess: after  preprocessing, class 'vijf' has %d samples.\n",  length(vijf));
fprintf("test_preprocess: before preprocessing, class 'zes' has %d samples.\n",   count_transcription(7));
fprintf("test_preprocess: after  preprocessing, class 'zes' has %d samples.\n",   length(zes));
fprintf("test_preprocess: before preprocessing, class 'zeven' has %d samples.\n", count_transcription(8));
fprintf("test_preprocess: after  preprocessing, class 'zeven' has %d samples.\n", length(zeven));
fprintf("test_preprocess: before preprocessing, class 'acht' has %d samples.\n",  count_transcription(9));
fprintf("test_preprocess: after  preprocessing, class 'acht' has %d samples.\n",  length(acht));
fprintf("test_preprocess: before preprocessing, class 'negen' has %d samples.\n", count_transcription(10));
fprintf("test_preprocess: after  preprocessing, class 'negen' has %d samples.\n", length(negen));