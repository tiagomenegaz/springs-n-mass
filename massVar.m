function [ res ] = massVar(mL1, mL2, ks, rs, startx, d, c, tinc, atol, vtol)
%MASSVAR This function shows the difference between mass variations in a
%simple harmonic motion
%   DESCRIPTION

%   Error checking
if errorChecking(mL1, mL2) == 0
    %   Assigning mass ranges
    if mL1 < mL2
        rMin = mL1;
        rMax = mL2;
    else
        rMin = mL2;
        rMax = mL1;
    end
    
    %   Define return variable
    res     = zeros(1,4);
    
    %   Define graph size
    xMin    = 4;
    xMax    = 18;
    yMin    = 0;
    yMax    = 40;
    
    %   Add values to res
    res(4)  = rMin;
    res(3)  = res(4) + res(4)/3;
    res(2)  = res(3) + res(4)/3;
    res(1)  = rMax;
    
    %   Create four plots
    for  index = 4:-1:1
        % TODO res(X)
        [x, t] = spring(ks, rs, startx, d, res(index), c, tinc, atol, vtol);
        subplot(2,2,index), 
        plot(x,t), 
        xlabel('x'), 
        ylabel('Time'), 
        title(strcat('Mass =',num2str(res(index)))), 
        axis([xMin,xMax,yMin,yMax]);
        hold on
    end

    %   Create subplot
    %   subplot(lines,colluns,position)

    %   Plot in the current subplot
    %   plot(x,t)

    %   
else
    res = [];
end
end

function flag = errorChecking(mL1, mL2)
    flag = 0;
    if mL1 <= 0
        fprintf('ERROR: mL1 value is inconsistent');
        flag = -1;
    end
    if mL2 <= 0
        fprintf('ERROR: mL2 value is inconsistent');
        flag = -1;
    end
end