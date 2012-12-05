% Mittelwert und Kovarianzmatrix bestimmen
function [mu, cov] = gauss (samples)
        % compute average
        mu = mean(samples);

	s = size(samples, 2);
	% compute covariance matrix
	cov = zeros(s, s);
	for sample = samples'
		cov += (sample - mu') * (sample' - mu);
	end

	cov = cov / size(samples)(1);
end;
