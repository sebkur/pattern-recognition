

% load computed results
load weights.mat W1 W2

testingData = load("-ascii", "pendigits-testing.txt");
trainingData = load("-ascii", "pendigits-training.txt");

% Mittelwert der Daten berechnden
move = [mean(trainingData(:,1:end-1)) 0];

% und Daten zum Ursprung verschieben
trainingData = trainingData - repmat(move, size(trainingData, 1), 1);
testingData = testingData - repmat(move, size(testingData, 1), 1);

% features von den labels trennen
featuresTraining = trainingData(:,1:end - 1);
featuresTesting = testingData(:,1:end - 1);
labelsTesting = testingData(:, end);

% compute mu and covanriance matrix
[mu, cov] = gauss(featuresTraining);

% eigenvektoren und eigenwerte berechnen
% eigenvektoren stehen in den spalten
% die wichtigste komponente steht ganz rechts
[u,s,v] = svd(cov);

% die labelmatrix zum Trainieren so aufbauen, dass an der entsprechenden Stelle eine 1 steht
labels = [];
for label = labelsTesting'
	row = zeros(1,10);
	row(label + 1) = 1;
	labels = [labels; row];
end

labelsTesting = labels;

% Daten auf die Eigenvektoren projizieren
testingPCA = featuresTesting * u;

% die unwichtigsten Hauptkomponenten wegwerfen
testingPCAn = testingPCA(:, 1:14);

testingPCAn = [testingPCAn, labelsTesting];

inputs = testingPCAn;

hits = 0
misses = 0

for input = inputs'
	% seperate the input from expected output
	output = input(end - 9: end);
	input = augmentWithOnes(input(1:end - 10)')';

	o1 = sigmoid(input' * W1);
	o2 = sigmoid(augmentWithOnes(o1) * W2);
	[bla, positive] = max(output);
	[bla, guess]    = max(o2);
	positive
	guess
	
	if positive == guess
		hits += 1;
	else
		misses += 1;
	end
end

hits
misses
coverage = hits / (hits + misses)
