
number = 100;
pi = 3.1;
learning_rate = 0.1;
limit = 0.5;



x_input = rand(1,number);
x_input = x_input * limit *pi;

x_0 = [ 0 ];
x_input = [x_input,x_0];

x_temp = rand(1,number);
x_temp = x_temp * limit * pi * (-1);

x_input = [x_input,x_temp];



x_input = sort(x_input);

%x_input = [ 0.00123  0.123 0.456 1.123 0.572 0.0812 -0.812 -0.0123 0.0566 0 -1.111 0.233 -0.413 -0.756 1.023 -0.671 0.0412 -0.712 0.1123 0.166 1.01]


required_output = tan(sort(x_input));
calculated_output = [];


x_hidden = [ 1 1 1 ];
x_output = [ 1 1 1 ];


y_first = [ 1 ];
y_second = [ 1 1 1 ];
y_third = [ 1 ];

w_input = rand(1,1);
w_hidden = rand(1,3);
w_output = rand(1,3);

b_input = rand(1,1);
b_hidden = rand(1,3);
b_output = rand(1,1);

delta_output = [ 1 ];
delta_hidden = [ 1 1 1 ];
delta_input = [ 1 ];

function [dy] = sigmoid_derivative(s)
dy = (4 * exp(-2*s)) ./ ((1 + exp(-2*s)) .* (1 + exp(-2*s))); 
end

function [ out ] = sigmoidd( s )
	out = (1 - exp(-2*s)) ./ (1 + exp(-2*s));
end

function [ out ] = forward_hidden( x , w , b )
	j = 1;
	for i = x
		out(j)= w(j)*i + b(j);
%		disp(out(j));
		j= j + 1;

	endfor; 
end

function [ out ] = forward_output( x , w , b )
	x_t = transpose(x);
	out = w*x_t;
	out = out + b;
end

function [ delta_hidden ] = propogate_delta_to_hidden(w_output, delta_output)
	j = 1;	
	for i = w_output
		delta_hidden(j) = i * delta_output;
		j = j+1;
	endfor;
end

function [ delta_input ] = propogate_delta_to_input(w_hidden, delta_hidden)
	w_hidden_t = transpose(w_hidden);
	delta_input = delta_hidden*w_hidden_t;
end




for iter = 1:1000
% Looping through all the input cases
	count = 1;
	for i = x_input 
	%
	x_hidden = [ 1 1 1 ];
	x_output = [ 1 1 1 ];


	y_first = [ 1 ];
	y_second = [ 1 1 1 ];
	y_third = [ 1 ];



	delta_output = [ 1 ];
	delta_hidden = [ 1 1 1 ];
	delta_input = [ 1 ];
	% Forward Pass begins:
	%
		%disp(i) 
	% layer 1 
		y_first = i * w_input(1) + b_input(1);     
		out = sigmoidd(y_first);  	
		x_hidden = x_hidden * out;
	
		y_second = [ 1 1 1 ];
		y_second = forward_hidden(x_hidden,w_hidden,b_hidden);

	% layer 2
		k = 1;	
		for j = y_second
			x_output(k) = sigmoidd(j);
			k = k + 1;	
		endfor;
	% layer 3
		y_third = forward_output(x_output, w_output, b_output);
		y_target = sigmoidd(y_third);
		%disp(y_target);

	% find actual tan answer
		y_expected = tan(i);	
	

	% calculating error
		delta_output = y_expected - y_target;
		error = delta_output;

		%delta_hidden = propogate_delta_to_hidden(w_output,delta_output);
		%delta_input = propogate_delta_to_input(w_hidden,delta_hidden);

		new_weight_hidden = [ 1 1 1];
		new_weight_output = [1 1 1];
		new_weight_input = [1];
	
		new_weight_output(1) = w_output(1) - learning_rate*error*sigmoid_derivative(y_target)*x_output(1);
		new_weight_output(2) = w_output(2) - learning_rate*error*sigmoid_derivative(y_target)*x_output(2);
		new_weight_output(3) = w_output(3) - learning_rate*error*sigmoid_derivative(y_target)*x_output(3);

		new_weight_hidden(1) = w_hidden(1) - learning_rate*error*sigmoid_derivative(y_second(1))*x_hidden(1)*w_output(1);
		new_weight_hidden(2) = w_hidden(2) - learning_rate*error*sigmoid_derivative(y_second(2))*x_hidden(2)*w_output(2);
		new_weight_hidden(3) = w_hidden(3) - learning_rate*error*sigmoid_derivative(y_second(3))*x_hidden(3)*w_output(3);

		new_weight_input(1) = w_input(1) - (learning_rate*error*sigmoid_derivative(y_first(1))*i*w_hidden(1) +  learning_rate*error*sigmoid_derivative(y_first(1))*i*w_hidden(2) + learning_rate*error*sigmoid_derivative(y_first(1))*i*w_hidden(3) );	

	 	
	%	b_output = b_output - learning_rate.*error.*sigmoid_derivative(y_target);
	%	b_hidden = b_hidden - learning_rate.*error.*sigmoid_derivative(y_second).*w_output;
	%	b_input = b_input - (learning_rate*error*sigmoid_derivative(y_first)*w_hidden(1) + learning_rate*error*sigmoid_derivative%% (y_first)*w_hidden(2) + learning_rate*error*sigmoid_derivative(y_first)*w_hidden(3) );	

		w_input = new_weight_input;
	 	w_hidden = new_weight_hidden;
	 	w_output = new_weight_output;
		disp(w_input);
		disp(w_hidden);
		disp(w_output);

		
		%required_output(count) = tan(i);
		calculated_output(count) = y_target;
		count = count+1;
	
	endfor;

	plot_x1 = x_input;
	plot_y1 = calculated_output;
	[val ind ] = sort(plot_x1);
	plot_y1 = plot_y1(ind);
	plot_x1 = sort(x_input);
	

	plot_x2 = sort(x_input);
	plot_y2 = required_output;
	%[val ind ] = sort(plot_x2);
	%plot_y2 = plot_y2(ind);
	plot(plot_x1,plot_y1,plot_x2,plot_y2);	

%	plot(x_input,required_output,x_input,calculated_output);


	

endfor;









