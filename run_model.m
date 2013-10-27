function zz = run_model(P)

P

rng(1337);

mkdir(P.model_base);

generate_model_html(P);


A = (P.C_max - P.C_min) * (P.T_rrp + P.T_arp) / P.T_rrp;

fprintf('Generating world...\n');
% Concentation matrix
C = zeros(P.ylim, P.xlim);
c_map = color_map();
Cells = generate_cells(P);

video = 0;
if (P.record)
    video = init_video(P);
end

fprintf('Starting simulation...\n');

% The main loop
n = 0;
for t = 0:P.delta_t:P.sim_time
    n = n + 1;
    [C] = model_diffusion(C, P);
    if (~mod(t, 1))
        [C, Cells] = model_cells(C, Cells, P);
        
        if (P.record || ismember(t, P.checkpoints))
            show_concentration(C, Cells, c_map, t, video, P);
        end
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

%end
fprintf('Done!\n');
end

