function B = BeamPattern (d, N, theta_s, theta, w)
    theta_normalised = (pi/180)*theta; %kanonikopoihsh ths gwnias thita [-180,180]
    %efarmofh typou ekfwnhsh gia to B(w,thita)
    B = (1/N)*sin(N*(w/(2*340))*d*(cos(theta_normalised)-cos(theta_s)))./sin((w/(2*340))*d*(cos(theta_normalised)-cos(theta_s)));
end