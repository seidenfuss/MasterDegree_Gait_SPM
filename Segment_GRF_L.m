    function [x] = Segment_GRF_L(data,b,c,n)
            for ns=1:n
            x{1,ns}=data{4,1}(b(1,ns):c(ns));% AP GRF
            x{2,ns}=data{5,1}(b(1,ns):c(ns));% V GRF
            x{3,ns}=data{6,1}(b(1,ns):c(ns));% ML GRF
            end
    end