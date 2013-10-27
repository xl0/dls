function Cells = generate_cells(P)


Tmp = zeros(P.ylim, P.xlim);

for i = 2:P.ylim-1
    for j = 2:P.xlim-1
        if (rand() < P.Cell_density)
            Tmp(i, j) = 1;
        end
    end
end

Cell_number = sum(sum(Tmp));

[i, j] = find(Tmp > 0);
Cells =  [i, j, 3 .* randn(length(i), 1), ones(length(i), 1) * P.E_zero];

end


