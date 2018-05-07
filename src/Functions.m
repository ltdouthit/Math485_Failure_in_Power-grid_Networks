classdef Functions < matlab.mixin.SetGet
    properties
        data
        idx
        a
        b
    end

    methods 
        function obj = set.data(obj, testCase)
            import DataClass;
            data1 = DataClass(testCase);
            obj.data = data1;
        end
        function obj = set.idx(obj, idx_t)
            obj.idx = idx_t;
        end
        function obj = set.a(obj, a_t)
            obj.a = a_t;
        end
        function obj = set.b(obj, b_t)
            obj.b = b_t;
        end
        function omega_fdot = update_omega( obj, omega, delta)
            for i = 1:obj.data.nodes(3)
                if ismember(i,obj.data.gen)
                    react = 0;
                    for j = 1:obj.data.nodes(3)
                        if ~ismember(j,obj.data.gen)
                            delta_ij = delta(i) - delta(j);
                            react = react + obj.data.B_ij(i,j)*sin(delta_ij); 
                        end
                    end
                        omega_dot = -(obj.data.D_i(i)/obj.data.M_i(i))*omega(i)-(1/obj.data.M_i(i))*((omega(i)+0)*obj.data.real_power(i) + react);
                        omega_fdot(i) = omega_dot;%*h + omega(i);
                else
                        omega_fdot(i) = 0;
                end
            end
        end
        function delta_fdot = update_delta(obj, omega, delta, neu)
            react  = 0;
            react1 = 0;
            for i = 2:obj.data.nodes(3)
                if ismember(i,obj.data.gen)
                    delta_dot = omega(i) - omega(1);
                    delta_fdot(i) = delta_dot;
                else 
                    for j = 1:obj.data.nodes(3)
                        if ismember(j,obj.data.gen)
                            delta_ij = delta(i) - delta(j);
                            react = react + obj.data.B_ij(i,j)*sin(delta_ij);
                        else
                            delta_ij = delta(i) - delta(j);
                            react1 = react1 + obj.data.B_ij(i,j)*sin(delta_ij)*neu(i,j);
                        end
                    end
                    delta_dot = -(obj.data.real_power(i) + react + react1) - omega(1);
                    delta_fdot(i) = delta_dot;
                end         
            end
        end
        function neu_fdot = update_neu(obj, delta, neu)
            neu_fdot = zeros(obj.data.nodes(3),obj.data.nodes(3));
            for i = 1:obj.data.nodes(2)
                mi = obj.data.network_data.branch(i,obj.idx.FROM_BUS);
                mj = obj.data.network_data.branch(i,obj.idx.TO_BUS);
                delta_ij = delta(mi) - delta(mj);
                lamda = obj.data.B_ij(mi,mj)*(1-cos(delta_ij))/obj.data.W_ij(mi,mj);
                t = power_flow_f(obj.a,obj.b,neu(mi,mj));
                neu_dot = (t - lamda);
                neu_fdot(mi,mj) = neu_dot;%*h + neu(mi,mj);
                if isnan(neu(mi,mj)) || neu(mi,mj) == inf || neu(mi,mj) < 0
                    neu(mi,mj) = 0;
                end 
            end

        end
        
        
   end
end
    

