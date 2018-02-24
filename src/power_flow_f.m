function [ lambda_l ] = power_flow_f( a, b, n_l )
% (a,b) adjusted paramiters, 0 < n_l < 1  is power flow. 
% this is the f(n_l) function defined and used in equation (1). 
% The use is to satisfy the equation of the first time derivitive 
% n overdot or equation (1) in the paper.
% n_dot = power_flow_f( a, b, n_l ) - n_l

lambda_l = a^(-1)*(n_l^(-1) - (1 - n_l)^(-1)) + a.*(n_l.^(4)) - b;
% if temp > 1
%lambda_l = 1;
%elseif temp < 0
%lambda_l = 0;
%else
%lambda_l = temp;    
%end
end

