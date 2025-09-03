k = 8;
B = 85;
nm = 34;%9 14 19 24 29 34
case_name = 'case85';

load("V_noise.mat")

mae_G_Fusion = func_G_Fusion(V,k,nm);
mae_P_Base = func_P_Base(V,k,nm);
mae_G_Volt = func_G_Volt(V,k,nm);
mae_G_base = func_G_base(V,k,nm);
