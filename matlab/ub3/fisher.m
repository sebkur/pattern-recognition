function [ncorrect, nwrong] = fisher(mus, covariances, testingData, digitA, digitB)
	% Eingabe sind Zeilenvektoren!
	testA = testingData(testingData(:,17) == digitA,:)(:,1:end - 1);
	testB = testingData(testingData(:,17) == digitB,:)(:,1:end - 1);
	% mus holen
	muA = mus{digitA + 1};
	muB = mus{digitB + 1};
	% Kovarianzen holen
	covA = covariances{digitA + 1};
	covB = covariances{digitB + 1};
	% Projektionsrichtung ausrechnen
	a = (muA - muB) * (covA + covB)^(-1);
	% eindimensionale Gaussverteilung bestimmen
	muA1 = a * muA';
	muB1 = a * muB';
	covA1 = a*covA*a';
	covB1 = a*covB*a';
	% Projiziere Testdaten auf a
	pA = testA * a';
	pB = testB * a';
	% Wahrscheinlichkeiten nach Bayes
	[probsA1, probsB1, classes1] = arrayfun(@(x) bayes(x, muA1, muB1, covA1, covB1), pA);
	[probsA2, probsB2, classes2] = arrayfun(@(x) bayes(x, muA1, muB1, covA1, covB1), pB);
	ncorrect = sum(classes1 == 1) + sum(classes2 == 2);
	nwrong = sum(classes1 == 2) + sum(classes2 == 1);
end
