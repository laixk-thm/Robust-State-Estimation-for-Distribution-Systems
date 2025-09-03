function V = func_wrong_V_85()
    k = 24;
    B = 85;
    nm = 60;
    nm_w = 4;
    case_name = 'case85';

    [V_ori,Y,~,~,~] = Y_create(case_name,B);
    [Y_k,U,A,U_Z,U_kb] = Y_decompose(Y,k,B);%Y_decompose_new
    
    [Sm,~] = Sm_create(Y_k,U,k,B,nm);%y_k -> y
    [index,~] = find(Sm'>0);
    
    % no noise
    V = V_ori;

    wrong_index = index(randperm(nm,nm_w+1));
    if ismember(1,wrong_index)
        wrong_index(wrong_index == 1) = [];
    else
        wrong_index(1) = [];
    end

    wrong_amp = [0.03,-0.02,0.025,-0.03,0.04,-0.02,0.02,-0.027]';
    
    V(wrong_index) = V_ori(wrong_index) + wrong_amp(1:nm_w);


end