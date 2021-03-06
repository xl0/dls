function run_model(P)

P

rng(1337);

mkdir(P.model_base);

figure('name', P.model_base);

A = (P.C_max - P.C_min) * (P.T_rrp + P.T_arp) / P.T_rrp;

fprintf('Generating world...\n');
% Concentation matrix
C = zeros(P.ylim, P.xlim);

%for i = 2:P.ylim - 1
%	for j = 2:P.xlim - 1
%		C(i, j) = j *(P.ylim + i) / 100;
%	end
%end


c_map = color_map();
Cells = generate_cells(P);

video = 0;
if (P.record)
    video = init_video(P);
end

fprintf('Starting simulation...\n');

avg_record = zeros(1, P.sim_time * P.delta_t);

% The main loop
n = 0;
for t = 0:P.delta_t:P.sim_time
    n = n + 1;
    [C] = model_diffusion(C, P);
    if (~mod(t, 1))
        [C, Cells] = model_cells(C, Cells, P, t);

        if (P.record || ismember(t, P.checkpoints))
            show_concentration(C, Cells, c_map, t, video, P);
        end
        avg_record(t+1) = mean(mean(C));
    end

    if (~mod(t, 100))
%	display(t);
    end



%     for i = 1:10
%         Cell = Cells(floor(length(Cells) / i),:);
%         T = Cell(3);
%         E = Cell(4);
%         if (T < T_arp)
%             Threshold_records(n,i) = 500;
%         else if (T < T_arp + T_rrp)
%                 Threshold_records(n,i) = (C_max - A * (T - T_arp) / (T)) * (E - 1);
%             else
%                 Threshold_records(n,i) = C_min * (1 - E);
%             end
%         end
%         E_records(n, i) = E;
%         Time_records(n, i) = T;
%         Concentration_records(n, i) = min(1000, C(Cell(1), Cell(2)));
%     end

%    plot(Time(1:n), E_records(1:n, 5), ...
%        Time(1:n), Threshold_records(1:n, 5), ...
%        Time(1:n), Time_records(1:n, 5));

%    pause;
%    end
%    sum(sum(C))


end

record_css(mean(avg_record), P);

%end
fprintf('Done!\n');
end

