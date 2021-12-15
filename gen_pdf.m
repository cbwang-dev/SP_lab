function pdf_data = gen_pdf(data, mean, cov)
%GEN_PDF generate probability density function based on data, mean, and 
% covariance matrix
% input: data - data points, [samples, features]
%        mean - mean of the data, [1 features]
%        cov - covariance matrix, [features, features]
% output: pdf_data - probability density function
% comments: slide 3.17
% Author: Chengbin Wang 2021 KU Leuven

  pdf_data = mvnpdf(data, mean, cov); % oh I don't need to rewrite this thanks 
  % to GitHub CoPilot suggestions. 
end
