function map = color_map()

map = zeros(1, 3);

ls = linspace(0,1,50)';

map(1:50,1) = ls;
map(1:50,2) = ls;
map(1:50,3) = ls;

map(51:499, 1) = 1;
map(51:499, 2) = 1;
map(51:499, 3) = 1;

% Red
map(500, 1) = 1;

%Yellow
map(501, 1) = 1;
map(501, 2) = 1;

%Green
map(502, 2) = 1;
end