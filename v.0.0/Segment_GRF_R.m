    function [x] = Segment_COP_R(data,b,c,n)
            for ns=1:n
            x{1,ns}=data{1,1}(b(1,ns):c(ns));% AP GRF
            x{2,ns}=data{2,1}(b(1,ns):c(ns));% V GRF
            x{3,ns}=data{3,1}(b(1,ns):c(ns));% ML GRF
            end
     end