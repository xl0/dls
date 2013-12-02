function [y1, x1] = chemotaxis(y, x, C)
	x1 = x;
	y1 = y;

	C_max = C(y, x);

	if (C_max < C(y, x - 1))
		C_max = C(y, x - 1);
		x1 = x - 1;
	end

	if (C_max < C(y, x + 1))
		C_max = C(y, x + 1);
		x1 = x + 1;
	end

	if (C_max < C(y - 1, x))
		C_max = C(y - 1, x);
		y1 = y - 1;
	end

	if (C_max < C(y + 1, x))
		C_max = C(y + 1, x);
		y1 = y + 1;
	end
		
	if (~mod(y, 2))
		if (C_max < C(y - 1, x - 1))
			C_max = C(y - 1, x - 1);
			x1 = x - 1;
			y1 = y - 1;
		end

		if (C_max < C(y + 1, x - 1))
			C_max = C(y + 1, x - 1);
			x1 = x - 1;
			y1 = y + 1;
		end
	else
		if (C_max < C(y - 1, x + 1))
			C_max = C(y - 1, x + 1);
			x1 = x + 1;
			y1 = y - 1;
		end

		if (C_max < C(y + 1, x + 1))
			C_max = C(y + 1, x + 1);
			x1 = x + 1;
			y1 = y + 1;
		end

	end

end
