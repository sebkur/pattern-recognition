% read image
I = imread('a2input64.png');

% define some lines
rs = [20; 24; 22];
thetas = [0.1; pi/2 + 0.1; pi + 0.2];

% and plot them
plotLines(I, rs, thetas, 'test.png');
