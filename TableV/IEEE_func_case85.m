function [recall,f1] = IEEE_func_case85(nm_w)
k = 24;
B = 85;
nm = 60;
% nm_w = 8;
case_name = 'case85';

[V_ori,Y,~,~,~] = Y_create(case_name,B);
V_abs = abs(V_ori);
[Y_k,U,A,U_Z,U_kb] = Y_decompose(Y,k,B);%Y_decompose_new

%pesudo
[Sm,~] = Sm_create_V(Y_k,U,k,B,nm);%y_k -> y
[index,~] = find(Sm'>0);

% no noise
V = V_ori;

% wrong_index = [4,12,16,22];
% wrong_amp = [0.03,-0.02,0.025,-0.03]';
wrong_index = index(randperm(nm,nm_w+1));
if ismember(1,wrong_index)
    wrong_index(wrong_index == 1) = [];
else
    wrong_index(1) = [];
end

% wrong_index = index(randi(nm,1,4));
% wrong_index = [49;22;42;46];
wrong_amp = [0.03,-0.02,0.025,-0.03,0.04,-0.02,0.02,-0.027]';

V(wrong_index) = V_ori(wrong_index) + wrong_amp(1:nm_w);
V_wrong = V-V_ori;

V_only = V_ori;
V_only(wrong_index) = V_ori(wrong_index) + wrong_amp(1:nm_w);
V_wrong_only = V_only - V_ori;

V_fre_wrong_only = U_Z'*V_wrong_only;

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
for i = 2:k-window_slide
    U_k_slide = U;
    U_kb_slide = [U_k_slide(:,[1+i,2+i]),U_Z(:,k+1:B)];
    U_k_slide(:,[1+i,2+i]) = [];
    UU_kb_slide = eye(B)-U_k_slide*U_k_slide';
    V_fre_win_mat = pinv(Sm*U_k_slide)*Sm*V_1;

    V_fre_win_diff = (U_Z'*U*pinv(Sm*U)*Sm*V_1)./(diag(log(A)) ./ (0.5*log(A(3,3))) );% 减去差额部分
    V_fre_win_diff(1) = 0;

    V_alpha_A = 3*diag(log(A(1:k,1:k)));
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
mat_wrong_2 = union(find(V_e_concat > V_e_slide_mean+2*V_e_slide_var),find(V_e_concat < V_e_slide_mean-2*V_e_slide_var));
V_E_2 = zeros(B,1);
V_E_2(mat_wrong_2) = V_e_concat(mat_wrong_2);

% ---------计算召回率与F1---------------
pre_wrong_1 = zeros(B,1);
pre_wrong_2 = zeros(B,1);
true_wrong = zeros(B,1);

pre_wrong_1(mat_wrong) = 1;
pre_wrong_2(mat_wrong_2) = 1;
true_wrong(wrong_index) = 1;

recall_1 = sum(pre_wrong_1 == true_wrong & pre_wrong_1 == 1) / sum(true_wrong == 1);
precision_1 = sum(pre_wrong_1 == true_wrong & pre_wrong_1 == 1) / sum(pre_wrong_1 == 1);
f1_score_1 = 2 * (precision_1 * recall_1) / (precision_1 + recall_1);

recall_2 = sum(pre_wrong_2 == true_wrong & pre_wrong_2 == 1) / sum(true_wrong == 1);
precision_2 = sum(pre_wrong_2 == true_wrong & pre_wrong_2 == 1) / sum(pre_wrong_2 == 1);
f1_score_2 = 2 * (precision_2 * recall_2) / (precision_2 + recall_2);

recall = [recall_1,recall_2];
f1 = [f1_score_1,f1_score_2];

% plot(real(V_E_1))
% hold on
% plot(real(V_E_2))
% hold on
% plot(real(V_wrong_only),LineWidth=2)
end
