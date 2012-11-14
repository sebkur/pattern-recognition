% Mittelwert und Kovarianzmatrix bestimmen
function [mu, cov] = gauss (samples)
        % compute average
        mu = mean(samples);

	% compute covariance matrix
	cov = zeros(16,16);
	for sample = samples'
		cov += (sample - mu') * (sample' - mu);
	end

	cov = cov / size(samples)(1);
end;
