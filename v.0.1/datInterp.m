% DATINTERP
% datinterp(dat,points,method)
% Onde dat é matriz de dados; points é número de pontos interpolados em dat;
% method é o método de interpolação (linear, spline, nearest, cubic, pchip 
% e v5cubic).
% Caso não informado utiliza como padrão a spline.

function [yi] = datInterp(dat,points,method)
if nargin == 2; method = 'spline'; end
[nl,nc] = size(dat);
x = [1:nl];
xi = linspace(1,nl,points);
for i = 1:nc;
yinterp(:,i) = interp1(x,dat(:,i),xi,method);
end

yi = yinterp;