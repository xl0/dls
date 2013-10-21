function Cells = generate_cells(xlim, ylim, density)


Tmp = zeros(ylim, xlim);

for i = 1:ylim
    for j = 1:xlim
        if (rand() < density)
            Tmp(i, j) = 1;
        end
    end
end

Cell_number = sum(sum(Tmp));

[i, j] = find(Tmp > 0);
Cells =  [i, j, 3 .* randn(length(i), 1), zeros(length(i), 1)];

end


