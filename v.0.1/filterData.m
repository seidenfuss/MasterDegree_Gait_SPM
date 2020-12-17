function [ data_filtered ] = filterData( data,Fc,Fs )
%Para filtrar os dados com filtro Butterworth zero-lag
%   data= dados; Fc=frequência de corte; Fs=frequência de amostragem
ordem = 4;       % passagem do filtro de quarta ordem
Wn = Fc/(Fs/2);  % frequência de corte normalizada pela metade da freq. de amostragem
[d,c] = butter(ordem,Wn,'low'); % definido o filtro (butterworth)
data_filtered=filtfilt(d,c,data) ;
end