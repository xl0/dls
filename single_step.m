% Single step of the simulations
function [Cnew, Cells] = single_step(C, Cells, Parameters)

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

Cnew = zeros(size(C));
conv_m = [  0,  1, 0;
            1, -4, 1;
            0,  1, 0;
            ] / 4;
      
% Do the diffusion
Cnew = C + delta_t * Diffusion_rate * conv2(C, conv_m, 'same');
%sum(sum(Cnew))
Cnew = Cnew * (1 - delta_t * Degradation_rate);
%sum(sum(Cnew))
% Fire the cells

%Decrease the absolute refractory period for all affected cells.

for i = 1:length(Cells)
   
    x = Cells(i,1);
    y = Cells(i, 2);

    T = Cells(i, 3);
    E = 0.93; %Cells(i, 4);
    
    
    % Update time since last fiering
    T = T + delta_t;
    
    
    % Update E
    %E = E - alpha * E + beta * Cnew(x, y);
    %E = min(E, E_max); % Can't go over the top.
    
     C_thresh = max(C_min, (C_max - A * (T - T_arp) / (T)));% * (1 - E);
    % C_thresh = get_threshold(T, E, A, Parameters);

    
    if (T > T_arp)
            if (Cnew(x, y) > C_thresh || T > 15)
                T = 0;
                Cnew(x, y) =  300;
            end
        
    end
    
    Cells(i, 3) = T;
    Cells(i, 4) = E;
    % For the absolute refractory period cells.
    
    
%     
%     
%     % Check the absolute refractory period
%     if (Cells(i, 3) > 0)
%         % Decrease by delta t;
%         Cells(i, 3) = Cells(i, 3) - delta_t;
%     else
%         % Else, check the relative refractory period
%         if (Cells(i, 4) > 0)
%             Cells(i, 4) = Cells(i, 4) - delta_t;
%         end
%         
%         tx = T_rrp - Cells(i, 4);
%         Threshold = (C_max - A * tx / (tx + T_arp));
%         
%     end
%     
%     
%     
%     if (Cnew(x, y) > Threshold)
%         Cells(i, 3) = 8;
%         Cells(i, 4) = 2;
%         Cnew(x, y) = 300;
%     end
end


%for i = 1:ylim
%    for j = 1:xlim

        
%        cont_diff = C(cart_neighbours(i, j, ylim, xlim)) - C(i, j);
        
%        Cnew(i, j) = C(i, j) + ...
%            delta_t * Diffusion_rate * sum(cont_diff) / length(cont_diff);
%        Cnew(i, j) = Cnew(i, j) - delta_t * Degradation_rate * Cnew(i, j);       
%    end
%end


end