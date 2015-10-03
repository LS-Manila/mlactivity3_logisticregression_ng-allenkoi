function [theta]=Logistic_Regression(x,y)
	m= length(y);

	theta = zeros(3, 1);

	g = inline('1.0 ./ (1.0 + exp(-z))'); 

	J = zeros(5, 1);

	for i = 1:5
		z = x * theta;
		h = g(z);
		
		grad = (1/m).*x' * (h-y);
		H = (1/m).*x' * diag(h) * diag(1-h) * x;
		
		J(i) =(1/m)*sum(-y.*log(h) - (1-y).*log(1-h));
		
		theta = theta - H\grad;
	end
	plot_x = [min(x(:,2))-2,  max(x(:,2))+2];
	plot_y = (-1./theta(3)).*(theta(2).*plot_x +theta(1));
	plot(plot_x, plot_y)
	hold on 
	plot(x(pos,2),x(pos,3),'+');
	plot(x(neg,2),x(neg,3),'o');
	legend('Admitted', 'Not admitted', 'Decision Boundary')
	hold on

	figure
	plot(0:MAX_ITR-1, J, 'o--', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
	xlabel('Iteration'); ylabel('J')
end