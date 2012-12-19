function [ret, mean, cov, u] = normalize(inputData)	
	% Mittelwert der Daten berechnden
	mean = [mean(inputData(:,1:end-1)) 0];
	inputData = inputData - repmat(mean, size(inputData, 1), 1);
	
	% compute mu and covanriance matrix
	[mu, cov] = gauss(inputData);

	[u,s,v] = svd(cov);
	
	ret = inputData * u;
end
