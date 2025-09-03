function Hm_i = Hi_create(Sm,Y_k,U,i)
    % SmUk_ = Sm * conj(U);
    SmUk = Sm * U;
    % SmY_Uk_ = Sm * conj(Y_k) * conj(U);
    SmYUk = Sm * Y_k * U;
    UkHSmT = U' * Sm.';
    UkHYHSmT = U' * Y_k' * Sm.';

    
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
    Hm_i = [Hm_i_1;Hm_i_2;Hm_i_3];


end

