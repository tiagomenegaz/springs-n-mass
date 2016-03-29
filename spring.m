function [ x, t ] = spring( ks, rs, startX, d, m, c, tinc, atol, vtol )
%SPRING This function shows the behaviour of a simple harmonic motion
%   Spring function returns two vectors x (the location of the spring at
%   different time instances) and t (the time instances corresponding to
%   each location).
%   Spring function expects a number of arguments:  
%   ks      - A 1x2 array containing the two spring constants (the left spring constant followed by the right spring constant).
%   rs      - A 1x2 array containing the two spring rest displacements (the left spring rest displacement followed by the right spring rest displacement).
%   startx  - A scalar defining the initial starting point of the object as measured from the base point of the first (left) spring.
%   d       - A scalar defining the distance between the two springs.
%   m       - A scalar defining the mass of the object.
%   c       - A scalar defining the damping constant of the system.
%   tinc    - A scalar defining the time increment to use in one iteration of the system.
%   atol    - A scalar defining the acceleration tolerance.
%   vtol    - A scalar defining the velocity tolerance.



if errorChecking(ks, rs, startX, d, m, c, tinc, atol, vtol) == 0
    %   Define return variables
    x       = zeros(100,1);
    t       = zeros(100,1);

    %   Define initial variables
    v       = 0;
    time    = 0;
    ii      = 1;
    x(ii)   = startX;

    %   Increment index
    ii      = ii + 1;

    %   Force   
    f1      = -ks(1)*(startX -rs(1));
    f2      = ks(2)*(d -startX -rs(2));
    fNet    = f1+f2-c*v;
    %   Aceleration updating   
    a       = fNet/m;
    %   New velocity
    v       = v + a*tinc;  
    %   New object location
    x(ii)   = x(ii-1) + v*tinc;
    %   Time incrementation
    time    = time + tinc;    
    %   Add return variable
    t(ii)   = time;

    %   The process continues iterating until equilibrium is reached
    while abs(v) > vtol || abs(a) > atol 
        %   Increment index
        ii      = ii + 1;   
        %   Time incrementation
        time    = time + tinc;
        %   Add return variable
        t(ii)   = time;    
        %   Force   
        f1      = -ks(1)*(x(ii-1) -rs(1));
        f2      = ks(2)*(d -x(ii-1) -rs(2));
        fNet    = f1+f2-c*v;
        %   Aceleration updating   
        a       = fNet/m;
        %   New velocity
        v       = v + a*tinc;  
        %   New object location
        x(ii)   = x(ii-1) + v*tinc;
    end
else
    x = [];
    t = [];    
end
end

function flag = errorChecking(ks, rs, startX, d, m, c, tinc, atol, vtol)
    %   Define inicial value 
    flag = 0;
    
    %   Test size ks
    sizeTest = size(ks);
    if sizeTest(1) ~= 1 || sizeTest(2) ~= 2
        fprintf('ERROR: KS size is inconsistent\n');
        flag = -1;
    end
    %   Test size rs
    sizeTest = size(rs);
    if sizeTest(1) ~= 1 || sizeTest(2) ~= 2
        fprintf('ERROR: RS size is inconsistent\n');
        flag = -1;
    end
    
    %   Test startX
    if startX < 0
        fprintf('ERROR: startX is < 0\n');
        flag = -1;
    end
    
    %   Test d
    if d < 0
        fprintf('ERROR: D is < 0\n');
        flag = -1;
    end
    
    %   Test m
    if m < 0
        fprintf('ERROR: m is < 0\n');
        flag = -1;
    end
    
    %   Test c
    if c < 0
        fprintf('ERROR: c is < 0\n');
        flag = -1;
    end
    
    %   Test tinc
    if tinc < 0
        fprintf('ERROR: TINC is < 0\n');
        flag = -1;
    end
    
    %   Test ATOL
    if atol < 0
        fprintf('ERROR: ATOL is < 0\n');
        flag = -1;
    end
    
    %   Test ATOL
    if vtol < 0
        fprintf('ERROR: VTOL is < 0\n');
        flag = -1;
    end
end