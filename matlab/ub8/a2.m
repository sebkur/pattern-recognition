trainingData = load("-ascii", "pendigits-training.txt");

featuresTraining = trainingData(:,1:end - 1);
labelsTraining = trainingData(:, end);

% die labelmatrix zum Trainieren so aufbauen, dass an der entsprechenden Stelle eine 1 steht
labels = [];
for label = labelsTraining'
	row = zeros(1,10);
	row(label + 1) = 1;
	labels = [labels; row];
end
labelsTraining = labels;

[trainingPCA, move, cov, u] =normalize(featuresTraining)

% die unwichtigsten Hauptkomponenten wegwerfen
trainingPCAn = trainingPCA(:, 1:14);

gamma = 0.05;
subsetSize = 100
noise = 0.00

[weights, errors] = online(trainingPCAn, labelsTraining, 35, 0.01, 0.05, 100)

% save computed results
save weights.mat W1 W2


