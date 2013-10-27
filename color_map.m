function map = color_map()

map = zeros(1, 3);

thresh = 50;


ls = linspace(0,1,thresh)';

map(1:thresh,1) = ls;
map(1:thresh,2) = ls;
map(1:thresh,3) = ls;

map(thresh + 1:499, 1) = 1;
map(thresh + 1:499, 2) = 1;
map(thresh + 1:499, 3) = 1;

% Red
map(500, 1) = 1;

%Yellow
map(501, 1) = 1;
map(501, 2) = 1;

%Green
map(502, 2) = 1;
end