% lade Daten
trainingData = load("-ascii", "pendigits-training.txt");
testingData = load("-ascii", "pendigits-testing.txt");

%Teilaufgabe 1:
% multivariante Gaussverteilung der Klassen bestimmen

covariances = {};

for digit = 0:9
	% select all samples labeled with 'digit'
	samples = trainingData(trainingData(:,17) == digit,:)(:,1:end - 1);
	% compute average
	coordinates = mean(samples);
	
	% compute covariance matrix
	cov = zeros(16,16);
	for sample = samples'
		cov += (sample - coordinates') * (sample' - coordinates);
	end
	
	% normalize
	cov = cov / size(samples)(1);
	
	% add some noise
	cov += 0.01;
	
	covariances{digit + 1} = {cov, coordinates};
end

covariances;

confusionMatrix = zeros(10,10);

for sample = testingData'
	[vec, class] = separateSample(sample');
	% calculate maximum likely class
	bestProb = 0;
	bestClass = 0;
	counter = 1;
	for cluster = covariances
		cov = cluster{1}{1};
		meanVec = cluster{1}{2};
		likelyhood = 1 / (2 * pi * sqrt(det(cov))) * e^(-0.5 * (vec - meanVec) * cov^-1 * (vec - meanVec)');
		if (likelyhood >= bestProb)
			bestProb = likelyhood;
			bestClass = counter;
		end
		counter += 1;
	end
	confusionMatrix(bestClass, class + 1) += 1;
end

confusionMatrix
