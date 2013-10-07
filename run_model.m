clear;
close all;

figure('Position', [0, 0, 500, 500]);


% Dimentions
xlim = 145;
ylim = 167;

% Simulation resolution
delta_t = 1;
% Sumulation time
sim_time = 100;

% Concentation matrix
C = zeros(ylim, xlim);

C(50,50) = 100;
C(55,50) = 100;
C(55, 55) = 100;

% The main loop

for t = 0:delta_t:sim_time
    t
    C = single_step(C, xlim, ylim, delta_t);
%    if (~mod(t, 1))
        show_concentration(C);  
%    end
%    sum(sum(C))

end
    


%show_concentration(C);



