
function [event_begin, event_end, n_steps] = getEvents(data)
%data is the cell you will be evaluating
isnan_side=isnan(data);
n_steps=0;
event_begin=zeros(1,n_steps);
event_end=zeros(1,n_steps);
j=1;
m=1;

for k = 1:length(isnan_side)-1
    if isnan_side(k) == 1 && isnan_side(k+1) == 0 %begin cycle event
        event_begin(j) = k+1;
        j = j+1;
        n_steps = n_steps+1;
    end
    if isnan_side(k) == 0 && isnan_side(k+1) == 1 %end cycle event
        event_end(m) = k;
        m = m+1;
    end
end
end
%% THE END


