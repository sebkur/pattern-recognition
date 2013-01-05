% plot some lines specified in hessian normal form on an image and store it
% in a file.
function plotLines(I, rs, thetas, widths, filename)
	[h, w] = size(I);
	imshow(I);
	hold on;

	for i = 1:size(rs,1)
		r = rs(i); % radius
		t = thetas(i); % winkel
		lw = widths(i); % line widtdh

		% Länge des zu zeichnenden Geradensegments
		ll = sqrt(h^2+w^2);
		% Normalenvektor der Geraden
		n = [cos(t); sin(t)];
		% Richtungsvektor der Geraden
		v = [n(2); -n(1)];
		% Länge des Richtungsvektors
		l = norm(v);

		% Ankerpunkt
		m = [r * cos(t);  r * sin(t)];
		% zwei Punkte p und q auf der Geraden bestimmen
		p = m - (ll / 2 / l) * v;
		q = m + (ll / 2 / l) * v;
		% zeichnen
		plot([w/2 + p(1), w/2 + q(1)], [h/2 - p(2), h/2 - q(2)], '-', 'LineWidth', lw);
	end;

	print(filename);
	hold off;
end;
