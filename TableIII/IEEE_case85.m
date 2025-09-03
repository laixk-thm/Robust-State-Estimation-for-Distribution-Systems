
k = 22;
B = 85;
nm = 24;
case_name = 'case85';

[V,Y,S,I,X] = Y_create(case_name,B);
V_abs = abs(V);

[Y_k,U,~,~,~] = Y_decompose(Y,k,B);%Y_decompose_new
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%虚拟量测IS
[Sm,~] = Sm_create_V(Y_k,U,k,B,nm);

V_mat_rough = U*pinv(Sm*U)*Sm*V;
mae1 = mean(abs(abs(V_mat_rough)-V_abs));
F_norm1 = norm(abs(V_mat_rough)-V_abs,'F');

W_V_rough = (U*U')*(V_mat_rough*V_mat_rough')*(U*U');
W_I_rough = Y_k*W_V_rough*Y_k';

Hm_IS = Hm_create_version2(Sm,nm,k,Y_k,U,1);
Xm_IS = Xm_create_version2(W_V_rough,W_I_rough,Y_k,nm,Sm,1);
Hm_V = Hm_create_version2(Sm,nm,k,Y_k,U,0);
Xm_V = Xm_create_version2(W_V_rough,W_I_rough,Y_k,nm,Sm,0);

cvx_begin sdp
    variable Wopt(k,k) Hermitian
    minimize norm( Xm_IS - Hm_IS * vec(Wopt))
    subject to 
        Wopt >= 0;
        norm(Xm_V-Hm_V*vec(Wopt)) <= 0.04
        Vs_opt1 = U(1,:) * Wopt * U(1,:)';
        Vs_opt1 == 1;
cvx_end
Wopt_return = U * Wopt * U' ;
Wopt_V_case2 = sqrt(diag(Wopt_return));

mae2 = mean(abs(Wopt_V_case2-V_abs));
F_norm2 = norm(Wopt_V_case2-V_abs,'F');


