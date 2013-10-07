clear;
close all;

f1 = figure(1);

screen_size = get(0, 'ScreenSize');
set(f1, 'Position', [0 0 screen_size(3) screen_size(4) ] );


subplot(1, 2, 1);
subplot(1, 2, 2);


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

Cells = [];

% Place the cells randomly;

for i = 1:Cell_number
    Cells =  [ Cells ;  floor((ylim) * rand() + 1) , ...
                    floor((xlim) * rand() + 1), Start_threshold]; 
end


C(100,75) = 300;

% The main loop

for t = 1:delta_t:sim_time
    t
    [C, Cells] = single_step(C, Cells, xlim, ylim, delta_t);
%    if (~mod(t, 1))
        show_concentration(C, Cells);
        im = frame2im(getframe(1));
        [A,map] = rgb2ind(im,256);
        if (t == 1)
            imwrite(A, map, 'Model.gif', 'gif',  ...
                'DelayTime', 0.1);
        end
        
        imwrite(A, map, 'Model.gif', 'gif',  ...
            'DelayTime', 0.1, 'WriteMode','append');
        
%    end
%    sum(sum(C))

end

