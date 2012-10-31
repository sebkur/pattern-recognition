% lade Daten
trainingData = load("-ascii", "pendigits-training.txt");
testData = load("-ascii", "pendigits-testing.txt");

trainingCount = size(trainingData)(1)
testCount = size(testData)(1)

% produce some outputs
for i = 1:10
	sample = trainingData(i,:);
	[sample, class] = separateSample(sample);
	[x, y] = splitVector(sample);
	plot(x,y);
	legend(num2str(class));
	name = sprintf ("pics/pic-%d.png", i)
	print(name);
end
