classdef idxVal
    % idxVal 
    % mBase- Location of BasePower in *.gen case file 
    %   usage example: 
    %       net = loadcase('case5'); basePower = net.gen(:,idxVal.mBase)
    % -----------------------------------------------------------
    % REACTANCE_INDEX is the index pf the reactance of a generator or line.
    % This is to index the reactance of a line 
    % Usage:
    %   net = loadcase('case5'); basePower = net.branch(:,idxVal.REACTANCE_INDEX)
    % -----------------------------------------------------------
    % NOM_FREQ_US is nominal frequency in United States i.e. 60Hz
    % NIM_FREQ_EU is nominal Frequency in Europe i.e. 50 Hz
    % -----------------------------------------------------------
    % REALPOWER_INDEX is index of real power in net.bus(:,idxVal.REALPOWER_INDEX);
    % 
    properties (Constant)
        %Indexing Constants 
        mBase = 7;
        REACTANCE_INDEX  = 4;
        FROM_BUS = 1;
        TO_BUS   = 2;
        NOM_FREQ_US  = 60;
        NIM_FREQ_EU  = 50;
        MAXIMUM_REACTIVE_POWER = 4;
        REALPOWER_INDEX = 3;
        
        
    end
    
    methods
    end
    
end

