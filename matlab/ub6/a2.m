% zufälliger Vektor
w = rand([1, 4]) * 2 - 1;

% Trainingsdaten generieren
N = 10000;
X = 2 * rand([N, 3]) - 1;
X = [ones(N, 1) X];

% Labels bestimmen
y = (X * w') >= 0;

% mit Perzeptron lernen
pw = perzeptron(X, y);

% Vorhersage mit dem gelernten w
prediction = (X * pw') >= 0;

% Vorhersage bewerten
nwrong = sum(prediction != y);
relativeError = nwrong / N
