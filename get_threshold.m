function Threshold = get_threshold(T, E, A, Parameters)

xlim = Parameters(1);
ylim = Parameters(2);
Diffusion_rate = Parameters(3);
Degradation_rate = Parameters(4);
T_arp = Parameters(5);
T_rrp = Parameters(6);
T_max = Parameters(7);
C_max = Parameters(8);
C_min = Parameters(9);
alpha = Parameters(10);
beta = Parameters(11);
E_max = Parameters(12);
delta_t = Parameters(13);


if (T < T_arp)
    Threshold = 1000;
else
    if (T < (T_arp + T_rrp))
        Threshold = C_max - A * (T - T_arp) / (T);
    else
        Threshold = C_min;
    end
end


end