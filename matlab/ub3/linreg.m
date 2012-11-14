

function beta = lassoRegression(data, classes, poly)
	% augment with ones
	cnt = size(data)(1);
	data = repmat(data,1, poly + 1)
	data = (data .^ (repmat([0:(poly)],cnt, 1)))
	beta = (data' * data)^-1 * data' * classes;
end


x = linspace(-1,1,100)';

samples = x;
classes = x .^ 4 + 0.5 * x .^ 2;

beta = lassoRegression(samples, classes,4)

hold on;
plot(samples, classes , "@")

x = linspace(-1,1,100);
y = zeros(1,100);

for i = size(beta)(1)
	y += beta(i) * x .^ (i - 1);
	y'
end

plot(x,y)
hold off;
pause;
