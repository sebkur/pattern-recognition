function [probA, probB, class] = bayes(x, muA1, muB1, covA1, covB1)
	% Warscheinlichkeiten ausrechnen
	probA = 1 / (sqrt(2*pi) * covA1) * e^((-1/2) * (x-muA1)^2);
	probB = 1 / (sqrt(2*pi) * covB1) * e^((-1/2) * (x-muB1)^2);
	% Wähle die Warscheinlichere Klassennummer
	class = 2;
	if (probA > probB) % hier kommt die Asymmetrie her
		class = 1;
	end
end
