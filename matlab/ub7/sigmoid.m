function [s ds] = sigmoid(val)
	s = 1 ./ (1 .+ e.^(-val * 1.0));
	ds = s .* (1 .- s);
end
