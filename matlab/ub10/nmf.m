% Nicht-negative Matrixfaktorisierung bestimmen
% Parameter V: Eingabedaten
% Parameter k: Anzahl der Einträge im Codebook
% Parameter iterations: Anzahl der auszuführenden Iterationen
function [W,H] = nmf(V, k, iterations)

% zufällige Initialisierung
[M, N] = size(V);
W = rand(M, k);
H = rand(k, N);

% W und H iterativ anpassen
for i = 1:iterations
	W = W .* (V * H') ./ (W * (H * H'));
	H = H .* (W' * V) ./ ((W' * W) * H);
end
