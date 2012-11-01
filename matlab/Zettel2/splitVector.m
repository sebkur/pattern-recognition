function [x, y] = splitVector(data)
	w = length(data);
	x = []; y = [];
	for i = 1:2:(w - 1)
		x = [x , data(i)];
		y = [y , data(i + 1)];
	end
end
