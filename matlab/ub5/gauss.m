% Mittelwert und Kovarianzmatrix bestimmen
function [mu, cov] = gauss (samples)
        % compute average
        mu = mean(samples);

	dims = size(samples, 2);

	% compute covariance matrix
	cov = zeros(dims, dims);
	for sample = samples'
		cov += (sample - mu') * (sample' - mu);
	end

	cov = cov / size(samples, 1);

	% diffs = bsxfun(@minus, samples, mean(samples))
	% cov = diffs' * diffs
end
