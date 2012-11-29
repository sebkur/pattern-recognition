% Daten laden
data = load('data.mod');
% Testdaten von Trainingdaten trennen:
% Bei Trainingsdaten steht in der letzten Spalte eine 0,
% bei den Testdaten steht in der letzten Spalte eine 1.
% Außerdem weglassen der ersten Spalte, dort steht die Nummer
training = data(data(:,11) == 0,2:end - 1);

cnt = size(training)(1)

% Trenne abhängige von unabhängigen Daten
known   = training(:,[1,5,7]); % lcavol, lweight, ..., pgg45
test    = known([1:10],:) % die ersten 10 Samples
classes = training([1:10],end);
alpha = []

hold on
for i = 1:100
	samples = ceil(rand(50,1) *  cnt);
	
	X = known(samples,:);
	y = training(samples,end);
	
	alph = (X' * X)^(-1) * X' * y;
	alpha = [alpha, alph];
	
	testPrediction = [];
	for sample = test'
		testPrediction = [testPrediction, alph' * sample];
	end
	testPredMean = mean(testPrediction)
	sigma = cov(testPrediction)
	plot(i, testPredMean, "@");
	plot(i, testPredMean + sigma, "x");
	plot(i, testPredMean - sigma, "x");
end

hold off
mkdir pics
print("pics/aufgabe2.png")

pause

