function V = func_wrong_V_136ma()
    k = 34;
    B = 136;
    nm = 90;
    nm_w = 6;
    case_name = 'case136ma';
    
    [V_ori,Y,~,~,~] = Y_create(case_name,B);
    V_abs = abs(V_ori);
    [Y_k,U,A,U_Z,U_kb] = Y_decompose(Y,k,B);%Y_decompose_new
    
    %pesudo
    [Sm,~] = Sm_create_V(Y_k,U,k,B,nm);%y_k -> y
    [index,~] = find(Sm'>0);
    
    % no noise
    V = V_ori;
    
    % wrong_index = [4,12,16,22];
    % wrong_amp = [0.03,-0.02,0.025,-0.03]';
    wrong_index = index(randperm(nm,nm_w+1));
    if ismember(1,wrong_index)
        wrong_index(wrong_index == 1) = [];
    else
        wrong_index(1) = [];
    end
    
    % wrong_index = index(randi(nm,1,4));
    % wrong_index = [49;22;42;46];
    wrong_amp = [0.03,-0.02,0.025,-0.03,0.04,-0.02,0.02,-0.027,0.031,0.027,-0.031,0.02,-0.024,0.031]';
    
    V(wrong_index) = V_ori(wrong_index) + wrong_amp(1:nm_w);


end