function Hi_simple_3 = Hi_simple_create(Sm,Y_k,i,B)
%     ey = eye(B);
%     eiei = ey(i,:).' * ey(i,:);
%     %eiYk = ey(i,:).' * conj(Y_k(i,:));
%     test1 = ey(i,:) * Y_k;
%     YkYk = test1.' * conj(test1);
%     eiYk = ey(i,:).' * conj(test1);
% 
%     
%     %使用'作为转置
%     Hm_i_1 = vec(eiei).';
%     Hm_i_2 = vec(eiYk).';
%     Hm_i_3 = vec(YkYk).';
%     Hi_simple_3 = [Hm_i_1;Hm_i_2;Hm_i_3];
    % SmUk_ = Sm * conj(U);
    SmUk = Sm;
    % SmY_Uk_ = Sm * conj(Y_k) * conj(U);
    SmYUk = Sm * Y_k;
    UkHSmT = Sm.';
    UkHYHSmT = Y_k' * Sm.';

    
    % SmUk_i = SmUk_(i,:);
    SmUki = SmUk(i,:);
    % SmY_Uk_i = SmY_Uk_(i,:);
    SmYUki = SmYUk(i,:);
    UkHSmTi = UkHSmT(:,i);
    UkHYHSmTi = UkHYHSmT(:,i);

    
    %使用'作为转置
    Hm_i_1 = vec(SmUki.' * UkHSmTi.').';
    Hm_i_2 = vec(SmUki.' * UkHYHSmTi.').';
    Hm_i_3 = vec(SmYUki.' * UkHYHSmTi.').';
    Hi_simple_3 = [Hm_i_1;Hm_i_2;Hm_i_3];

end