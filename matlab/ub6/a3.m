% alle möglichen 3x3 Bilder generieren
pixels = binary_permutations(9);

% Bilder labeln
ys = [];
for data = pixels'
	ys(end + 1) = label(data);
end
ys = ys';

% Gewichte lernen
w = perzeptron(pixels, ys);

% Bild laden
I = double(imread('lena.png'));
% nach schwarz-weiß konvertieren
BW = I > mean(I(:));

% Kantenbild berechnen
O = [];
[hei, wid] = size(BW);
% alle Teilbilder ansehen
for y = 2:hei-1
	for x = 2:wid-1
		% Teilbildmatrix holen
		M = BW(y-1:y+1,x-1:x+1);
		% in Vektor umwandeln
		Mpixels = reshape(M, 1, 9);
		% klassifizieren
		O(y-1, x-1) = Mpixels * w';
	end
end
% Bild abspeichern
imwrite(O, "edges.png");
