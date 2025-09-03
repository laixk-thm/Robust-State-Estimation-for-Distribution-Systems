function Wopt_V_case = func_G_Fusion(V,k,nm)

B = 136;
case_name = 'case136ma';

[V_base,Y,S,I,X] = Y_create(case_name,B);
V_abs = abs(V_base);

[Y_k,U,~,~,~] = Y_decompose(Y,k,B);%Y_decompose_new
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%虚拟量测IS
% [Sm,~] = Sm_create_V(Y,U,k,B,nm);
[Sm,~] = Sm_create(Y_k,U,k,B,nm);

V_mat_rough = U*pinv(Sm*U)*Sm*V;

W_V_rough = V_mat_rough*V_mat_rough';
W_I_rough = Y_k*W_V_rough*Y_k';

Hm_IS = Hm_create_version2(Sm,nm,k,Y_k,U,1);
Xm_IS = Xm_create_version2(W_V_rough,W_I_rough,Y_k,nm,Sm,1);
Hm_V = Hm_create_version2(Sm,nm,k,Y_k,U,0);
Xm_V = Xm_create_version2(V*V',W_I_rough,Y_k,nm,Sm,0);
if nm<0.25*B,alpha=0.03;else, alpha=0.04; end
% alpha = 0.0008+0.002*nm;

cvx_begin sdp
    variable Wopt(k,k) Hermitian
    minimize norm( Xm_IS - Hm_IS * vec(Wopt))
    subject to 
        Wopt >= 0;
        norm(Xm_V-Hm_V*vec(Wopt)) <= alpha
        Vs_opt1 = U(1,:) * Wopt * U(1,:)';
        Vs_opt1 == 1;
cvx_end
Wopt_return = U * Wopt * U' ;
Wopt_V_case = sqrt(diag(Wopt_return));
mae_G_Fusion = mean(abs(Wopt_V_case-V_abs));


