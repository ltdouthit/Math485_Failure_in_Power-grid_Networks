%{
Test Functions for rn. 
    power_flow_f looks good. 
    
rn this is scrap to see if I can start figuring this out.
%}

%{
hold on 
axis([-.5 1.5 -4 4])
plot([-.5 1.5], [0 0]);
fplot(@(n_l) power_flow_f(10,4,n_l), [0,1]);
hold off
%}
import const.*
%Declare Paramiteres as needed
testCase = 'case5';
H = 7; %Inertia Constant H

%Load Test
network = loadcase(testCase);

%Find number of lines
n_g     = uint8(size(network.gen, 1));     % # of generators
n       = uint8(size(network.bus, 1));     % # of Nodes
n_l     = uint8(size(network.branch, 1));  % # of lines


w_0 = idxVal.w_oa; %Nominal Frequency

%Calculate inital conditions for w_i
w_i = zeros(1, n_g);
w_i(:) = w_0;

%Calcultate the value of M_i
M_i = zeros( 1, n_g );
for i=1:n_g 
    p_0 = network.gen(i,idxVal.mBase);  %Base Power
    M_i(i) = (w_0/p_0)*H; %Calculate M_i
end

B_ij = zeros(n,n);
for i = 1:n
    x = network.branch(i,idxVal.X_ij);
    mi = network.branch(i,idxVal.fromBus);
    mj = network.branch(i,idxVal.toBus);
    B_ij(mi,mj) = -1/x;
end

network.gen;





