function [n,yields] = dE2electrons(dEs) % returns an integer number of electrons
    
yields = zeros(1,length(dEs));

for i = 1:length(dEs)
    if dEs(i) < 10 % keV
        yields(i) = mLin(60,1,-31,dEs(i));

    elseif dEs(i) < 43 % keV
        yields(i) = mLin(29,10,23.6792,dEs(i));

    elseif dEs(i) < 130 % keV
        yields(i) = mLin(40,43,20.8137,dEs(i));

    else
        yields(i) = mLin(50,130,5.4708,dEs(i));

    end
end

n = floor(diag(yields' * dEs));
%n = diag(yields' * dEs);

end

function y = mLin(y_ix,x_ix,m_x,x) % returns the yield electrons / keV
    y = y_ix + m_x*log10(x/x_ix);
end