% 第一大题
 
% Calculate the values of the functions
% 1.1
z1 = 1 + 1i;
sqrt_z1 = sqrt(z1);
disp(['The answer of 1.1 formula: ' num2str(sqrt_z1)]);
 
% 1.2
z2 = -2 + 2i;
sqrt_z2 = sqrt(z2);
disp(['The answer of 1.2 formula: ' num2str(sqrt_z2)]);
 
% 1.3
z3 = sqrt(3) + (2 * sqrt(3) - 3) * 1i;
root_sixth_z3 = z3^(1/6);
disp(['The answer of 1.3 formula: ' num2str(root_sixth_z3)]);

% Solve equation
% 2
syms z1 z2 % create a variable
eq1 = z1 + 2*z2 == 1 + 1i;
eq2 = 3*z1 + 1i*z2 == 2 - 3i;
 
% Solve equation for z1 and z2
solution = solve([eq1, eq2], [z1, z2]);
 
% Display the solutions
disp(['z1 = ', char(solution.z1)]);
disp(['z2 = ', char(solution.z2)]);

% Calculate limits
% 3.1
syms n;
expr1 = ((3 + 4i)/6)^n;
% Calculate the limit as n approaches infinity
result1 = limit(expr1, n, inf);
disp(['The answer of 3.1 formula: ' char(result1)]);
 
% 3.2
syms n;
expr2 = (n + (n^2/2))^(1/n);
% Calculate the limit as n approaches infinity
result2 = limit(expr2, n, inf);
disp(['The answer of 3.2 formula: ' char(result2)]);

% Calculate the first-order derivative at the specified point
% 4
syms z;
f = ((z^2 - 1)^2) * ((z^2 + 1)^2);
 
% Calculate the derivative of the function with respect to z
df = diff(f, z);
 
% Substitute z = i/2 into the derivative
derivative_z0 = subs(df, z, 1i/2);
disp(['The answer of 4 formula: ' char(derivative_z0)]);

% Calculate the integrals
% 5.1
syms z;
f1 = (1 + tan(z)) / cos(z)^2;
 
% Calculate the definite integral of the first function from 1 to i
result1 = int(f1, z, 1, 1i);
disp(['The answer of 5.1 formula: ' char(result1)]);
 
% 5.2
syms z;
f2 = (z - 1i) * exp(-z);
 
% Calculate the definite integral of the second function from 0 to i
result2 = int(f2, z, 0, 1i);
disp(['The answer of 5.2 formula: ' char(result2)]);

% Expand the top 10 Taylor items
% 6.1
syms z;
f1 = sin(3+z);
% Calculate the Taylor expansion
taylor1 = taylor(f1, z, 'Order', 10);
disp(['The answer of 6.1 formula: ' char(taylor1)]);
 
% 6.2
syms z;
f2 = exp(z) * log(1+z);
% Calculate the Taylor expansion
taylor2 = taylor(f2, z, 'Order', 10);
disp(['The answer of 6.2 formula: ' char(taylor2)]);
 
% 6.3
syms z;
f3 = (2*z^5 + 5*z^3 + z^2 + 2) / (z^3 + 2*z^2 + 3*z + 1);
% Calculate the Taylor expansion
taylor3 = taylor(f3, z, 'Order', 10);
disp(['The answer of 6.3 formula: ' char(taylor3)]);

% Calculate the residue
% 7
% Define the numerator and denominator coefficients of the transfer function
B = [1, 0, 0, 0, 1];
A = [1, 0, 2, 0, 1, 0];
 
% Calculate residues and poles using the residue function
[residues, poles] = residue(B, A);
disp('Residues:');
disp(residues);
disp('Poles:');
disp(poles);

% Calculate the integral
% 8
% Define the numerator and denominator coefficients of the transfer function
B = [2, 0, 1];
A = [2, 1, 4, -5];
% Calculate residues and poles using the residue function
[residues, poles] = residue(B, A);
I = 0;
% Calculate of the integral
for k = 1:length(poles)
    if abs(poles(k)) <= 1
        I = I + 2*pi*1i*residues(k);
    end
end
disp(['The answer of 8 formula:  ', num2str(I)]);

% Draw the figures
t = linspace(-5, 5, 100);
 
z1 = t + 1i*t.^2;
z2 = t + 1i*exp(t).*sin(t);
 
figure;
 
% 9.1
subplot(1, 2, 1);
plot(real(z1), imag(z1));
xlabel('real quantity');
ylabel('imaginary quantity');
title('z = t + i t^2');
grid on;
axis equal;
 
% 9.2
subplot(1, 2, 2);
plot(real(z2), imag(z2));
xlabel('real quantity');
ylabel('imaginary quantity');
title('z = t + i e^t sin(t)');
grid on;
axis equal;