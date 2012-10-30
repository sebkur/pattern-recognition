

% lade Daten
trainingData = dlmread("pendigits-training.txt");
testData = dlmread("pendigits-testing.txt");

trainingCount = size(trainingData)(1)
testCount = size(testData)(1)

% visualisiere Daten
function [x, y] = splitVector(data)
	w = length(data);
	x = []; y = [];
	for i = 1:2:(w - 1)
		x = [x , data(i)];
		y = [y , data(i + 1)];
	end
end

function [vec, class] = seperateSample(sample)
	vec = sample(1:end-1);
	class = sample(end);
end

function dist = distance(vec1, vec2)
	dist = sqrt(sum((vec1(:) - vec2(:)).^2));
end

function root = createKDTree(samples, dimIndex)
	rows = size(samples)(1);
	dimensions = size(samples)(2);
	meanIndex = ceil(rows / 2);
	% recursion stop
	if 1 == rows
		[vec, class]= seperateSample(samples);
		root = {vec, class}
		return;
	else if 0 == rows
		root = [];
		return; 
		end
	end
	
	% sort matrix
	[s, i] = sort(samples(:,dimIndex));
	sorted = samples(i,:);
	% find mean element
	
	% split into two subgroups and recurse into both
	left = sorted(1:(meanIndex - 1),:);
	right = sorted((meanIndex + 1):end,:);
	
	mean = sorted(meanIndex ,:);
	[vec, class]= seperateSample(mean);
	leftTree = createKDTree(left, mod((dimIndex + 1), dimensions));
	rightTree = createKDTree(right, mod((dimIndex + 1), dimensions));
	root = {{vec, class}, {leftTree, rightTree}};
end

function [nn, distance] = findNearestNeighbor(root, sample, dimIndex)
	dim = size(sample)(2);
	rootNode = root{1}{1}
	distToRoot = distance(rootNode, sample);
	size(root)(2)
	if 0 == distToRoot || 1 == size(root)(2)
		nn = root;
		distance = distToRoot;
		return;
	end
	
	leftSubTree = root{2}{1}
	leftChild = leftSubTree{1,1}
	rightSubTree = root{2}{2}
	rightChild = rightSubTree{1,1}
	pause;
	
	distLeft = realmax;
	distRight = realmax;
	
	% choose wether to recurse into left or right subtree
	if dim == size(leftChild)(2)
		distLeft = abs(sample(1,dimIndex) - leftChild(1,dimIndex));
	end
	
	if dim == size(rightChild)(2)
		distRight = abs(sample(1,dimIndex) - rightChild(1,dimIndex));
	end
	
	bestNN = rootNode;
	
	if realmax == distLeft && realmax != distRight
		% go into right sub tree
		bestNN = findNearestNeighbor(rightSubTree, sample, mod(dimIndex + 1, dim))
	end
	
	if realmax == distRight && realmax != distLeft
		% go into left sub tree
		bestNN = findNearestNeighbor(leftSubTree, sample, mod(dimIndex + 1, dim))
	end
	
	
	if distLeft < distRight
		bestNN = findNearestNeighbor(leftSubTree, sample, mod(dimIndex + 1, dim))
	else
		bestNN = findNearestNeighbor(rightSubTree, sample, mod(dimIndex + 1, dim))
	end
	
	nn = bestNN
end


kdRoot = createKDTree(trainingData(1:5,:), 1)
pause;
bla = findNearestNeighbor(kdRoot, seperateSample(testData(1,:)),1)

% produce some outputs
for i = 1:1
	sample = trainingData(i,:);
	[sample, class] = seperateSample(sample);
	[x, y] = splitVector(sample);
	plot(x,y);
	legend(num2str(class));
	pause;
end

hits = 0;
misses = 0;

% test some data from
for testSample = testData'
	[sample, class] = seperateSample(testSample);
	[x, y] = splitVector(sample);
	plot(x,y)
	legend(num2str(class));
	
	% very simple: look for best match and plot that as well
	minDist = realmax
	hit = [];
	
	for trainingSample = trainingData'
		[vec1, dummyClass] = seperateSample(trainingSample);
		testDist = distance(vec1', sample);
		if minDist > testDist
			minDist = testDist;
			hit = trainingSample';
		end
	end
	
	hit
	testSample'
	
	[hitVec, hitClass] = seperateSample(hit);
	
	if class == hitClass
		hits += 1;
	else
		misses += 1;
	end
	
	hits
	misses

	% display match
	[matchX, matchY] = splitVector(hitVec);
	plot(matchX, matchY)
	legend(num2str(hitClass));
end


hits
misses



