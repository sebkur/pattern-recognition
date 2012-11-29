<<<<<<< HEAD
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
=======
% Daten laden
trainingData = load("-ascii", "pendigits-training.txt");
% wir arbeiten mit der Acht
digit = 8;

% select all samples labeled with 'digit'
samples = trainingData(trainingData(:,17) == digit,:)(:,1:end - 1);

% compute mu and covanriance matrix
[mu, cov] = gauss(samples);

% plot the mean vector
plotDigit(mu, int2str(digit), 'mean.pdf', 'mean.png')

% select a random vector as x0
x0 = normalize(rand(1, 16)');
% start with xk = x0
xk = x0;
for k = 0:14
	clf;
	% create a plot of the iteration
	label = sprintf('iteration %d', k);
	pdfname = sprintf('iteration%d.pdf', k);
	pngname = sprintf('iteration%d.png', k);
	plotDigit(xk, label, pdfname, pngname);
	% multiply xk with the covariance matrix
	xk = normalize(cov * xk);
end
>>>>>>> 3cf852a9da54141e02777119287189b19300391e
