function alpha = linreg(data)
	% Trenne abhängige von unabhängigen Daten
	known = data(:,1:end-1);
	y = data(:,end);
	% Bestimme X durch Anfügen von 1-en vor die erste Spalte
	X = augmentWithOnes(known);
	% Alpha bestimmen mit Formel für lineare Regression
	alpha = (X' * X)^(-1) * X' * y;
end
