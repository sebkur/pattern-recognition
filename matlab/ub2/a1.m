% lade Daten
trainingData = load("-ascii", "pendigits-training.txt");

%trainingData = trainingData (1:500,:);

%trainingPoints = trainingData(:,1:end-1);

mkdir pics

% loop over all digits
for digit = 0:9
	% select all samples labeled with 'digit'
	samples = trainingData(trainingData(:,17) == digit,:);
	% compute average
	digitmean = mean(samples);
	% plot digit
	[coordinates, label] = separateSample(digitmean);
	namePdf = sprintf ("pics/digit-%d.pdf", digit)
	namePng = sprintf ("pics/digit-%d.png", digit)
	plotDigit(coordinates, num2str(label), namePdf, namePng);
end
