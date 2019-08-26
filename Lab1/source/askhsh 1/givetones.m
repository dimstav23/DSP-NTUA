function [w1,w2] = givetones(nm)

%Analoga me to num vriskw tis duo suxnothtes pou antistoixoun se auto
switch nm
        case 1 
            w1=0.9273;
            w2=0.5346;
        case 2 
            w1=1.0247;
            w2=0.5346;
        case 3 
            w1=1.1328;
            w2=0.5346;
        case 4 
            w1=0.9273;
            w2=0.5906;
        case 5
            w1=1.0247;
            w2=0.5906;
        case 6
            w1=1.1328;
            w2=0.5906;
        case 7 
            w1=0.9273;
            w2=0.6535;
        case 8
            w1=1.0247;
            w2=0.6535;
        case 9
            w1=1.1328;
            w2=0.6535;
        otherwise
            w1=1.0247;
            w2=0.7217;
    end