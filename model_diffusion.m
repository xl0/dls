function Cnew = single_step(C, P)


% s2 = 1/sqrt(2);

%sum(sum(Cnew))
% Fire the cells

%s2 = 0;
% Cnew = zeros(size(C));
% conv_m = [  s2,  1, s2;
%             1, -4 - 4*s2, 1;
%             s2,  1, s2;
%             ] / (4 + 4*s2);
%       
% 
% % Do the diffusion
% Cnew = C + delta_t * Diffusion_rate * conv2(C, conv_m, 'same');
% %sum(sum(Cnew))

Cnew = C * (1 - P.Degradation_rate);
Cnew = Cnew + (P.Diffusion_rate) .* hexdiff(Cnew);

% Just in case.
assert(min(min(Cnew)) >= 0);

end