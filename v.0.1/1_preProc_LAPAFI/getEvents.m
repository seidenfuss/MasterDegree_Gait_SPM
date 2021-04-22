%% descrever bem
function [a, b, c, n_steps] = getEvents(data)%data is the cell you will be evaluating
a=isnan(data);
n_steps=0;
b=zeros(1,n_steps);
c=zeros(1,n_steps);
j=1;
m=1;

for k = 1:length(a)-1
    if a(k) == 1 && a(k+1) == 0 %begin cycle event
       b(j) = k+1;
       j = j+1;
       n_steps = n_steps+1;
    end
    
    if a(k) == 0 && a(k+1) == 1 %end cycle event
       c(m) = k;
       m = m+1;
    end
end

end



