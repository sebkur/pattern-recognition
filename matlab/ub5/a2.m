% Daten laden
data = load('data.mod');
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
