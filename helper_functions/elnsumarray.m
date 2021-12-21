function res = elnsumarray(elems)
%ELNSUM Extended logarithm sum
%   The extended logarithm sum function computes the extended
%   logarithm of the sum of x and y given as inputs the extended logarithm of x and y,
%   and is defined as follows.
    
    if length(elems)==2
        res = elnsum(elems(1), elems(2));
    else
        x = elems(1);
        y = elnsumarray(elems(2:end));
        res = elnsum(x,y);
    end
   
end

