function res = elnsum(x,y)
%ELNSUM Extended logarithm sum
%   The extended logarithm sum function computes the extended
%   logarithm of the sum of x and y given as inputs the extended logarithm of x and y,
%   and is defined as follows.
    
    if isnan(eln(x)) || isnan(eln(y))
        if isnan(eln(x))
            res = eln(y);
        else
            res = eln(x);
        end
    
    else
        if eln(x)>eln(y)
            res = eln(x) + eln(1+exp(eln(y)-eln(x)));
        else
            res = eln(y) + eln(1+exp(eln(x)-eln(y)));
        end
    end 
end

