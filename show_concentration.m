function show_concentration(C, Cells, c_map, t,  Parameters)

T_arp = Parameters(5);
T_rrp = Parameters(6);
T_max = Parameters(7);

Cells_matrix = zeros(size(C));

for i = 1:length(Cells)
    x = Cells(i, 1);
    y = Cells(i, 2);
    T = Cells(i, 3);
    
    if (T < T_arp)
        Cells_matrix(x, y) = 500;
    else if (T < T_arp + T_rrp)
            Cells_matrix(x, y) = 501;
        else
            Cells_matrix(x, y) = 502;
        end
    end
end
%figure(2)
%set(0, 'CurrentFigure', 2);
% subplot(1, 2, 2);
Spacer = ones(size(C, 1), 3) * 5;


imshow(horzcat(C, Spacer, Cells_matrix), c_map,   'Border', 'tight');

% 

im = frame2im(getframe());
[A,map] = rgb2ind(im,256);
if (t == 1)
    imwrite(A, map, 'Model2.gif', 'gif',  ...
        'DelayTime', 0.03);
end

imwrite(A, map, 'Model2.gif', 'gif',  ...
    'DelayTime', 0.03, 'WriteMode','append');

%figure;
%contour(C);
% colorbar;
drawnow;
%pause;
end