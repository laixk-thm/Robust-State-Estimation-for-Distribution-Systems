    
function [Sm,Hm] = Sm_create_V(Y_k,U,k,B,nm)
    pos = zeros(1,nm);
    Sigma_max = zeros(1,nm);
    Sm = zeros(nm,B);
    for j = 1:nm
        Sigma_line = zeros(1,B);
        for i = 1:B%每一列表示选取B中哪个节点
            if(~ismember(i,pos))
                Sm(j,i) = 1;
                % Hm = Hm_create(Sm,nm,k,Y_k,U);
                SmUk = Sm * U;
%                 SmYUk = Sm * Y_k * U;
                [U_temp,Sigma_1,V_temp] = svd(SmUk);
%                 [U_temp,Sigma_2,V_temp] = svd(SmYUk);
                Sigma_temp = min(Sigma_1(Sigma_1 ~= 0));
%                 Sigma_temp_2 = min(Sigma_2(Sigma_2 ~= 0));
%                 Sigma_temp = min(Sigma_temp_1,Sigma_temp_2);
                if isempty(Sigma_temp)
                    Sigma_temp = 0;
                end
                Sigma_line(i) = Sigma_temp;
                Sm(j,i) = 0;
            end
        end
        [Sigma_max_temp,index_temp] = max(Sigma_line);
        Sm(j,index_temp) = 1;
        pos(j) = index_temp;
        Sigma_max(i) = Sigma_max_temp;
    end
%     Hm = Hm_create(Sm,nm,k,Y_k,U);
    Hm = 0;
end