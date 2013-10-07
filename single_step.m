% Single step of the simulations
function Cnew = single_step(C, xlim, ylim, delta_t)

%Model parameters

Diffusion_rate = 0.5;
Degradation_rate = 0.08;

Cnew = zeros(size(C));
conv_m = [  0,  1, 0;
            1, -4, 1;
            0,  1, 0;
            ] / 4;

Cnew = C + Diffusion_rate * conv2(C, conv_m, 'same');
Cnew = Cnew*(1 - Degradation_rate);


%for i = 1:ylim
%    for j = 1:xlim

        
%        cont_diff = C(cart_neighbours(i, j, ylim, xlim)) - C(i, j);
        
%        Cnew(i, j) = C(i, j) + ...
%            delta_t * Diffusion_rate * sum(cont_diff) / length(cont_diff);
%        Cnew(i, j) = Cnew(i, j) - delta_t * Degradation_rate * Cnew(i, j);       
%    end
%end


end