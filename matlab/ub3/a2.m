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

% fisher für zwei klassen ausführen
%[ncorrect, nwrong] = fisher(mus, covariances, testingData, 0, 1)

% fisher für alle paare von zwei klassen ausführen
split_long_rows(false);
output_max_field_width(2);
n = 9;
[correct, wrong] = arrayfun(@(i,j) fisher(mus, covariances, testingData, i, j), \
	repmat([0:n], n+1, 1), repmat([0:n], n+1, 1)')
correct ./ (correct + wrong)
