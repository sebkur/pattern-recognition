% separate coordinates from label
function [coordinates, label] = separateSample(sample)
	coordinates = sample(1:end-1);
	label = sample(end);
end
