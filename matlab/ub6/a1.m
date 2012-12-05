trainingData = load("-ascii", "pendigits-training.txt");
testingData = load("-ascii", "pendigits-testing.txt");

% Mittelwert der Daten berechnden
move = [mean(trainingData(:,1:end-1)) 0];
% und Daten zum Ursprung verschieben
trainingData = trainingData - repmat(move, size(trainingData, 1), 1);
testingData = testingData - repmat(move, size(testingData, 1), 1);

%% select all samples labeled with 'digit'
%digit = 3;
%samples = trainingData(trainingData(:,17) == digit,:)(:,1:end - 1);

samplesTraining = trainingData(:,1:end - 1);
labelsTraining = trainingData(:, end);

samplesTesting = testingData(:,1:end - 1);
labelsTesting = testingData(:, end);

% compute mu and covanriance matrix
[mu, cov] = gauss(samplesTraining);

% eigenvektoren und eigenwerte berechnen
% eigenvektoren stehen in den spalten
% die wichtigste komponente steht ganz rechts
[v, lambda] = eig(cov);

% Daten auf die Eigenvektoren projizieren
trainingPCA = [samplesTraining * v, labelsTraining];
testingPCA = [samplesTesting * v, labelsTesting];

% die unwichtigsten Hauptkomponenten wegwerfen
trainingPCA = trainingPCA(7:end);
testingPCA = testingPCA(7:end);

% TODO: fisher aufrufen, mit
% 1. trainingData und testingData
% 2. trainingPCA und testingPCA
