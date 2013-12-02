function show_concentration(C, Cells, c_map, t, video, P)

Cells_matrix = zeros(size(C));

% Construct the cell matrix for display.
for i = 1:size(Cells,1)
    x = Cells(i, 1);
    y = Cells(i, 2);
    T = Cells(i, 3);

    if (T < P.T_arp)
        Cells_matrix(y, x) = 500;
    else if (T < P.T_arp + P.T_rrp)
            Cells_matrix(y, x) = 501;
        else
            Cells_matrix(y, x) = 502;
        end
    end
end

Spacer = ones(size(C, 1), 4) * 100;


%size(C)
%size(Cells_matrix)
%size(Spacer)

if (P.display)
    imshow(horzcat(C, Spacer, Cells_matrix), c_map,  'Border', 'tight', ...
        'InitialMagnification', 100);
    drawnow;
end

rgb_img = ind2rgb(round(horzcat(C, Spacer, Cells_matrix)), c_map);
[A,map] = rgb2ind(rgb_img, 256);

if (P.record)
    frame_name = sprintf('%s/video/frame_%.6d.png', P.model_base, t);
    imwrite(A, map, frame_name, 'png');
end

if(ismember(t, P.checkpoints))
    checkpoint_name = sprintf('%s/%s_%d.png', P.model_base, P.model_base, t);
    imwrite(A, map, checkpoint_name, 'png');
end
