function [coef,table] = divdif (x1, y1, d1)
%
% function [coef,table] = divdif (xi, yi)
%
% Construct a divided difference table based on data points (xi,yi).
% Upon return, the Newton interpolation coefficients are in coef

l1 = length(x1);
l = l1 * 2;
x = (l);
y = (l);
d = (l);

for i = 1:l1
    x(2*i - 1) = x1(i);
    x(2*i) = x1(i);
    y(2*i - 1) = y1(i);
    y(2*i) = y1(i);
    d(2*i - 1) = d1(i);
    d(2*i) = d1(i);
end

table = zeros(l,l); xi = shiftdim(x); yi = shiftdim(y); di = shiftdim(d);
table(1:l,1) = yi;

for k = 2:l
    for temp = k:l
        minusY = table(temp,k-1) - table(temp - 1,k-1);
        minusX = (xi(temp)) - (xi(temp-k+1));
        if minusX == 0
            table(temp,k) = di(temp);
        else
            table(temp,k) = minusY / minusX;
        end
    end
end

coef = diag(table);



