
% ausgabe der Haupkomponente für die Ziffer 7
trainingData = load("-ascii", "pendigits-training.txt");
featuresDigit = trainingData(trainingData(:,17) == 7,:);
[muDigit, covDigit] = gauss(featuresDigit);
[vDigit, lambdaDigit] = eig(covDigit);
hold on;
for mainComponent = vDigit'
	mainComponent
	plot(mainComponent);
end
hold off;

print("a1a.png")

pause
