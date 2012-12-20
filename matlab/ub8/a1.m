penTrainingData = load("-ascii", "pendigits-training.txt");
ionTrainingData = load("-ascii", "ionosphere.data");


penFeaturesTraining = penTrainingData(:,1:end - 1);
penLabelsTraining = penTrainingData(:, end);

ionFeaturesTraining = ionTrainingData(:,1:end - 1);
ionLabelsTraining = ionTrainingData(:, end);

[penTrainingPCA, penMove, penCov, penU] = normalize(penFeaturesTraining);
[ionTrainingPCA, ionMove, ionCov, ionU] = normalize(ionFeaturesTraining);

% die labelmatrix zum Trainieren so aufbauen, dass an der entsprechenden Stelle eine 1 steht
penLabels = [];
for label = penLabelsTraining'
	row = zeros(1,10);
	row(label + 1) = 1;
	penLabels = [penLabels; row];
end
penLabelsTraining = penLabels;


% die unwichtigsten Hauptkomponenten wegwerfen
penTrainingPCAn = penTrainingPCA(:, 1:14);

% die unwichtigsten Hauptkomponenten wegwerfen
ionTrainingPCAn = ionTrainingPCA %(:, 1:14);

% arguments for online()/batch(): input, outputs, #hidden, maxError, gamma, subsetSize
[ionDigitsWeightsOnline, ionDigitsErrorsOnline] = online(ionTrainingPCAn, ionLabelsTraining, 35, 0.5, 0.05, 100)
save ionOnline.mat ionDigitsWeightsOnline ionDigitsErrorsOnline

[ionDigitsWeightsBatch, ionDigitsErrorsBatch] = batch(ionTrainingPCAn, ionLabelsTraining, 35, 0.5, 0.05, 100)
save ionBatch.mat ionDigitsWeightsBatch ionDigitsErrorsBatch

[penDigitsWeightsOnline, penDigitsErrorsOnline] = online(penTrainingPCAn, penLabelsTraining, 35, 0.8, 0.05, 100)
save penOnline.mat penDigitsWeightsOnline penDigitsErrorsOnline

[penDigitsWeightsBatch, penDigitsErrorsBatch] = batch(penTrainingPCAn, penLabelsTraining, 35, 0.8, 0.05, 100)
save penBatch.mat penDigitsWeightsBatch penDigitsErrorsBatch

