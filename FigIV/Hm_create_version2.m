function Hm = Hm_create_version2(Sm,nm,k,Y_k,U,index)

    %ns = 24;%未知
    %k = 24;
    count = 1;
    if index == 0
        Hm = zeros(nm,k*k);
        for i = 1:nm
            Hmi = Hi_create(Sm,Y_k,U,i);
            % Hmi = Hi_create_new(Sm,Y_k,U,i);
            Hm(count,:) = Hmi(1,:);
%             Hm(count+1,:) = Hmi(2,:);
%             Hm(count+2,:) = Hmi(3,:);
            count = count + 1;
        end
    elseif index == 1
        Hm = zeros(2*nm,k*k);
        for i = 1:nm
            Hmi = Hi_create(Sm,Y_k,U,i);
            % Hmi = Hi_create_new(Sm,Y_k,U,i);
    %         Hm(count,:) = Hmi(1,:);
            Hm(count,:) = Hmi(2,:);
            Hm(count+1,:) = Hmi(3,:);
            count = count + 2;
        end
    end
end