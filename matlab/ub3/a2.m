trainingData = load("-ascii", "pendigits-training.txt");
testingData = load("-ascii", "pendigits-testing.txt");

mus = {};
covariances = {};

for digit = 0:9
        % select all samples labeled with 'digit'
        samples = trainingData(trainingData(:,17) == digit,:)(:,1:end - 1);
	% compute mu and covanriance matrix
	[mu, cov] = gauss(samples);
	% store for later usage
	mus{digit + 1} = mu;
	covariances{digit + 1} = cov;
end

digitA = 0;
digitB = 1;
[ncorrect, nwrong] = fisher(mus, covariances, testingData, digitA, digitB)

results = zeros(10,10);

%arrayfun(@(i,j) results(i,j) = 1, [1:3], [1:3])
%arrayfun(@(i) results(i, i) = 1, [1:3])

%results(1,1) = 1;
%results


% [probsA1, probsB1, classes1] = arrayfun(@(x) bayes(x, muA1, muB1, covA1, covB1), pA);

%for digitA = 0:2
%	for digitB = 0:2
%		if (digitA != digitB)
%			[digitA, digitB]
%			[ncorrect, nwrong] = fisher(mus, covariances, testingData, digitA, digitB)
%		end
%	end
%end
