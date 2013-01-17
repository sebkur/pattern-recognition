X = load("-ascii", "usps.ascii/train_patterns.txt");
Y = load("-ascii", "usps.ascii/train_labels.txt");

% Darstellen einer einzelnen Ziffer:
%imshow(reshape(X(:,1), 16, 16)')

[W, H] = nmf(X, 50, 100);

% plot W
w = 10;
h = 5;
for i = 1:50
	subplot(h, w, i);
	imshow(reshape(W(:,i), 16, 16)')
end
