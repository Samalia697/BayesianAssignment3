function [p] = bernouli_pdf(theta,y)
p=(theta^y)*((1-theta)^(1-y));
end

