

% load computed results
load weights.mat W1 W2

testingData = load("-ascii", "pendigits-training.txt");

% Mittelwert der Daten berechnden
move = [mean(testingData(:,1:end-1)) 0];
% und Daten zum Ursprung verschieben
testingData = testingData - repmat(move, size(testingData, 1), 1);

% features von den labels trennen
featuresTesting = testingData(:,1:end - 1);
labelsTesting = testingData(:, end);

% compute mu and covanriance matrix
[mu, cov] = gauss(featuresTesting);

% eigenvektoren und eigenwerte berechnen
% eigenvektoren stehen in den spalten
% die wichtigste komponente steht ganz rechts
[v, lambda] = eig(cov);

% die labelmatrix zum Trainieren so aufbauen, dass an der entsprechenden Stelle eine 1 steht
labels = [];
for label = labelsTesting'
	row = zeros(1,10);
	row(label + 1) = 1;
	labels = [labels; row];
end

labelsTesting = labels;

% Daten auf die Eigenvektoren projizieren
testingPCA = [featuresTesting * v, labelsTesting];

% die unwichtigsten Hauptkomponenten wegwerfen
testingPCAn = testingPCA(:,end - 23:end);


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
