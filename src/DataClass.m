classdef DataClass
    %DATACLASS:
    %---------------------------------------------------------------------
    %Constructor: takes str with network test case: 'case9' loads data into
    %network_data property and initilizes properties.
    %----------------------------------------------------------------------
    %Methods
    %
    %
    %  
    
    properties
        
        network_data
        nodes %Array of [#ofGen #ofLines #ofNodes]
        real_power %Array len #ofNodes Array P in Doc. 
        B_ij
        W_ij
        gen
        D_i
        M_i
        
    end
    
    methods
        function data = DataClass(network)
            import const.*
            idx = idxVal;
            %Load Test
            data.network_data = loadcase(network);   
            %Get number by type of Nodes
            data.nodes(1) = uint8(size(data.network_data.gen, 1));     % # of generators
            data.nodes(2) = uint8(size(data.network_data.branch, 1));  % # of lines
            data.nodes(3) = uint8(size(data.network_data.bus, 1));     % # of Nodes
            gen = data.network_data.gen(:,1);
            data.gen = gen.';
            %Assign Real Power 
            data.real_power = zeros(1,data.nodes(3));
            for j = 1:length(data.gen)
                data.real_power(data.gen(j)) =  -data.network_data.bus(j,idx.REALPOWER_INDEX_NODE);% - data.network_data.gen(j,idx.REALPOWER_INDEX_GEN);
                if data.real_power(data.gen(j)) == 0
                    data.real_power(data.gen(j)) = -1;
                end
                data.real_power(data.gen(j)) = 1/data.real_power(data.gen(j));
            end
            for i = 1:data.nodes(3)
                if ~ismember(i,data.gen)
                    data.real_power(i) = data.network_data.bus(i,idx.REALPOWER_INDEX_NODE);
                    if data.real_power(i) == 0
                        data.real_power(i) = 1;
                    end
                    data.real_power(i) = data.real_power(i);
                end
            end

            %Determin tildy B_ij Matrix
            data.B_ij = zeros(data.nodes(3),data.nodes(3));
            for i = 1:data.nodes(2)
                x  = data.network_data.branch(i,idx.REACTANCE_INDEX);
                if x == 0
                    x = 0.0001;
                end
                mi = data.network_data.branch(i,idx.FROM_BUS);
                mj = data.network_data.branch(i,idx.TO_BUS);
                data.B_ij(mi,mj) = -1/x;
            end
            %Determin W_ij Matrix
            data.W_ij = zeros(data.nodes(3),data.nodes(3));
            for i = 1:data.nodes(2)
                mi = data.network_data.branch(i,idx.FROM_BUS);
                mj = data.network_data.branch(i,idx.TO_BUS);
                data.W_ij(mi,mj) = 1.58 * data.B_ij(mi,mj); %*data.network_data.branch(i,idx.MAXIMUM_REACTIVE_POWER);
            end
            data.D_i = zeros(1, data.nodes(3));
            data.M_i = zeros(1, data.nodes(3));
            for i = 1:data.nodes(3)
                if ismember(i,data.gen)
                    data.D_i(i) = 5;
                    data.M_i(i) = 5;
                end
            end
        end
        
    end
    
end

