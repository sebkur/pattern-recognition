function predictions = hessian_classify(theta, r, class1, class2, features)
	normal = [cos(theta); sin(theta)];
	projections = (features*normal) * normal';
	norms = norm(projections, OPT='rows');
	class1idx = find(norms < r);
	class2idx = find(1-(norms < r));
	predictions = zeros(size(features,1), 1);
	predictions(class1idx) = class1;
	predictions(class2idx) = class2;
end
