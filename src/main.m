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
%Make J matrix

j11 = zeros(n_g,n_g);
for i =1:n_g
j11(i,i) = -M_i(i)./(5).^2; %'5' here is the Damping D, will ned to find. 
%this is what they chose.
end
j33 = zeros(n,n);
for i =1:n
j33(i,i) = -1; %'1' here is the load frequency ratio, will ned to find.
%this is what they chose.
end
j44 = zeros(n_l,n_l);
for i = 1:n_l
j44(i,i)= -1./(1.1.*network.branch(i,6));
end
j12 = zeros(n_g,n_g);
j12(1,:)=(1/M_i(1));
for i = 2:n_g
j12(i+1,i)=-(1/M_i(i));
end
j13 = zeros(n_g, n_g);
j13(1,:) = 1./M_i(1);
J = zeros(4,4);
J(1,1) = j11;
J(1,2) = j12;
J(1,3) = j13;
J(2,1) = -j12.';
J(3,1) = -j13.';
J(3,3) =  j33;
J(4,4) =  j44;
J


