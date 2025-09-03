% case85
k = 24;
B = 85;
nm = 60;
case_name = 'case85';

iter = 500;
V_res = zeros(85,iter);
V_G_SW_res = zeros(85,iter);
V_G_FO_res = zeros(85,iter);
V_G_VO_res = zeros(85,iter);
V_G_BO_res = zeros(85,iter);

for i = 1:iter
    [V,Wrong_index] = func_wrong_V_85();
    
    [V_G_SW,mae_G_SW] = func_G_Fusion_SW(V,case_name,k,nm,B);
    [V_G_FO,mae_G_FO] = func_G_Fusion(V,case_name,k,nm,B);
    [V_G_VO,mae_G_VO] = func_G_Volt(V,case_name,k,nm,B);
    [V_G_BO,mae_G_BO] = func_G_base(V,case_name,k,nm,B);

    V_G_SW_res(:,i) = V_G_SW;
    V_G_FO_res(:,i) = V_G_FO;
    V_G_VO_res(:,i) = V_G_VO;
    V_G_BO_res(:,i) = V_G_BO;
    V_res(:,i) = V;
end