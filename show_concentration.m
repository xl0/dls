function show_concentration(C, Cells, t, map)

% subplot(1, 2, 1);
% figure(1);
%set(0, 'CurrentFigure', 1);
%imshow(C, [0 10],'InitialMagnification', 100, 'Border', 'tight');

% im = frame2im(getframe());
% [A,map] = rgb2ind(im,256);
% if (t == 1)
%     imwrite(A, map, 'Model-Concentration.gif', 'gif',  ...
%         'DelayTime', 0.1);
% end
% 
% imwrite(A, map, 'Model-Concentration.gif', 'gif',  ...
%     'DelayTime', 0.1, 'WriteMode','append');


Cells_matrix = zeros(size(C));
for i = 1:length(Cells)
    if (Cells(i, 3)) > 5
        Cells_matrix(Cells(i, 1), Cells(i, 2)) = 500;
    else
        Cells_matrix(Cells(i, 1), Cells(i, 2)) = 501;
    end
end
%figure(2)
%set(0, 'CurrentFigure', 2);
% subplot(1, 2, 2);
Spacer = ones(size(C, 1), 3) * 5;



imshow(horzcat(C, Spacer, Cells_matrix), map,  'InitialMagnification', 100, 'Border', 'tight');
% 
im = frame2im(getframe());
[A,map] = rgb2ind(im,256);
if (t == 1)
    imwrite(A, map, 'Model.gif', 'gif',  ...
        'DelayTime', 0.1);
end

imwrite(A, map, 'Model.gif', 'gif',  ...
    'DelayTime', 0.1, 'WriteMode','append');

%figure;
%contour(C);
% colorbar;
drawnow;
end