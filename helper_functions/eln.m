function res= eln(x)
%ELN Extended logarithm function
%   The extended logarithm is the standard logarithm provided by most floating
%   point math libraries, except that it is extended to handle inputs of zero, and is defined
%   as follows.outputArg1 = inputArg1;
    if x==0
        res=NaN;
    elseif x>0
        res=log(x);
    else
        disp("x="+x);
        error("Error in eln");
    end
end

