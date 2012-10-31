function [vec, class] = separateSample(sample)
	vec = sample(1:end-1);
	class = sample(end);
end
