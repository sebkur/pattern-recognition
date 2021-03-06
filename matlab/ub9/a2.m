% read image
I = imread('a2input64.png');
% black and white image
% black = 1, white = 2
B = (I > 127) + 1;

% create a feature matrix
[h, w] = size(B);
data = zeros(h*w, 3);
for i = 1:h % row index
	for j = 1:w % col index
		% index within data matrix
		idx = (i-1) * w + j;
		% coordinates with origin at center
		x = i - w / 2;
		y = j - h / 2;
		% append feature
		data(idx,:) =  [x y B(i, j)];
	end
end

% generate a number of linear classifiers as lines in polar coordinates
L = 500; % number of classifiers to generate
lines = zeros(L, 2);
diag = sqrt(h^2+w^2);
maxR = diag/2;
for c = 1:L
	r = rand() * maxR;
	theta = rand() * 2 * pi;
	lines(c,:) = [r, theta];
end
linescopy = lines;

% initialize weights
N = size(data, 1);
weights = repmat(1/N, N, 1);

results = [];

tic
M = 100; % number of classifiers to select
for i = 1:M % for each classfier to select

	% lecture's pseudocode: step 1)
	% select Km which minimizes weighted error
	best = 0;
	best_we = inf;
	% best_dir == 1: use in this direction
	% best_dir == 0: use in opposite direction
	best_dir = 1;
	for m = 1:size(lines, 1) % for each available classifier
		line = lines(m,:);
		r = line(1);
		theta = line(2);

		features = data(:,1:end-1);
		labels = data(:,end);
		predictions = hessian_classify(theta, r, 2, 1, features);
		successIndices = find(predictions == labels);
		failureIndices = find(predictions != labels);
		wc = sum(weights(successIndices));
		we = sum(weights(failureIndices));
		% pick classifier direction according to wc/we
		dir = we < wc;
		uwe = min(we, wc);
		if uwe < best_we
			best = m;
			best_we = uwe;
			best_dir = dir;
		end
	end
	if best == 0
		% no classifier can be found
 		break;
	end
	m = best;
	we = best_we;

	% lecture's pseudocode: step 2)
	% set alpha_m
	w = sum(weights);
	em = we / w;
	alpha_m = 0.5*log((1-em)/em);
	if (!best_dir)
		alpha_m = -alpha_m;
	end

	% lecture's pseudocode: step 3)
	% update weights
	line = lines(m,:);
	r = line(1);
	theta = line(2);

	features = data(:,1:end-1);
	labels = data(:,end);
	label1 = 2;
	label2 = 1;
	if (!best_dir)
		label1 = 1;
		label2 = 2;
	end
	predictions = hessian_classify(theta, r, label1, label2, features);
	successIndices = find(predictions == labels);
	failureIndices = find(predictions != labels);
	weights(failureIndices) = weights(failureIndices) * sqrt((1-em) / em);
	weights(successIndices) = weights(successIndices) * sqrt(em / (1-em));

	line = lines(m, :);
	lines = [lines(1:m-1,:); lines(m+1:end,:)];

	results = [results; alpha_m line];

	[i, alpha_m, line, best_dir]
end
toc

% results contains alpha_m weights and parameters of the chosen lines
results

[h, w] = size(I);
A = repmat(200, size(I) * 3);
A(h:h+h-1,w:w+w-1) = I;
A = uint8(A);

%plotLines(A, linescopy(:,1), linescopy(:,2), repmat(0.5, size(linescopy, 1), 1), 'a2all.png');
plotLines(A, results(:,2), results(:,3), results(:,1) * 10, 'a2result.png');
