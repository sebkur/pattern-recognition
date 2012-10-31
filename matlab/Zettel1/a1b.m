% lade Daten
trainingData = load("-ascii", "pendigits-training.txt");
testData = load("-ascii", "pendigits-testing.txt");

hits = 0;
misses = 0;

% test some data from test dataset
for testSample = testData'
	[sample, class] = separateSample(testSample);
	[x, y] = splitVector(sample);
	
	minDist = realmax;
	hit = [];
	
	for trainingSample = trainingData'
		[vec1, dummyClass] = separateSample(trainingSample);
		testDist = distance(vec1', sample);
		if minDist > testDist
			minDist = testDist;
			hit = trainingSample';
		end
	end
	
	hit
	testSample'
	
	[hitVec, hitClass] = separateSample(hit);
	
	if class == hitClass
		hits += 1;
	else
		misses += 1;
	end
	
	hits
	misses
end


hits
misses
