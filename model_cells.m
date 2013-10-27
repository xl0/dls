function [C, Cells] = model_cells(C, Cells, P)

A = (P.C_max - P.C_min) * (P.T_rrp + P.T_arp) / P.T_rrp;

% Go through the cells to see how they are doing.
for i = 1:length(Cells)
   
    x = Cells(i, 1);
    y = Cells(i, 2);
    T = Cells(i, 3);
    E = Cells(i, 4);
    
    % Update time since last fiering
    T = T + P.delta_t;
    
    
    
    % Update excitibility
    E = E + P.delta_t * ( -P.alpha * E + P.beta * C(x, y));
    E = min(E, P.E_max); % Can't go over the top.
    

    if ( T > P.T_arp)
            % Calculate threshold value for the cell
            C_thresh = max(P.C_min, (P.C_max - A * (T - P.T_arp) / (T))) ...
                * (1 - E);

            % If concentration above threshold, or T_max reached, fire
            if (C(x, y) > C_thresh || T > P.T_max)
                T = 0;
                E = 0;
                C(x, y) = C(x, y) + 300;
            end
    end
    
    % Save updated values
    Cells(i, 3) = T;
    Cells(i, 4) = E;
    
end


end
