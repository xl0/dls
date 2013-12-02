function [Cnew, Cells] = model_cells(C, Cells, P, t)

A = (P.C_max - P.C_min) * (P.T_rrp + P.T_arp) / P.T_rrp;

Pos = zeros(size(C));
for i = 1:size(Cells, 1)
	Pos(Cells(i, 2), Cells(i, 1)) = Pos(Cells(i, 2), Cells(i, 1)) + 1;
end

Cnew = C;
% Go through the cells to see how they are doing.
for i = 1:size(Cells, 1)
    x = Cells(i, 1);
    y = Cells(i, 2);
    T = Cells(i, 3);
    E = Cells(i, 4);
    
    % Update time since last fiering
    T = T + P.delta_t;
    
    
    
    % Update excitibility
    E = E + P.delta_t * ( -P.alpha * E + P.beta * C(y, x));
    E = min(E, P.E_max); % Can't go over the top.
    

    if ( T > P.T_arp)

            % Calculate threshold value for the cell
            C_thresh = max(P.C_min, (P.C_max - A * (T - P.T_arp) / (T))) ...
                * (1 - E);

            % If concentration above threshold, or T_max reached, fire
            if (C(y, x) > C_thresh || T > P.T_max)
                T = 0;
                E = 0;
		if (t > 2000)
			[ y1, x1 ] = chemotaxis(y, x, C);
			if(Pos(y1, x1) <1)
				Pos(y1, x1) = Pos(y1, x1) + 1;
				Pos(y, x) = Pos(y, x) - 1;
				x = x1;
				y = y1;
			end
		end
                Cnew(y, x) = C(y, x) + 300;
            end
    end
    
    % Save updated values
    Cells(i, 1) = x;
    Cells(i, 2) = y;
    Cells(i, 3) = T;
    Cells(i, 4) = E;
    
end


end
