% Klassifizieren alle Daten in 'features'. Trenne linear in class1 und class2
function predictions = hessian_classify(theta, r, class1, class2, features)
	% normale zu der Geradengleichung
	normal = [cos(theta); sin(theta)];
	% projiziere alle daten auf die Normale
	projections = (features*normal) * normal';
	% bestimme die Länge der Projektion
	norms = norm(projections, OPT='rows');
	% klassifiziere durch Vergleich mit dem Radius
	class1idx = find(norms < r);
	class2idx = find(1-(norms < r));
	predictions = zeros(size(features,1), 1);
	predictions(class1idx) = class1;
	predictions(class2idx) = class2;
end
