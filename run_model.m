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
xlim = 500
ylim = 500;


%Model parameters

Diffusion_rate = 0.9;
Degradation_rate = 0.8;

% Absolute and relative refractory periods

T_arp = 8;
T_rrp = 2;

T_max = 15;

C_max = 100;
C_min = 4;

alpha = 0.0005;
beta = 1.24;

E_max = 0.93;

Cell_density = 0.9;
% Start_threshold = 4;

% Simulation resolution
delta_t = 0.1;
% Sumulation time
sim_time = 100000;


Parameters = [  xlim, ... % 1
                ylim, ... % 2
                Diffusion_rate, ... % 3
                Degradation_rate, ... % 4
                T_arp, ... % 5
                T_rrp, ... % 6
                T_max, ... % 7
                C_max, ... % 8
                C_min, ... % 9
                alpha, ... % 10
                beta,  ... % 11
                E_max, ... % 12
                delta_t, ... % 13
                ];
            
A = (C_max - C_min) * (T_rrp + T_arp) / T_rrp;
            
% Concentation matrix
C = zeros(ylim, xlim);

c_map = color_map();

% Cell vector
% x, y, fiering time,  E
% Cells = zeros(Cell_number, 4);
fprintf('Generating world...\n');
Cells = generate_cells(xlim, ylim, Cell_density);

% Recording for a few cells.
Time = 0:delta_t:sim_time;
Threshold_records = zeros(length(Time), 10);
Time_records = zeros(length(Time), 10);
Concentration_records = zeros(length(Time), 10);

fprintf('Starting simulation...\n');



% The main loop
n = 0;
for t = 1:delta_t:sim_time
    n = n + 1
    [C, Cells] = single_step(C, Cells, Parameters);
    %if (~mod(t, 1))                
               show_concentration(C, Cells, c_map, t, Parameters);
    %end
    
   % for i = 1:10
   %     Cell = Cells(floor(length(Cells) / i),:);
   %     Threshold_records(n) = get_threshold(Cell(3), Cell(4), A, Parameters);
   %     Time_records(n) = Cells(3);
   %     Concentration_records(n) = C(Cell(1), Cell(2));
   % end
    
     %plot(Time(1:n), Time_records(1:n,1));
     %, ...
     %    Time(1:n), Threshold_records(1:n,1));
     drawnow;
%    end
%    sum(sum(C))

end


