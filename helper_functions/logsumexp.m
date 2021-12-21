function [lse,sm] = logsumexp(x)
%LOGSUMEXP  Log-sum-exp function.
%    lse = LOGSUMEXP(x) returns the log-sum-exp function evaluated at 
%    the vector x, defined by lse = log(sum(exp(x)).
%    [lse,sm] = LOGSUMEXP(x) also returns the softmax function evaluated
%    at x, defined by sm = exp(x)/sum(exp(x)).
%    The functions are computed in a way that avoids overflow and 
%    optimizes numerical stability.   

%    Reference:
%    P. Blanchard, D. J. Higham, and N. J. Higham.  
%    Accurately computing the log-sum-exp and softmax functions. 
%    IMA J. Numer. Anal., Advance access, 2020.
% 
% Source: https://github.com/higham/logsumexp-softmax/blob/master/logsumexp.m

if ~isvector(x), error('Input x must be a vector.'), end

%%
%Matko modification - if all exponents are -Inf, total sum is log(0)=-Inf
if sum(isinf(x)) == length(x)
    lse = -Inf;
    sm=NaN;
    return
end
%%
n = length(x);
s = 0; e = zeros(n,1);
[xmax,k] = max(x); a = xmax;
s = 0;
for i = 1:n
    e(i) = exp(x(i)-xmax);
    if i ~= k
       s = s + e(i);
    end   
end
lse = a + log1p(s);
if nargout > 1
   sm = e/(1+s);
end   
