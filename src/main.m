%{
Test Functions for rn. 
    power_flow_f looks good. 
    
rn this is scrap to see if I can start figuring this out.
%}
clear all;
import const.*

a = 13;
b = 8;

idx = idxVal;
testCase = 'case14';
data = DataClass(testCase);
%Calcultate the value of M_i
M_i = zeros(1, data.nodes(1));
M_i(:) = 5;
%Calcultate the value of D_i
D_i = zeros(1, data.nodes(1));
D_i(:) = 5;
%Initilize Omega
omega_dot = zeros(1,data.nodes(1));
delta_dot = zeros(1,data.nodes(1));
neu_dot   = zeros(data.nodes(3),data.nodes(3));

neu   = zeros(data.nodes(3),data.nodes(3));
for i = 1:data.nodes(2)
     mi = data.network_data.branch(i,idx.FROM_BUS);
     mj = data.network_data.branch(i,idx.TO_BUS);
     neu(mi,mj) = 0.95;
end
neu(13,14) = 0.5;
%neu(1,4) = 0.15;
omega = zeros(data.nodes(3));
for i = 1:data.nodes(3)
    if ismember(i,data.gen)
        omega(i)  = randn./100;
    end
end
delta(:)  = randn(1,data.nodes(3))./100;
delta(1)  = 0;

%
h = 0.001; %Step Size

%
for cnt = 1:1000
    for i =1:data.nodes(1)
        react = 0;
        for j = (data.nodes(1)+1):data.nodes(3)
            delta_ij = delta(i) - delta(j);
            react = react + data.B_ij(i,j)*sin(delta_ij);
        end
        omega_dot(i) = -(D_i(i)/M_i(i))*omega(i)-(1/M_i(i))*(data.real_power(i) + react);
        omega(i) = omega_dot(i)*h + omega(i);
    end
    for i = 1:data.nodes(3)
        if ismember(i,data.gen)
            delta_dot(i) = omega(i) - omega(1);
            delta(i) = delta_dot(i)*h + delta(i);
        end
    end
    react  = 0;
    react1 = 0;
    for i = (data.nodes(1)+1):data.nodes(3)
        for j = 1:data.nodes(1)
            delta_ij = delta(i) - delta(j);
            react = react + data.B_ij(i,j)*sin(delta_ij);
        end
        for j = (data.nodes(1)+1):data.nodes(3)
            delta_ij = delta(i) - delta(j);
            react1 = react1 + data.B_ij(i,j)*sin(delta_ij)*neu(i,j);
        end
        delta_dot(i) = -(react + react1) - omega(1);
        if ~ismember(i,data.gen)
            delta(i) = delta_dot(i)*h + delta(i);
        end
    end 

    for i = 1:data.nodes(3)
        for j = 1:data.nodes(3)
         delta_ij = delta(i) - delta(j);
         if data.W_ij(i,j) ~= 0
            lamda = data.B_ij(i,j)*(1-cos(delta_ij))/data.W_ij(i,j);
            if neu(i,j) ~= 0
                t = power_flow_f(a,b,neu(i,j));
                neu_dot(i,j) = (t - lamda); %Bad
            else 
                neu_dot(i,j) = 0;
            end
            neu(i,j) = neu_dot(i,j)*h + neu(i,j);
            if neu(i,j) > 1
                cnt;
                %neu(i,j) = 1.0;
            elseif neu(i,j) < 0.01 %Bad
                neu(i,j) = 0;
            end
         end
        end
    end

    %omega
    neu
    cnt
    pause(0.2)
  
end