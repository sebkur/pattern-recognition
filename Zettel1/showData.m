trainingData = load("-ascii", "pendigits-training.txt");
testData = load("-ascii", "pendigits-testing.txt");

% produce some outputs
for i = 1:100
	sample = trainingData(i,:);
	[sample, class] = separateSample(sample);
	[x, y] = splitVector(sample);
	plot(x,y);
	legend(num2str(class));
	pause;
end
