function [ dtw_i ] = generator_frq_dt(del_ij, B_ij, M_i, D_i, P_i, w_i  )
% del_ij is phase angle relative to sys.
% n_g  is number of generators in system
% n    is nongenerator nodes
% B_ij is a n_g(# of generators) by n_g + 1 matrix defining transient reactance  
% M_i  is Generator rotor inertia
% D_i  is Rotot Dampining ratio 
% P_i  is negitive mechanical power input  
% w_i  is Frequency of generator
%{
This is probably trash, but this should be the update equation for
frequency.

%}
dtw_i = -(D_i/M_i).*w_i - (1/M_i)*(P_i +  (sum(B_ij.*sin(del_ij),2)).');


end

