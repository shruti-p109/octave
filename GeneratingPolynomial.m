% Name : PIMPARKAR SHRUTI SANJEEV SHEETAL
% PROBLEM : Generate 3rd degree polynomial from 10 digits (mobile number)

pkg load symbolic
syms x y
ip = "8767545990";
mobNo = arrayfun (@(z) str2double (ip(z)), 1:numel(ip));
printf("Polynomial for mob no. %s:\n",ip);  
% var declaration
x = sym('x');
y = sym('y');
% intialization
polyOrder = 3;
g = 0;
mobNoIdx = 1;
for ij_sum = polyOrder:-1:0
  for x_power = ij_sum:-1:0
    if ~mod(mobNoIdx,2) 
      sign = -1;
    else
      sign = 1;
    endif
    coeff = sign*mobNo(mobNoIdx);
    g = g + coeff*x^(x_power)*y^(ij_sum-x_power);
    mobNoIdx = mobNoIdx + 1;
  endfor
end
disp(g);