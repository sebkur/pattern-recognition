V = load("-ascii", "usps.ascii/train_patterns.txt");
labels = load("-ascii", "usps.ascii/train_labels.txt");

% Darstellen einer einzelnen Ziffer geht so:
%imshow(reshape(V(:,1), 16, 16)')

% Die 50 ersten Ziffern darstellen
w = 10;
h = 5;
for i = 1:w*h
	subplot(h, w, i);
	imshow(reshape(V(:,i), 16, 16)')
end
print('image1.png');

% NMF bestimmen mit Codebook der Gräße 50
% und 100 Iterationen
[W, H] = nmf(V, 50, 100);

% W darstellen
w = 10;
h = 5;
for i = 1:w*h
	subplot(h, w, i);
	imshow(reshape(W(:,i), 16, 16)')
end
print('image2.png');

% Ziffern rekonstruieren und darstellen
Vapprox = W * H;

w = 10;
h = 3;
for k = 1:h
	for l = 1:w
		x = k * w + l;
		i = ((k-1) * 2) * w + l;
		subplot(h * 2, w, i);
		imshow(reshape(V(:,x), 16, 16)');
	end
end
for k = 1:h
	for l = 1:w
		x = k * w + l;
		i = ((k-1) * 2 + 1) * w + l;
		subplot(h * 2, w, i);
		imshow(reshape(Vapprox(:,x), 16, 16)');
	end
end
print('image3.png');
