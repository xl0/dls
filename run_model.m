clear;
close all;

f1 = figure(1);
%f2 = figure(2);

screen_size = get(0, 'ScreenSize');
%set(f1, 'Position', [0 0 screen_size(3) screen_size(4) ] );
%set(f1, 'Resize', 'off');
%set(f1, 'WindowStyle', 'modal');


%subplot(1, 2, 1);
%subplot(1, 2, 2);


% Dimentions
xlim = 500;
ylim = 500;

Cell_number = 20000;
Start_threshold = 1;


% Simulation resolution
delta_t = 1;
% Sumulation time
sim_time = 1000;

% Concentation matrix
C = zeros(ylim, xlim);

% Cell vector

Cells = zeros(Cell_number, 3);

% Place the cells randomly;

for i = 1:Cell_number
    Cells(i, 1) = floor((ylim) * rand() + 1);
    Cells(i, 2) = floor((xlim) * rand() + 1);
    Cells(i, 3) = Start_threshold; 
end


C(100,75) = 300;

cmap = color_map();

% The main loop

for t = 1:delta_t:sim_time
    t
    [C, Cells] = single_step(C, Cells, xlim, ylim, delta_t);
%    if (~mod(t, 1))
              show_concentration(C, Cells, t, cmap);

        
%    end
%    sum(sum(C))

end


