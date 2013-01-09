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

% load classifiers with weights previously generated with AdaBoost
load('results.mat')

features = data(:,1:end-1);
labels = data(:,end);
predictions = zeros(size(features, 1), 1);

% cumulate weighted predictions
for row = results'
	alpha_m = row(1);
	r = row(2);
	theta = row(3);
	% hier übergeben wir als label jetzt nicht mehr 2 und 1, sondern -1 und 1,
	% sodass wir später aufgrund von >0 und <0 klassifizieren können.
	predictions += alpha_m * hessian_classify(theta, r, -1, 1, features);
end

% compare with labels
predictions(predictions >= 0) = 1;
predictions(predictions < 0) = 2;

% calculate success rate
successRate = sum(predictions == labels) / size(labels, 1)
