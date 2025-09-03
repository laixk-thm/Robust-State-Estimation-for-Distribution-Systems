function mae_G_base = func_G_base(V,k,nm)


% k = 22;
B = 85;
% nm = 24;
case_name = 'case85';

[V_base,Y,S,I,X] = Y_create(case_name,B);
V_abs = abs(V_base);

[Y_k,U,~,~,~] = Y_decompose(Y,k,B);%Y_decompose_new
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%虚拟量测IS
% [Sm,~] = Sm_create_V(Y,U,k,B,nm);
[Sm,~] = Sm_create(Y,U,k,B,nm);

W_V_rough = V*V';
W_I_rough = Y*W_V_rough*Y';

Hm = Hm_create(Sm,nm,k,Y,U);
Xm = Xm_create(W_V_rough,W_I_rough,Y,nm,Sm);

cvx_begin sdp
    variable Wopt(k,k) Hermitian
    minimize norm( Xm - Hm * vec(Wopt))
    subject to 
        Wopt >= 0;
        Vs_opt1 = U(1,:) * Wopt * U(1,:)';
        Vs_opt1 == 1;
cvx_end
Wopt_return = U * Wopt * U' ;
Wopt_V_case = sqrt(diag(Wopt_return));

mae_G_base = mean(abs(Wopt_V_case-V_abs));


