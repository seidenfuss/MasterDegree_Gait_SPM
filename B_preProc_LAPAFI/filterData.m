function [ data_filtered ] = filterData( data,Fc,Fs )
%To filter data with low-pass butterworth filter with zero-lag
%Fc=cut-off frequency; 
%Fs=sampling frequency

ordem = 2;       % second order filter
Wn = Fc/(Fs/2);  % normalize cut-off frequency (Fc) by half of sampling frequency (Fs)
[d,c] = butter(ordem,Wn,'low'); % filter type: low-pass butterworth
data_filtered=filtfilt(d,c,data) ; % filter become 4th order because it is passed twice
end