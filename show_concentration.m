function show_concentration(C, Cells)


subplot(1, 2, 1);
imshow(C, [0 10], 'InitialMagnification', 500);

subplot(1, 2, 2);

Cells_matrix = zeros(size(C));
for i = 1:length(Cells)
    Cells_matrix(Cells(i, 1), Cells(i, 2)) = 1; 
end
imshow(Cells_matrix, 'InitialMagnification', 500);

%figure;
%contour(C);
% colorbar;
drawnow;
end