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

% Daten auf die Eigenvektoren projizieren
trainingPCA = [featuresTraining * v, labelsTraining];
testingPCA = [featuresTesting * v, labelsTesting];

% für je zwei Ziffern paarweise linear trennen mit
% Fisher's Diskriminante und die Anzahl der korrekt / falsch
% klassifizierten Daten merken
% --> hier mit den Originaldaten als Vergleichswert
[correctNormal, wrongNormal] = dofisher(trainingData, testingData);

% anzahl der zu entfernden Dimensionen
for remove = 0:6
	% die unwichtigsten Hauptkomponenten wegwerfen
	trainingPCAn = trainingPCA(:,remove + 1:end);
	testingPCAn = testingPCA(:,remove + 1:end);

	% Nochmal paarweise Fisher.
	% --> hier mit den dimensionsreduzierten Daten nach PCA
	[correctPCA, wrongPCA] = dofisher(trainingPCAn, testingPCAn);

	% Anzahl der entfernten Dimensionen ausgeben
	remove
	% Differenz der korrekt klassifizieren Daten ausrechnen,
	% als Vergleich zur Klassifzierung auf den Originaldaten
	correctPCA - correctNormal
	total = sum((correctPCA - correctNormal)(:))
end
