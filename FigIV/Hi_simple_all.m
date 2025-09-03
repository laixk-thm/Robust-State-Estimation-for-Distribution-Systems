function Hi = Hi_simple_all(Y_k,B,nm,Sm)

    %ns = 24;%未知
    %k = 24;
    count = 1;
    Hi = zeros(3*nm,B*B);
    for i = 1:nm
        Hmi = Hi_simple_create(Sm,Y_k,i,B);
        % Hmi = Hi_create_new(Sm,Y_k,U,i);
        Hi(count,:) = Hmi(1,:);
        Hi(count+1,:) = Hmi(2,:);
        Hi(count+2,:) = Hmi(3,:);
        count = count + 3;
    end
end