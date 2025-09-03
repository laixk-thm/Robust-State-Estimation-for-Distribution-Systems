function [V,Y,S,I,X] = Y_create(case_name,B)
    MC = runpf(case_name);

    YBUS = makeYbus(MC);
    PL = MC.bus(:,3);
    QL = MC.bus(:,4);

    
    mag = MC.bus(:,8);
    ang = MC.bus(:,9);
    rad = ang / 180 * pi;

    Y_temp = zeros(B,B);
    V_temp = zeros(B,1);
    S_temp = zeros(B,1);
    X_temp = zeros(3 * B,1);
    for i = 1:B
        for j = 1:B
            Y_temp(i,j) = YBUS(i,j);
        end
        S_temp(i,:) = PL(i,:) + QL(i,:)*1i;
    end  
    
    for i = 1:size(mag)
        Um = mag(i,:) * cos(rad(i,:));
        Ua = mag(i,:) * sin(rad(i,:));
        V_temp(i,:) = Um + Ua*1i;
    end

    Y = Y_temp;
    V = V_temp;
    S = S_temp;
    I = Y * V;

    V_diag = diag(V * V');
    I_diag = diag(I * I');
    S_diag = diag(V * I');
    count = 1;
    for i = 1:B
        X_temp(count,:) = V_diag(i,:);
        X_temp(count+1,:) = S_diag(i,:);
        X_temp(count+2,:) = I_diag(i,:);
        count = count + 3;
    end
    X = X_temp;
end
