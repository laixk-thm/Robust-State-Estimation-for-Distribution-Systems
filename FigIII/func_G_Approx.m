function V_mat_abs = func_G_Approx(V,k,nm)

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
V_mat_abs = abs(V_mat_rough);

mae_G_Approx = mean(abs(V_mat_abs-V_abs));


