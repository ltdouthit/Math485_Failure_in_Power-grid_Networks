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
            %Assign Real Power 
            data.real_power = data.network_data.bus(:,idx.REALPOWER_INDEX);
            %Determin tildy B_ij Matrix
            data.B_ij = zeros(data.nodes(3),data.nodes(3));
            for i = 1:data.nodes(3)
                x  = data.network_data.branch(i,idx.REACTANCE_INDEX);
                mi = data.network_data.branch(i,idx.FROM_BUS);
                mj = data.network_data.branch(i,idx.TO_BUS);
                data.B_ij(mi,mj) = -1/x;
            end
            %Determin W_ij Matrix
            data.W_ij = zeros(data.nodes(3),data.nodes(3));
            for i = 1:data.nodes(3)
                mi = data.network_data.branch(i,idx.FROM_BUS);
                mj = data.network_data.branch(i,idx.TO_BUS);
                data.W_ij(mi,mj) = 1.1.*data.network_data.branch(i,idx.MVA_LONG_TERM_INDEX);
            end
            
            
            
            
        end
        
    end
    
end

