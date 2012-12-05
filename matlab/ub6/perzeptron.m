function bestW = perzeptron(X, y)
	len = size(X, 2);
	w = rand([1, len]) * 2 - 1;
	w = w / norm (w);

	maxIterations = log10(size(X, 1)) * 50;
	% Zähler für Iterationen als zusätzliches Abbruchkriterium
	iteration = 1;
	% beste Lösung merken
	bestNWrong = Inf;
	while true && iteration <= maxIterations
		iteration ++;
		% vorhersage ausrechnen
		prediction = X * w' >= 0;
		% falsch klassifizierte daten finden
		wrong = find(prediction != y);
		% wenn alles richtig klassifiziert -> ende
		nwrong = size(wrong, 1);
		if nwrong < bestNWrong
			bestNWrong = nwrong;
			bestW = w;
		end;
		if nwrong == 0
			break
		end
		% ansonsten, wähle zufällige einen falsch
		% klassifizierten vektor aus
		wk = randint(1,1, [1, nwrong]);
		% den index des wk-ten falschen Vektors bestimmen
		k = wrong(wk);

		% hole den k-ten Vektor
		x = X(k,:);
		if y(k)
			% x ist aus P
			w = w + x;
		else
			% x ist aus N
			w = w - x;
		end
	end
end
