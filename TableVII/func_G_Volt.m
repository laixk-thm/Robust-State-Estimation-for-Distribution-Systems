function [Wopt_V_case,mae_G_Volt] = func_G_Volt(V,case_name,k,nm,B)


% k = 22;
% B = 85;
% nm = 24;
% case_name = 'case85';

[V_base,Y,S,I,X] = Y_create(case_name,B);
V_abs = abs(V_base);

[Y_k,U,~,~,~] = Y_decompose(Y,k,B);%Y_decompose_new
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%虚拟量测IS
% [Sm,~] = Sm_create_V(Y,U,k,B,nm);
[Sm,~] = Sm_create(Y,U,k,B,nm);

W_V_rough = V*V';
W_I_rough = Y*W_V_rough*Y';

Hm_IS = Hm_create_version2(Sm,nm,k,Y,U,1);
Xm_IS = Xm_create_version2(W_V_rough,W_I_rough,Y,nm,Sm,1);
Hm_V = Hm_create_version2(Sm,nm,k,Y,U,0);
Xm_V = Xm_create_version2(W_V_rough,W_I_rough,Y,nm,Sm,0);

cvx_begin sdp
    variable Wopt(k,k) Hermitian
    minimize norm( Xm_IS - Hm_IS * vec(Wopt))
    subject to 
        Wopt >= 0;
        norm(Xm_V-Hm_V*vec(Wopt)) <= 0.1
        Vs_opt1 = U(1,:) * Wopt * U(1,:)';
        Vs_opt1 == 1;
cvx_end
Wopt_return = U * Wopt * U' ;
Wopt_V_case = sqrt(diag(Wopt_return));
mae_G_Volt = mean(abs(Wopt_V_case-V_abs));
F_G_Volt = norm(Wopt_V_case-V_abs,'F');


