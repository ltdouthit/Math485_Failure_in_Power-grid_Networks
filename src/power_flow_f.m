function [ lambda_l ] = power_flow_f( a, b, n_l )
% (a,b) adjusted paramiters, 0 < n_l < 1  is power flow. 
% this is the f(n_l) function defined and used in equation (1). 
% The use is to satisfy the equation of the first time derivitive 
% n overdot or equation (1) in the paper.
% n_dot = power_flow_f( a, b, n_l ) - n_l

a_inv = a^(-1);
n_inv = n_l^(-1);
n_dif = (1 - n_l)^(-1);
n_4   = n_l^(4);
lambda_l = a_inv*(n_inv - n_dif) + a*n_4 - b;

end

