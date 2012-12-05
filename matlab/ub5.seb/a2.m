% Daten laden
data = load('data.mod');
data = data(:,2:end-1);

% relevante Daten auswählen
sdata = data(:, [1 5 7 end]);

% hier speichern wir die Koeffizienten,
% ein Quadrupel von Koeffizienten je Zeile
coefficients = [];

% 100 Experimente durchführen
for x = 1:100
	% 50 Datensätze auswählen
	idx = randint(50, 1, [1,size(data, 1)]);
	d = sdata(idx, :);
	% Koeffizenten berechnen und abspeichern
	alphas = linreg(d)';
	coefficients = [coefficients; alphas];
end

% 10 Testdatensätze nehmen und Einsen anfügen
knownTest = sdata(1:10,1:end-1);
Xtest = augmentWithOnes(knownTest);

% Vorhersagen mit allen Koeffizientenvektoren
predictions = Xtest * coefficients';
% Mittelwert und Standardabweichung ausrechnen
mus = mean(predictions, 2);
diffs = predictions - repmat(mus, 1, size(predictions, 2));
sigmas = sum(diffs.^2, 2) / size(predictions, 2);

% Ausgabeoptionen
output_max_field_width(3);

% für die Ausgabe transponieren :)
mus = mus'
sigmas = sigmas'
