function c = binary_permutations(k)
	k = 9;
	n = 2^k;
	a = arrayfun(@(i) bitget(i, [1:k]), 0:n-1, "UniformOutput", false);
	b = cell2mat(a);
	c = reshape(b, 9, n)';
end
