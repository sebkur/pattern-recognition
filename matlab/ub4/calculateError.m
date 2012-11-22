function e = calculateError(training, testing)
	% Trenne abhängige von unabhängigen Daten
	known = training(:,1:end-1);
	y = training(:,end);
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
	predictionTesting = XTest * alpha;
	% Abweichunng bestimmen
	deviationTesting = yTest - predictionTesting;
	% Fehlerquadrate berechnen
	errorTesting = deviationTesting .^2;
	% Summe der Fehlerquadrate
	e = sum(errorTesting);
end;
