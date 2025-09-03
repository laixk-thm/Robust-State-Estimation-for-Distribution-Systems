function V_E_2 = func_case136ma_SW(V)
k = 34;
B = 136;
nm = 90;
% nm_w = 8;
case_name = 'case136ma';

[V_ori,Y,~,~,~] = Y_create(case_name,B);
V_abs = abs(V_ori);
[Y_k,U,A,U_Z,U_kb] = Y_decompose(Y,k,B);%Y_decompose_new

%pesudo
[Sm,~] = Sm_create_V(Y_k,U,k,B,nm);%y_k -> y

V_mat_rough = U*pinv(Sm*U)*Sm*V;
V_e_mat = pinv(Sm*U*pinv(Sm*U)*Sm*U_kb*U_kb'-Sm*U_kb*U_kb')*(Sm*V_mat_rough-Sm*V);
V_e_mat(1) = 0;
V_fre_e_mat = U_Z'*V_e_mat;
V_e_mat_mean = mean(V_e_mat);
V_e_mat_var = std(V_e_mat);
mat_wrong = union(find(V_e_mat > V_e_mat_mean+2.3*V_e_mat_var),find(V_e_mat < V_e_mat_mean-2.3*V_e_mat_var));
V_E_1 = zeros(B,1);
V_E_1(mat_wrong) = V_e_mat(mat_wrong);

% 滑动窗口考察异常量测的图低频分量
V_1 = V - V_E_1;
V_1 = V;
window_slide = 2;
V_fre_win_res = zeros(k,k-window_slide);
V_win_res = zeros(B,k-window_slide);
V_e_win_res = zeros(B,k-window_slide);
V_fre_e_win_res = zeros(B,k-window_slide);
V_fre_e_win_concat = [];%将滑动窗口的数拼在一起,效果巨差
for i = 4:k-window_slide
    U_k_slide = U;
    U_kb_slide = [U_k_slide(:,[1+i,2+i]),U_Z(:,k+1:B)];
    U_k_slide(:,[1+i,2+i]) = [];
    UU_kb_slide = eye(B)-U_k_slide*U_k_slide';
    V_fre_win_mat = pinv(Sm*U_k_slide)*Sm*V_1;

    V_fre_win_diff = (U_Z'*U*pinv(Sm*U)*Sm*V_1)./(diag(log(A)) ./ (0.5*log(A(3,3))) );% 减去差额部分
    V_fre_win_diff(1) = 0;

    V_alpha_A = diag(log(A(1:k,1:k)));
    V_alpha = [0;0;flip(V_alpha_A(3:k))];

    V_e_win = pinv(Sm*U_k_slide*pinv(Sm*U_k_slide)*Sm*UU_kb_slide-Sm*UU_kb_slide)*(Sm*U_k_slide*V_fre_win_mat-Sm*V_1);
    V_fre_e_win = U_Z'*V_e_win;

%     V_fre_e_win([1+i,2+i]) = V_fre_e_win([1+i,2+i])-  V_fre_win_diff([1+i,2+i]);% 观察需要减去多少差额
    V_fre_e_win([1+i,2+i]) = V_fre_e_win([1+i,2+i]) ./ V_alpha([1+i,2+i]) ;% 乘以系数

    V_win_mat = U_k_slide*V_fre_win_mat;
    V_fre_win_res(:,i) = [V_fre_win_mat(1:i);zeros(window_slide,1);V_fre_win_mat(i+window_slide-1:k-window_slide)];
    V_win_res(:,i) = V_win_mat;
    V_e_win_res(:,i) = V_e_win;
    V_fre_e_win_res(:,i) = V_fre_e_win;

%     V_fre_e_slide = U_Z'*V_e_slide;
%     V_fre_e_slide_concat = [V_fre_e_slide_concat,V_fre_e_slide([1+i,2+i])];
end

% 前k个维度需要除以窗口长度
V_fre_e_win_k_mean = sum(V_fre_e_win_res,2)/window_slide;
V_fre_e_win_k_mean([2,k]) = [V_fre_e_win_res(2,2);V_fre_e_win_res(k,k-window_slide)];
% 后b-k个维度需要求平均
V_fre_e_win_kb_mean = mean(V_fre_e_win_res,2);
V_fre_e_concat = [V_fre_e_win_k_mean(1:k);V_fre_e_win_kb_mean(k+1:B)];
V_e_concat = U_Z*V_fre_e_concat;

V_e_concat(1) = 0;
V_e_slide_mean = mean(V_e_concat);
V_e_slide_var = std(V_e_concat);
mat_wrong_2 = union(find(V_e_concat > V_e_slide_mean+2.3*V_e_slide_var),find(V_e_concat < V_e_slide_mean-2.3*V_e_slide_var));
V_E_2 = zeros(B,1);
V_E_2(mat_wrong_2) = V_e_concat(mat_wrong_2);

end
