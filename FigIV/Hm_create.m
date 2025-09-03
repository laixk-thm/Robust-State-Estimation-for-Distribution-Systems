function Hm = Hm_create(Sm,nm,k,Y_k,U)

    %ns = 24;%未知
    %k = 24;
    count = 1;
    Hm = zeros(3*nm,k*k);
    for i = 1:nm
        Hmi = Hi_create(Sm,Y_k,U,i);
        % Hmi = Hi_create_new(Sm,Y_k,U,i);
        Hm(count,:) = Hmi(1,:);
        Hm(count+1,:) = Hmi(2,:);
        Hm(count+2,:) = Hmi(3,:);
        count = count + 3;
    end
end