
load penOnline.mat
load penBatch.mat

load ionOnline.mat
load ionBatch.mat

hold on
figure

subplot(2, 2, 1)
semilogy(penDigitsErrorsOnline);
grid on
title("pendigits errors online");


subplot(2, 2, 2)
semilogy(penDigitsErrorsBatch);
grid on
title("pendigits errors batch");


subplot(2, 2, 3)
semilogy(ionDigitsErrorsOnline);
grid on
title("ionosphere errors online");


subplot(2, 2, 4)
semilogy(ionDigitsErrorsBatch);
grid on
title("ionosphere errors batch");

hold off

print("a1.png");

pause
