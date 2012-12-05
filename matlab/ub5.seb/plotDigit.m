function plotDigit(coordinates, label, namePdf, namePng)
	handle = figure('visible', 'off');
	[x, y] = splitVector(coordinates);
	plot(x,y, '--rs', 'markersize', 5, 'linewidth', 2);
	legend(label);
	print(namePdf);
	print(namePng);
	close(handle);
end;
