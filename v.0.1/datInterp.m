% DATINTERP
% datinterp(dat,points,method)
% Onde dat � matriz de dados; points � n�mero de pontos interpolados em dat;
% method � o m�todo de interpola��o (linear, spline, nearest, cubic, pchip 
% e v5cubic).
% Caso n�o informado utiliza como padr�o a spline.

function [yi] = datInterp(dat,points,method)
if nargin == 2; method = 'spline'; end
[nl,nc] = size(dat);
x = [1:nl];
xi = linspace(1,nl,points);
for i = 1:nc;
yinterp(:,i) = interp1(x,dat(:,i),xi,method);
end

yi = yinterp;