function [x, err, steps] = perform_iterative(G, c, x0, tol, max_steps)
	% G -> matricea de iterație
	% c -> vectorul de iterație
	% x0 -> soluția inițială
	% tol -> toleranța acceptată (norma diferenței dintre două soluții)
	% max_steps -> numărul maxim de iterații
	
	% x -> soluția finală
	% err -> ultima diferență calculată (norma euclidiană)
	% steps -> numărul real de iterații efectuate
	
	% Inițializăm soluția la soluția inițială
	x = x0;
	
	% Inițializăm diferența la o valoare mare
	err = tol + 1;
	
	% Numărul de iterații efectuate
	steps = 0;
	
	% Realizăm iterațiile până când diferența este mai mică decât toleranța sau am depășit numărul maxim de iterații
	while err > tol && steps < max_steps
		% Salvăm soluția anterioară pentru a calcula diferența
		x_prev = x;
		
		% Calculăm noua soluție folosind formula de iterație
		x = G * x + c;
		
		% Calculăm diferența dintre soluția anterioară și cea nouă
		err = norm(x - x_prev);
		
		% Incrementăm numărul de iterații efectuate
		steps = steps + 1;
	endwhile
	
endfunction
