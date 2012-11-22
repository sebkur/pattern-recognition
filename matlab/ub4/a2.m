% Daten laden
data = load('data.mod');
training = data(data(:,11) == 0,2:end-1);
testing  = data(data(:,11) == 1,2:end-1);

% Anzahl der Features insgesamt
n = size(testing, 2) - 1;
% für jede Anzahl zu verwendenen Features (Parameter)
for k = 1:n
	% mögliche Kombinationen von k Parametern aufstellen
	selection = nchoosek ([1:n], k);
	es = []; % Sammelarray für Fehler
	% für jede mögliche Parameterkombination
	for parameters = selection'
		idx = [parameters' n + 1];
		train = training(:,idx);
		test = testing(:,idx);
		e = calculateError(train, test);
		es(end+1) = e;
	end;
	es;
	% minimalen Fehler bestimmen
	[mine, minidx] = min(es);
	minParams = selection(minidx,:);
	printf('Fehler: %.3f, Parameterauswahl: %s\n', mine, mat2str(minParams));
end;
