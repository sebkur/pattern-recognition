function prediction = hessian_classify(theta, r, class1, class2, features)
	normal = [cos(theta); sin(theta)];
	projection = (features * normal) * normal;
	if norm(projection) < r
		prediction = class1;
	else 
		prediction = class2;
	end
end
