function [ y ] = Psi(n,n_g,n_l, M_i,B_ij,P,W_ij,network,omega,delt,neu)
y = fun(@delta,omega,delt,neu);

function y = delta(omega,delt,neu)
import const.*
%{
nodes   = [n_g, n_l, n];

%}
t1 = 0;
t11 = 0;
t2 = 0;
t3 = 0;
t4 = 0;

for i = 1:n_g
    for j = (n_g+1):n
    t1 = t1 + B_ij(i,j).*(1-cos(delt(i)));
    end
    t11 = t11 + t1 + 0.5*M_i(i)*omega(i)^2;
end

for i = (n_g+1):n
    for j = (n_g+1):n
        t2 = t2 + B_ij(i,j).*(1-cos(delt(i)))*neu(i);
    end
end
%for i = 2:nodes(3)
%    t3 = t3 + P(i)*delt(i);
%end

for i = 1:n_l
    mi = network.branch(i,idxVal.fromBus);
    mj = network.branch(i,idxVal.toBus);
    t4 = t4 + W_ij(mi,mj).*power_flow_f(10,4,neu(i));
end
 y = t1+t2+t3+t4
end
end
