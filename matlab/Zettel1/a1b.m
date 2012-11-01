% lade Daten
trainingData = load("-ascii", "pendigits-training.txt");
testData = load("-ascii", "pendigits-testing.txt");

%trainingData = trainingData (1:5,:);
%testData = testData (1:1000,:);

hits = 0;
misses = 0;

trainingPoints = trainingData(:,1:end-1);
testPoints = testData(:,1:end-1);

% loop over all indices of test records
for n = 1:size(testPoints, 1)
	% fetch test record (t is a row vector)
	t = testPoints(n,:);
	% create a block matrix with t repeated in each row
	tp = repmat(t, size(trainingPoints, 1), 1);
	% subtract training data MINUS block matrix
	% i.e. subtract t from each training record
	diffs = trainingPoints - tp;
	% square each difference
	squareddiffs = diffs .^ 2;
	% sum row-wise
	dists = sum(squareddiffs, 2);
	% select the one with minimum distance
	% x is the min element and ix is its index
	[x, ix] = min(dists);
	% get class of nearest neighbour
	guessedClass = trainingData(ix,17);
	% get class of test record
	trueClass = testData(n,17);

	if guessedClass == trueClass
		hits = hits + 1;
	else
		misses = misses + 1;
	end
end

hits
misses

successRate = hits / (hits+misses)
failureRate = misses / (hits+misses)
