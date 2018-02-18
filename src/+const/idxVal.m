classdef idxVal
    % idxVal 
    % mBase- Location of BasePower in *.gen case file 
    %   usage example: 
    %       net = loadcase('case5'); basePower = net.gen(:,idxVal.mBase)
    % -----------------------------------------------------------
    % X_ij is the index pf the reactance of a generator or line.
    % This is to index the reactance of a line 
    % Usage:
    %   net = loadcase('case5'); basePower = net.gen(:,idxVal.mBase)
    % -----------------------------------------------------------
    % w_oa is nominal frequency in United States i.e. 60Hz
    % w_oe is nominal Frequency in Europe i.e. 50 Hz
    % -----------------------------------------------------------
    
    properties (Constant)
        mBase = 7;
        X_ij  = 4;
        fromBus = 1;
        toBus   = 2;
        w_oa  = 60;
        w_oe  = 50;
        
    end
    
    methods
    end
    
end

