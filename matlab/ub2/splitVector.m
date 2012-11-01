% seperate x and y values from the coordinate list
function [x, y] = splitVector(data)
	x = data(1:2:end);
	y = data(2:2:end);
end
