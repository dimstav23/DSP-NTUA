function levels = linearQ(s, Bits)
%Megisth k elaxisth timh diasthmatos kvantishs:
Maxs = ceil(max(max(s)));
Mins = floor(min(min(s)));
comp = max(abs(Mins), abs(Maxs));
Maxs = comp;
Mins = (-1)*comp;
%apostash tou enos epipedou apo to allo
Lvl_Distance = (Maxs - Mins)/2^Bits;
%Prosarmogh tou shmatos eisodou stis times twn epipedwn kvantishs
New_Values = floor((s-Mins)/Lvl_Distance);
Mins = Mins + Lvl_Distance/2;
levels = Mins + Lvl_Distance*New_Values;
