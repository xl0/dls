function show_concentration(C)

[x, y] = size(C);

imshow(C, [0 max(max(C))], 'InitialMagnification', 200);
%figure;
%contour(C);
colorbar;
drawnow;
end