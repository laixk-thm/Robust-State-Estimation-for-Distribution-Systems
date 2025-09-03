
case_name = "case136ma";
B = 136;
k = 13;
nm = 136;
nm_list_136 = [14,27,40,54,68,82,95,108,122,136];
% nm_list_136 = [14,27,40,54,68];

[V,Y,S,I,X] = Y_create(case_name,B);
V = V + 0.004*rand(B,1);

% mae_G_Fusion = func_G_Fusion(V,case_name,k,nm,B);
% mae_G_Volt = func_G_Volt(V,case_name,k,nm,B);
% mae_A_Base = func_A_Base(V,case_name,k,nm,B);

mae136 = [];
for i = 1:length(nm_list_136)
    nm_tmp_136 = nm_list_136(i);
    mae_G_Fusion = func_G_Fusion(V,case_name,k,nm_tmp_136,B);
    mae_G_Volt = func_G_Volt(V,case_name,k,nm_tmp_136,B);
    mae_G_Base = func_G_Base(V,case_name,k,nm_tmp_136,B);
    mae136_tmp = [mae_G_Fusion,mae_G_Volt,mae_G_Base];
    mae136 = [mae136;mae136_tmp];
end
