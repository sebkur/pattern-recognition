
load rprop.mat

hold on
figure

subplot(2,1,1)
semilogy(ionErrorsRPROP);
grid on
title("ionospere errors rprop");

subplot(2,1,2)
semilogy(penErrorsRPROP);
grid on
title("pendigits errors rprop");


hold off

print("a2.png");

pause
