

y = x = linspace(-5, 5, 50);

[xx, yy] = meshgrid(y, x);

fa  = - (xx .^ 2 + yy .^ 2) *4;

faax = -(8 * xx);
faay = -(8 * yy);

surfc(xx, yy, fa)
pause;

surfc(xx, yy, faax)
pause;
surfc(xx, yy, faay)
pause;

exit;

fb = e .^ (- ((xx - 0.5) .^ 2 - (xx - 0.5) .* (yy + 0.5) + (yy + 0.5) .^ 2) ./ (3 / 4))

surfc(xx, yy, fb)

pause;
