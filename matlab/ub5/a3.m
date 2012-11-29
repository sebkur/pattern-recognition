% lade Daten
trainingData = load("-ascii", "pendigits-training.txt");

mkdir pics

digit = 3
% select all samples labeled with 'digit'
samples = trainingData(trainingData(:,17) == digit,:)(:,1:end - 1);
% compute average
mu = mean(samples);

% compute covariance matrix
cov = zeros(16,16);
for sample = samples'
	cov += (sample - mu') * (sample' - mu);
end
	
[u, d, t] = svd(cov);

x = rand(16,1);

for i = 1:100
	x = cov * x;
	x = 1/(sqrt(x'*x)) * x; % normalisieren
end

t(:,1) .- x
