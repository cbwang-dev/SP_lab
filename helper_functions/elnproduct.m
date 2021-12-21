function res = elnproduct(x,y)
%ELNPRODUCT Extended logarithm product
%   The extended logarithm product function returns the
%   logarithm of the product of x and y.
    
    if isnan(eln(x)) || isnan(eln(y))
        res = NaN;
    else
        res = eln(x) + ln(y);
    end
end

