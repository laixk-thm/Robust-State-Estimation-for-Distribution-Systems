function Xm = Xm_create_version2(W_V,W_I,Y,nm,Sm,index)
%     Vm = Sm * V;
%     Im = Sm * I;
%     S_m = Sm * S;
    Vm = Sm * diag(W_V);
    Im = Sm * diag(W_I);
    S_m = Sm * diag(W_V*Y');
    if index == 0
        Xm = zeros(nm,1);
        count = 1;
        for i = 1:nm
            Xm(count,:) = Vm(i,:);
%             Xm(count+1,:) = S_m(i,:);
%             Xm(count+2,:) = Im(i,:);
            count = count + 1;
        end
    elseif index ==1
        Xm = zeros(2 * nm,1);
        count = 1;
        for i = 1:nm
            Xm(count,:) = S_m(i,:);
            Xm(count+1,:) = Im(i,:);
            count = count + 2;
        end
    end

end