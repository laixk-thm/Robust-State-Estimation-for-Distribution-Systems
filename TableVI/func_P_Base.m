function [mae_P_Base,F_P_Base] = func_P_Base(V,case_name,k,nm,B)
% k = 22;
% B = 85;
% nm = 24;
% case_name = 'case85';

[V_base,Y,S,I,X] = Y_create(case_name,B);
V_abs = abs(V_base);

[Y_k,U,~,~,~] = Y_decompose(Y,k,B);%Y_decompose_new
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%虚拟量测IS
% [Sm,~] = Sm_create_V(Y_k,U,k,B,nm);
[Sm,~] = Sm_create(Y_k,U,k,B,nm);

if case_name == "case85"
    V_E = func_case85_SW(V);
else
    V_E = func_case136ma_SW(V);
end
% V = V -V_E;

V_mat_rough = U*pinv(Sm*U)*Sm*V;
V_mat_abs = abs(V_mat_rough);

mae_P_Base = mean(abs(V_mat_abs-V_abs));
F_P_Base = norm(V_mat_abs-V_abs,'F');


