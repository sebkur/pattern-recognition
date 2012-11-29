% Daten laden
data = load('data.mod');
<<<<<<< HEAD
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

=======
data = data(:,2:end-1);

sdata = data(:, [1 5 7 end]);

results = [];

for x = 1:100
	idx = randint(50, 1, [1,size(data, 1)]);
	d = sdata(idx, :);
	alphas = linreg(d)';
	results = [results; alphas];
end

results



%minerrors = {};
%errors = {};
%
%% Anzahl der Features insgesamt
%n = size(testing, 2) - 1;
%% für jede Anzahl zu verwendenen Features (Parameter)
%for k = 1:n
%	% mögliche Kombinationen von k Parametern aufstellen
%	selection = nchoosek ([1:n], k);
%	es = []; % Sammelarray für Fehler
%	% für jede mögliche Parameterkombination
%	for parameters = selection'
%		% Trainings- und Testdaten zusammenbauen
%		idx = [parameters' n + 1];
%		train = training(:,idx);
%		test = testing(:,idx);
%		% Fehlerquadratsummen berechnen
%		e = calculateError(train, test);
%		es(end+1) = e;
%	end;
%	% minimalen Fehler bestimmen
%	[mine, minidx] = min(es);
%	minParams = selection(minidx,:);
%	printf('k: %d, Fehler: %.3f, Parameterauswahl: %s\n', k, mine, mat2str(minParams));
%
%	% speichern für späteren Gebrauch
%	minerrors{k} = e;
%	errors{k} = es;
%end;
%
%% plotting
%figure;
%hold on;
%for k = 1:n
%	plot(k, errors{k}, '+bx');
%end;
%xlabel('Anzahl der Parameter');
%ylabel('Summe des quadratischen Fehlers');
%print("results1.png");
%
%figure;
%hold on;
%for k = 1:n
%	plot(k, minerrors{k}, '+bx');
%end;
%xlabel('Anzahl der Parameter');
%ylabel('Summe des quadratischen Fehlers');
%print("results2.png");
>>>>>>> 3cf852a9da54141e02777119287189b19300391e
