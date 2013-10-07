% Single step of the simulations
function [Cnew, Cells] = single_step(C, Cells, xlim, ylim, delta_t)

%Model parameters

Diffusion_rate = 0.9;
Degradation_rate = 0.08;

Cnew = zeros(size(C));
conv_m = [  0,  1, 0;
            1, -4, 1;
            0,  1, 0;
            ] / 4;

        

        
% Do the diffusion
Cnew = C + Diffusion_rate * conv2(C, conv_m, 'same');
%sum(sum(Cnew))
Cnew = Cnew * (1 - Degradation_rate);
%sum(sum(Cnew))
% Fire the cells
for i = 1:length(Cells)
    x = Cells(i, 1);
    y = Cells(i, 2);
    Threshold = Cells(i, 3);
    
    if (Cnew(x, y) > Threshold)
        % Reset the threshold
        Cells(i, 3) = 10000;
        Cnew(x, y) = 300;
    end
        
    
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