
case_name = "case85";
B = 85;
k = 9;
nm = 9;
nm_list_85 = [10,17,25,34,42,51,59,68,76,85];
% nm_list_85 = [10,17,25,34,42,51];

[V,Y,S,I,X] = Y_create(case_name,B);
V = V + 0.004*rand(B,1);

% Vm = raw.vm;
% Va = raw.va / 180 *pi;
% V_all = Vm.*cos(Va)+1i*Vm.*sin(Va);
% V = V_all(:,100);

% mae_G_Fusion = func_G_Fusion(V,case_name,k,nm,B);
% mae_G_Volt = func_G_Volt(V,case_name,k,nm,B);
% mae_A_Base = func_A_Base(V,case_name,k,nm,B);

mae85 = [];
for i = 1:length(nm_list_85)
    nm_tmp_85 = nm_list_85(i);
    mae_G_Fusion = func_G_Fusion(V,case_name,k,nm_tmp_85,B);
    mae_G_Volt = func_G_Volt(V,case_name,k,nm_tmp_85,B);
    mae_G_Base = func_G_Base(V,case_name,k,nm_tmp_85,B);
    mae85_tmp = [mae_G_Fusion,mae_G_Volt,mae_G_Base];
    mae85 = [mae85;mae85_tmp];
end
