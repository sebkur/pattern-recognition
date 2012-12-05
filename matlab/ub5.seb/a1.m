% Daten laden
data = load('data.mod');
% Testdaten von Trainingdaten trennen:
% Bei Trainingsdaten steht in der letzten Spalte eine 0,
% bei den Testdaten steht in der letzten Spalte eine 1.
% Außerdem weglassen der ersten Spalte, dort steht die Nummer
training = data(data(:,11) == 0,2:end-1);
testing  = data(data(:,11) == 1,2:end-1);

cnt = size(training)(1)

% normalisiere trainingsdaten
meanTraining = mean(training)
training = training .- repmat(meanTraining, cnt, 1);
varTraining = std(training,1)
normalizedTraining = training ./ repmat(varTraining, cnt, 1)

% Trenne abhängige von unabhängigen Daten
known = normalizedTraining(:,1:end-1); % lcavol, lweight, ..., pgg45

y = normalizedTraining(:,end); % lpsa

% Bestimme X durch Anfügen von 1-en vor die erste Spalte
X = augmentWithOnes(known);

hold on

% calculate singular value decomposition to get eigenvalues of X
d = svd(X);


for lambda = logspace(0.5,4.5,100) % chosen by looking
	% Alpha bestimmen mit Formel für ridge Regression
	alpha = (X' * X + lambda * eye(size(X' * X)))^(-1) * X' * y;
	dl = sum(d .^2 ./ (d .^2 + lambda))
	plot(repmat(dl, size(alpha)), alpha, "@")
end
hold off

print("a1.png");
print("a1.pdf");
