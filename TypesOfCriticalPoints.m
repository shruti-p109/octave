% Name : PIMPARKAR SHRUTI SANJEEV SHEETAL
% PROBLEM : Find Out whether critical points are maximum, minimum or saddle points

pkg load symbolic
syms x y  
%polynomial generation
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
disp("Note: Ignoring imaginary part of x & y as its extremely small (e^-30)");
critical_pts = real(critical_pts);

% classification of critical points as maximum, minimum or a saddle point
pkg load dataframe
output={"Critical Point", "x", "y", "Type of point";};
d2g_dx2 = diff(dg_dx, x);
d2g_dxdy = diff(dg_dx, y);% this would be same as d2g_dydx
d2g_dy2 = diff(dg_dy, y);
for i = 1:rows(critical_pts)
  output(i+1,1) = i;
  output(i+1,2) = critical_pts(i,1);
  output(i+1,3) = critical_pts(i,2);
  xi = sym(critical_pts(i,1),'f');
  yi = sym(critical_pts(i,2),'f');
  % get values of all partial derivatives at current x & y
  d2g_dx2_xi = double(subs(d2g_dx2,{x y},{xi yi}));
  d2g_dxdy_xi = double(subs(d2g_dxdy,{x y},{xi yi}));
  d2g_dy2_xi = double(subs(d2g_dy2,{x y},{xi yi}));
  % form hessian matrix
  hess_matrix = [d2g_dx2_xi , d2g_dxdy_xi ; d2g_dxdy_xi , d2g_dy2_xi];
  % get eigen values of hessian matrix
  [lambda] = eig(hess_matrix);
  % check the signs of eig values
  type = '';
  if(any(lambda==0))
    type = "Inconclusive";
  elseif(all(lambda>0))
    type = "Local Minima";
  elseif(all(lambda<0))
    type = "Local Maxima";
  elseif(any(lambda>0) & any(lambda<0))
    type = "Saddle Point";
  endif
  output(i+1,4) = type;
end
df = dataframe (output);
display (df);