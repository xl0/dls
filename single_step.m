% Single step of the simulations
function [Cnew, Cells] = single_step(C, Cells, t, Parameters)

% Parameters = [  xlim, ... % 1
%                 ylim, ... % 2
%                 Diffusion_rate, ... % 3
%                 Degradation_rate, ... % 4
%                 T_arr, ... % 5
%                 T_rrp, ... % 6
%                 T_max, ... % 7
%                 C_max, ... % 8
%                 C_min, ... % 9
%                 alpha, ... % 10
%                 beta,  ... % 11
%                 E_max, ... % 12
%                 delta_t, ... % 13
%                 ];

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

A = (C_max - C_min) * (T_rrp + T_arp) / T_rrp;

s2 = sqrt(2);



%sum(sum(Cnew))
% Fire the cells


Cnew = zeros(size(C));
conv_m = [  0,  1, 0;
            1, -4, 1;
            0,  1, 0;
            ] / 4;
      

% Do the diffusion
Cnew = C + delta_t * Diffusion_rate * conv2(C, conv_m, 'same');
%sum(sum(Cnew))
Cnew = Cnew * (1 - delta_t * Degradation_rate);

% assert(min(min(Cnew) < 0));

%min(min(Cnew))
assert(min(min(Cnew)) >= 0);
%Decrease the absolute refractory period for all affected cells.

for i = 1:length(Cells)
   
    x = Cells(i,1);
    y = Cells(i, 2);

    T = Cells(i, 3);
    E = Cells(i, 4);
    
    % Update E
    E = E + delta_t * ( - alpha * E + beta * C(x, y));
    E = min(E, E_max); % Can't go over the top.
    
    C_thresh = max(C_min, (C_max - A * (T - T_arp) / (T))) * (1 - E);
    % C_thresh = get_threshold(T, E, A, Parameters);

    
    if ( T > T_arp)
            if (C(x, y) > C_thresh || T > T_max)
                T = 0;
                Cnew(x, y) = Cnew(x, y) + 300;
            end
        
    end
    
    % Update time since last fiering
    T = T + delta_t;
    
    Cells(i, 3) = T;
    Cells(i, 4) = E;
    % For the absolute refractory period cells.
end



end