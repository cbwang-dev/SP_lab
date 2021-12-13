function emis = gen_gaussian(vector,verbose)
%GEN_GAUSSIAN Generate a multivariate Gaussian distribution for emission 
%             probability. Covariance matrix is diagonal (assignment).
% input: vector - feature vector, with [samples features] as dimension. 
%                 [samples features] is the size of the input vector.
%        verbose - true to print more information
% output: emis - emission probability structure
%         emis.mean - mean of the Gaussian distribution
%         emis.cov - covariance of the Gaussian distribution
% Author: Chengbin Wang 2021 KU Leuven
  if verbose
    % fprintf('gen_gaussian: input size is (%d,%d)\n', size(vector));
  end
  % for each feature, generate a Gaussian distribution. 
  emis.mean=1;
  emis.cov=1;
end