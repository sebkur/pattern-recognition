
function [s ds] = sigmoid(val)
	s = 1 ./ (1 .+ e.^(-val * 2));
	ds = s .* (1 .- s);
end

inputs  = [	[0, 0, 0]; ...
			[0, 1, 1]; ...
			[1, 0, 1]; ...
			[1, 1, 0]]

W1 = rand(3,2);
W2 = rand(3,1);

gamma = 0.1;

error = inf
errorOverTime = [];
while (error > 0.01)
	error = 0;
	correction1 = zeros(size(W1));
	correction2 = zeros(size(W2));
	
	for input = inputs'
		% seperate the input from expected output
		output = input(end);
		input = augmentWithOnes(input(1:end - 1)')';
		
		% forward propagation 
		o1 = sigmoid(input' * W1);
		o2 = sigmoid(augmentWithOnes(o1) * W2);
		
		e = (o2 .- output);
		error += 0.5 * e^2;
		
		D1 = diag((o1 .* (1 .- o1)));
		D2 = diag((o2 .* (1 .- o2)));
		
		% the small W2 matrix
		W2s = W2(2:end,:);
		
		delta2 = D2 * e;
		delta1 = D1 * W2s * delta2;
		
		correction1 -= (gamma * delta1 * input')';
		correction2 -= (gamma * delta2 * augmentWithOnes(o1))';
	end
	
	W1 += correction1;
	W2 += correction2;
	error
	errorOverTime = [errorOverTime, error];
end

W1
W2

for input = inputs'
	% seperate the input from expected output
	output = input(end)
	input = augmentWithOnes(input(1:end - 1)')'
	o1 = sigmoid(input' * W1);
	o2 = sigmoid(augmentWithOnes(o1) * W2)
	
end

plot(errorOverTime);
pause
