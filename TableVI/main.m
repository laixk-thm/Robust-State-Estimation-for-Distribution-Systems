% case85
% k = 24;
% B = 85;
% nm = 60;
% case_name = 'case85';
% V = func_wrong_V_85();

% case136ma
k = 34;
B = 136;
nm = 90;
case_name = 'case136ma';
% V = func_wrong_V_136ma();
load("V_136.mat");


[mae_G_Fusion,F_G_Fusion] = func_G_Fusion_SW(V,case_name,k,nm,B);
[mae_G_FO,F_G_FO] = func_G_Fusion(V,case_name,k,nm,B);
[mae_P_BO,F_P_BO] = func_P_Base(V,case_name,k,nm,B);
[mae_G_VO,F_G_VO] = func_G_Volt(V,case_name,k,nm,B);
[mae_G_BO,F_G_BO] = func_G_base(V,case_name,k,nm,B);
