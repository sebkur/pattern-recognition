trainingData = load("-ascii", "pendigits-training.txt");
testingData = load("-ascii", "pendigits-testing.txt");

% Mittelwert der Daten berechnden
move = [mean(trainingData(:,1:end-1)) 0];
% und Daten zum Ursprung verschieben
trainingData = trainingData - repmat(move, size(trainingData, 1), 1);
testingData = testingData - repmat(move, size(testingData, 1), 1);

% features von den labels trennen
featuresTraining = trainingData(:,1:end - 1);
labelsTraining = trainingData(:, end);

featuresTesting = testingData(:,1:end - 1);
labelsTesting = testingData(:, end);

% compute mu and covanriance matrix
[mu, cov] = gauss(featuresTraining);

% eigenvektoren und eigenwerte berechnen
% eigenvektoren stehen in den spalten
% die wichtigste komponente steht ganz rechts
[v, lambda] = eig(cov);

% die labelmatrix zum Trainieren so aufbauen, dass an der entsprechenden Stelle eine 1 steht
labels = [];
for label = labelsTraining'
	row = zeros(1,10);
	row(label + 1) = 1;
	labels = [labels; row];
end
labelsTraining = labels;

% Daten auf die Eigenvektoren projizieren
trainingPCA = [featuresTraining * v, labelsTraining];
testingPCA = [featuresTesting * v, labelsTesting];

% die unwichtigsten Hauptkomponenten wegwerfen
trainingPCAn = trainingPCA(:, end - 23:end);
testingPCAn = testingPCA(:,end - 14:end);


inputs = trainingPCAn;

W1 = 1 * rand(15,35);
W2 = 1 * rand(36,10);

gamma = 0.05;
subsetSize = 150
noise = 0.00

error = inf
while (mean(error) > 0.2)
	error = 0;
	correction1 = zeros(size(W1));
	correction2 = zeros(size(W2));
	
	% add some noise 
	W1 += noise * (rand(size(W1)) -0.5);
	W2 += noise * (rand(size(W2)) -0.5);
	
	% generate a subset of inputs to fasten up the computation
	size(inputs, 1);
	r = ceil((size(inputs, 1) - subsetSize) * rand());
	subset = inputs(r:(r + subsetSize),:);
	
	for input = subset'
		% seperate the input from expected output
		output = input(end - 9: end);
		input = augmentWithOnes(input(1:end - 10)')';
		
		% forward propagation 
		o1 = sigmoid(input' * W1);
		o2 = sigmoid(augmentWithOnes(o1) * W2)';
		
		e = (o2 .- output);
		error += 0.5 .* e.^2;
		
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
	
	mean(error)
end

W1
W2

% save computed results
save weights.mat W1 W2


