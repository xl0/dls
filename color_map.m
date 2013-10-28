function map = color_map()

map = zeros(1, 3);

thresh1 = 50;
thresh2 = 60;

ls = linspace(0,1,thresh2 - thresh1)';

map(thresh1:thresh2-1,1) = ls;
map(thresh1:thresh2-1,2) = ls;
map(thresh1:thresh2-1,3) = ls;

map(thresh2 + 1:499, 1) = 1;
map(thresh2 + 1:499, 2) = 1;
map(thresh2 + 1:499, 3) = 1;

% Red
map(500, 1) = 1;

%Yellow
map(501, 1) = 1;
map(501, 2) = 1;

%Green
map(502, 2) = 1;
end
