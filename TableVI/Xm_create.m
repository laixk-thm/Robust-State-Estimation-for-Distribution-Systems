function Xm = Xm_create_version1(W_V,W_I,Y,nm,Sm)
%     Vm = Sm * V;
%     Im = Sm * I;
%     S_m = Sm * S;
    Vm = Sm * diag(W_V);
    Im = Sm * diag(W_I);
    S_m = Sm * diag(W_V*Y');
    Xm = zeros(3 * nm,1);
    count = 1;
    for i = 1:nm
        Xm(count,:) = Vm(i,:);
        Xm(count+1,:) = S_m(i,:);
        Xm(count+2,:) = Im(i,:);
        count = count + 3;
    end
end