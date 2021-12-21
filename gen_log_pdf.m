function pdf_data = gen_log_pdf(x, mean, cov)
%GEN_PDF generate probability density function based on data, mean, and 
% covariance matrix
% input: data - data point, [1, features]
%        mean - mean of the data, [1 features]
%        cov - covariance matrix, [features, features]
% output: pdf_data - probability density function
% comments: slide 3.17
% Author: Chengbin Wang 2021 KU Leuven
  
    D = size(x,2);
    detSigma = det(cov);
    
    fac1 = 1 / ((2*pi)^(D/2)*sqrt(detSigma));
    exponent = -1/2 * (x-mean) * inv(cov) * (x-mean)';
    pdf_data = log(fac1) + exponent;
  
end
