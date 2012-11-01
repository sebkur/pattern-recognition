% lade Daten
trainingData = load("-ascii", "pendigits-training.txt");
testData = load("-ascii", "pendigits-testing.txt");

for i = 0:9
	cluster = trainingData(find(trainingData(:,17) == i),:);
	meanAll = sum(cluster) ./ size(cluster)(1)
	[meanVec, meanClass] = separateSample(meanAll);
	[x, y] = splitVector(meanVec);
	plot(x,y);
	pause;
end
