function [Keq X1 X2] = Springs_in_Series(K1,K2,F)
%Springs_in_Series : quickly computes the equivalent spring constant and
%  the two displacements of two connected springs

Keq = 1 / (1/K1 + 1/K2);
X1 = F / K1;
X2 = F / K2;

end

