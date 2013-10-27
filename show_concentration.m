function show_concentration(C, Cells, c_map, t, video, P)

Cells_matrix = zeros(size(C));

% Construct the cell matrix for display.
for i = 1:length(Cells)
    x = Cells(i, 1);
    y = Cells(i, 2);
    T = Cells(i, 3);

    if (T < P.T_arp)
        Cells_matrix(x, y) = 500;
    else if (T < P.T_arp + P.T_rrp)
            Cells_matrix(x, y) = 501;
        else
            Cells_matrix(x, y) = 502;
        end
    end
end

Spacer = ones(size(C, 1), 4) * 100 ;

if (P.display)
    imshow(horzcat(C, Spacer, Cells_matrix), c_map,  'Border', 'tight', ...
        'InitialMagnification', 100);
end



rgb_img = ind2rgb(round(horzcat(C, Spacer, Cells_matrix)), c_map);
[A,map] = rgb2ind(rgb_img, 256);

if (P.record)
    frame_name = sprintf('%s/video/frame_%.6d.png', P.model_base, t);
    imwrite(A, map, frame_name, 'png');
end



%figure;



%contour(C);
% colorbar;
drawnow;
%pause;
end
