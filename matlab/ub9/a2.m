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
L = 20; % number of classifiers to generate
lines = zeros(L, 2);
diag = sqrt(h^2+w^2);
maxR = diag/2;
for c = 1:L
	r = rand() * maxR;
	theta = rand() * 2 * pi;
	lines(c,:) = [r, theta];
end

% initialize weights
N = size(data, 1);
weights = repmat(1/N, N, 1);

results = [];

M = 2; % number of classifiers to select
for i = 1:M % for each classfier to select

	% lecture's pseudocode: step 1)
	% select Km which minimizes weighted error
	best = 0;
	best_we = inf;
	best_wc = inf;
	for m = 1:size(lines, 1) % for each available classifier
		line = lines(m,:);
		r = line(1);
		theta = line(2);

		wc = 0;
		we = 0;
		for k = 1:N % iterate data
			features = data(k,1:end-1);
			label = data(k,end);

			prediction = hessian_classify(theta, r, 1, 2, features);
			w_k = weights(k);
			if label == prediction
				wc += w_k;
			else
				we += w_k;
			end
		end
		if we < best_we
			best = m;
			best_we = we;
			best_wc = wc;
		end
	end
	m = best;
	we = best_we;
	wc = best_wc;

	% lecture's pseudocode: step 2)
	% set alpha_m
	w = we + wc;
	em = we / w;
	alpha_m = 0.5*log((1-em)/em);

	% lecture's pseudocode: step 3)
	% update weights
	line = lines(m,:);
	r = line(1);
	theta = line(2);

	for k = 1:N % iterate data
		features = data(k,1:end-1);
		label = data(k,end);
		prediction = hessian_classify(theta, r, 1, 2, features);
		w_k = weights(k);
		if label == prediction
			weights(k) = w_k * sqrt((1-em) / em);
		else
			weights(k) = w_k * sqrt(em / (1-em));
		end
	end
	line = lines(m, :);
	lines = [lines(1:m-1,:); lines(m+1:end,:)];

	results = [results; alpha_m line];
end

% results contains alpha_m weights and parameters of the chosen lines
results

% TODO: draw lines on image
% TODO: the whole thing is awfully slow, we have to use matrix operations
% instead of loops to improve performance :/
