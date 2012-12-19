function [weights, errors] = batch(inputData, outputs, hiddenCnt, maxError, gamma, subsetSize)
	inputWidth = size(inputData, 2)
	outputWidth = size(outputs, 2)
	W1 = rand(inputWidth + 1, hiddenCnt) .- 0.5;
	W2 = rand(hiddenCnt + 1, outputWidth) .- 0.5;
	
	errors = [];
	
	error = inf
	while (error > maxError)
		error = 0;
		
		% generate a subset of inputs to fasten up the computation
		r = ceil((size(inputData, 1) - subsetSize) * rand());
		subsetInputs  = inputData(r:(r + subsetSize),:);
		subsetOutputs = outputs(r:(r + subsetSize),:);
		
		subset = [subsetInputs, subsetOutputs];
		
		for input = subset'
			% seperate the input from expected output
			output = input(end - (outputWidth - 1): end);
			input = augmentWithOnes(input(1:end - outputWidth)')';
			
			% forward propagation 
			o1 = sigmoid(input' * W1);
			o2 = sigmoid(augmentWithOnes(o1) * W2)';
			
			err = (o2 .- output);
			error += sum(0.5 .* err .^ 2);
			
			D1 = diag((o1 .* (1 .- o1)));
			D2 = diag((o2 .* (1 .- o2)));
			
			% the small W2 matrix
			W2s = W2(2:end,:);
			
			delta2 = D2 * err;
			delta1 = D1 * W2s * delta2;
			
			W1 -= (gamma * delta1 * input')';
			W2 -= (gamma * delta2 * augmentWithOnes(o1))';
			
		end
		
		error'
		errors = [errors, error];

	end
	
	weights = {W1, W2};
end
