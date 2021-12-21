function res = eexp(x)
%EEXP Extended exponential function
%   The extended exponential function is the standard exponential function e(x),
%   except that it is extended to handle log zero, and is defined as follows.
    if isnan(x)
        res = 0;
    else
        res = exp(x);
    end
end

