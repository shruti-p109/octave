% Name : PIMPARKAR SHRUTI SANJEEV SHEETAL
% PROBLEM : Find Critical Points of Generated Polynomial

pkg load symbolic
syms x y  
% polynomial generation
ip = "8421762949";
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

% patial derivatives of the g 
dg_dx = diff(g, x);
dg_dy = diff(g, y);
% solve dg_dx = 0 & dg_dy = 0 to get critical points
[xSym,ySym] = solve(dg_dx == 0, dg_dy == 0,x,y);
critical_pts = double([xSym,ySym]);
% note: ignoring imaginary part as its extremely small (e^-30)
disp("Note: Ignoring imaginary part of x & y as its extremely small (e^-30)");
critical_pts = real(critical_pts);
disp('Critical Points :')
for i = 1:rows(critical_pts)
  printf ("x%d,y%d:\n", i,i);
  disp(critical_pts(i,:))
end