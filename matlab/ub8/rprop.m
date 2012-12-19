function [weights, errors] = rprop(inputData, outputs, hiddenCnt, maxError, gammaMin, gammaMax, u, d, subsetSize)
	inputWidth = size(inputData, 2)
	outputWidth = size(outputs, 2)
	W1 = rand(inputWidth + 1, hiddenCnt) .- 0.5;
	W2 = rand(hiddenCnt + 1, outputWidth) .- 0.5;
	
	gammaMax1 = repmat(gammaMax, size(W1));
	gammaMax2 = repmat(gammaMax, size(W2));
	
	gammaMin1 = repmat(gammaMin, size(W1));
	gammaMin2 = repmat(gammaMin, size(W2));
	
	gamma1 = gammaMax1;
	gamma2 = gammaMax2;
	
	errors = [];
	
	error = inf
	while (error > maxError)
		error = 0;
		
		% generate a subset of inputs to fasten up the computation
		r = ceil((size(inputData, 1) - subsetSize) * rand());
		subsetInputs  = inputData(r:(r + subsetSize),:);
		subsetOutputs = outputs(r:(r + subsetSize),:);
		
		subset = [subsetInputs, subsetOutputs];
		
		last_correction1 = zeros(size(W1));
		last_correction2 = zeros(size(W2));
		
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
			
			W2s = W2(2:end,:);
			
			delta2 = D2 * err;
			delta1 = D1 * W2s * delta2;
			
			correction1 = (delta1 * input')';
			correction2 = (delta2 * augmentWithOnes(o1))';
			
			gamma1 = 	(min(gamma1 * u, gammaMax1) .* (last_correction1 .* correction1 > 0)) .+ ...
						(max(gamma1 * d, gammaMin1) .* (last_correction1 .* correction1 < 0)) .+ ...
						(gamma1 .* (last_correction1 .* correction1 == 0));
						
			gamma2 = 	(min(gamma2 * u, gammaMax2) .* (last_correction2 .* correction2 > 0)) .+ ...
						(max(gamma2 * d, gammaMin2) .* (last_correction2 .* correction2 < 0)) .+ ...
						(gamma2 .* (last_correction2 .* correction2 == 0));
			
			W1 -= gamma1 .* sign(correction1);
			W2 -= gamma2 .* sign(correction2);
			
			last_correction1 = correction1;
			last_correction2 = correction2;
		end
		
		error'
		errors = [errors, error];

	end
	
	weights = {W1, W2};
end


ionTrainingData = load("-ascii", "ionosphere.data");

ionFeaturesTraining = ionTrainingData(:,1:end - 1);
ionLabelsTraining = ionTrainingData(:, end);


[ionTrainingPCA, ionMove, ionCov, ionU] = normalize(ionFeaturesTraining);


% die unwichtigsten Hauptkomponenten wegwerfen
ionTrainingPCAn = ionTrainingPCA %(:, 1:14);

[ionDigitsWeightsOnline, ionDigitsErrorsOnline] = rprop(ionTrainingPCAn, ionLabelsTraining, 35, 0.5, 0.0001, 0.05, 1, 1, 100)
