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


[ionWeightsRPROP, ionErrorsRPROP] = rprop(ionTrainingPCAn, ionLabelsTraining, 35, 0.05, 0.0001, 0.5, 1.2, 0.5, 100)
[penWeightsRPROP, penErrorsRPROP] = rprop(penTrainingPCAn, penLabelsTraining, 35, 0.505, 0.0001, 0.5, 1.2, 0.5, 100)
save rprop.mat ionErrorsRPROP penErrorsRPROP

