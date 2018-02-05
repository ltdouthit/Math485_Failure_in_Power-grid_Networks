%{
Test Functions for rn. 
    power_flow_f looks good. 
    
rn this is scrap to see if I can start figuring this out.
%}



hold on 
axis([-.5 1.5 -4 4])
plot([-.5 1.5], [0 0]);
fplot(@(n_l) power_flow_f(10,4,n_l), [0,1]);
hold off

