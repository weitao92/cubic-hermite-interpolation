function [pp]=mypchip(x , y , dy)
%MYPCHIP ? piecewise cubic Hermite i n t e r p o l a t i n g polynomial 
% input 
% x ? a vector for x i values 
% y ? a vector for function values f ( x i ) 
% dy ? a vector for d e r i v a t i v e s f ? ( x i ) 
% output 
% pp ? A piecewise polynomial structure for the PCHIP

% here i use my own divdif function calculate the divided difference table
% and it's coefficients.
[coef,~]=divdif(x,y,dy);

l1 = length(x);
l = l1 * 2;
x1 = (l);

for i = 1:l1
    x1(2*i - 1) = x(i);
    x1(2*i) = x(i);
end

% Here i define my own polynomial.
syms xx f(xx) temp(xx) pp(xx);
f(xx) = coef(1);
temp(xx) = 1;

% add every term iteratively.
for i = 1:l-1
    temp(xx) = temp(xx) * (xx-x1(i));
    f(xx) = f(xx) + coef(i+1)*temp(xx);
end

% here i used matlab's build in function get the final coefficients
% and then rank them from high order to low order.
cx = coeffs(f(xx), xx);
c = fliplr(cx);
cd = vpa(c);

pp = mkpp([0 x1(l)], cd);






