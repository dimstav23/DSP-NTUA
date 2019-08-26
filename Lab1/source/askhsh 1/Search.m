function [tone] = Search (n1,n2)
%Dinoume sth sunarthsh 2 akeraious kai analoga me autous epilegw poios einai
%o tonos pou antistoixei se autous, dhladh poio koumpi path8hke sto
%touch-pad.
switch n1
    case 86
        switch n2
            case 149
                tone = 1;
            case 164
                tone = 2;
            case 181 
                tone = 3;
            otherwise tone = 'This is a wrong button';
        end;
    case 95
        switch n2
            case 149
                tone = 4;
            case 164
                tone = 5;
            case 181 
                tone = 6;
            otherwise tone = 'This is a wrong button';
        end;
    case 105
        switch n2
            case 149
                tone= 7;
            case 164
                tone = 8;
            case 181 
                tone = 9;
            otherwise tone = 'This is a wrong button';
        end;
    case 116
        tone = 0;
    otherwise tone = 'This is a wrong button';
end
end