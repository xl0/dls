function array = cart_neighbours(y, x, ylim, xlim)
array = [];

if (x > 1)
    array = [array, y + (x - 1 - 1) * ylim];
end

if (x < xlim)
    array = [array, y + (x - 1 + 1) * ylim];
end

if (y > 1)
    array = [array, y - 1 + (x - 1) * ylim];
end

if (y < ylim)
    array = [array, y + 1 + (x - 1) * ylim];
end


end