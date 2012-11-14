

y = x = linspace(-5, 5, 50);

[xx, yy] = meshgrid(y, x);



fb = e .^ (- ((xx - 0.5) .^ 2 - (xx - 0.5) .* (yy + 0.5) + (yy + 0.5) .^ 2) ./ (3 / 4))

surfc(xx, yy, fb)
pause;
print("3a2.png");

fbax = (1 - 8 / 3 .* xx - 4 / 3 .* yy) .* e .^ ( -(1 .- xx .+ 4 ./ 3 .* xx .^ 2  .- 4 ./ 3 .* xx .* yy .+ yy .+ 4/3 .* yy .^2))
fbay = -(1 - 8 / 3 .* yy - 4 / 3 .* xx) .* e .^ ( -(1 .- xx .+ 4 ./ 3 .* xx .^ 2  .- 4 ./ 3 .* xx .* yy .+ yy .+ 4/3 .* yy .^2))


surfc(xx, yy, fbax)
pause;
print("3c2x.png");
surfc(xx, yy, fbay)
pause;
print("3c2x.png");


fa  = - (xx .^ 2 + yy .^ 2) *4;

faax = -(8 * xx);
faay = -(8 * yy);

surfc(xx, yy, fa)
pause;
print("3a1.png");

surfc(xx, yy, faax)
pause;
print("3c1x.png");
surfc(xx, yy, faay)
pause;
print("3c1y.png");


