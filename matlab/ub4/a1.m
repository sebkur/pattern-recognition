% Daten laden
data = load("data.mod");
% Testdaten von Trainingdaten trennen:
% Bei Trainingsdaten steht in der letzten Spalte eine 0,
% bei den Testdaten steht in der letzten Spalte eine 1.
% Außerdem weglassen der ersten Spalte, dort steht die Nummer
training = data(data(:,11) == 0,2:end-1);
testing  = data(data(:,11) == 1,2:end-1);

% Trenne abhängige von unabhängigen Daten
known = training(:,1:end-1); % lcavol, lweight, ..., pgg45
y = training(:,end); % lpsa
% Bestimme X durch Anfügen von 1-en vor die erste Spalte
X = augmentWithOnes(known);
% Alpha bestimmen mit Formel für lineare Regression
alpha = (X' * X)^(-1) * X' * y;

% Trenne abhängige von unabhängigen Daten
knownTest = testing(:,1:end-1);
yTest = testing(:,end);
% Bestimme X für die Testdaten
XTest = augmentWithOnes(knownTest);

% Vorhersage ausrechnen
predictionTraining = X * alpha;
predictionTesting = XTest * alpha;

% Abweichunng bestimmen
deviationTraining = y - predictionTraining;
deviationTesting = yTest - predictionTesting;

% Fehlerquadrate berechnen
errorTraining = deviationTraining .^2;
errorTesting = deviationTesting .^2;

% Summe der Fehlerquadrate
printf("Summe der Fehlerquadrate der Trainingsdaten:\n");
sum(errorTraining)
printf("Summe der Fehlerquadrate der Testdaten:\n");
sum(errorTesting)

% Durchschnittlicher Fehlerquadrate
printf("Durchschnittliches Fehlerquadrat der Trainingsdaten:\n");
sum(errorTraining) / size(errorTraining, 1)
printf("Durchschnittliches Fehlerquadrat der Testdaten:\n");
sum(errorTesting) / size(errorTesting, 1)
