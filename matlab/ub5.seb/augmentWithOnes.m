function X = augmentWithOnes(D)
	X = [ones(size(D, 1), 1), D];
end;
