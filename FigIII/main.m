% k = 46;
% nm = 56;
k = 26;
nm = 46;
B = 136;
case_name = 'case136ma';

% [V_base,Y,S,I,X] = Y_create(case_name,B);
% V = V_base + 0.001*randn(136,1);

load("rawdata_15.mat")
Vm = raw.vm;
Va = raw.va / 180 *pi;
V = Vm.*cos(Va)+1i*Vm.*sin(Va);

V_Fusion = zeros(136,480);
V_Approx = zeros(136,480);
V_res = zeros(136,480);

index = 1;
for i = 1:60:28799
    V_tmp = V(:,index);
    V_G_Fusion = func_G_Fusion(V_tmp,k,nm);
    V_G_Approx = func_G_Approx(V_tmp,k,nm);
    V_Fusion(:,index) = V_G_Fusion;
    V_Approx(:,index) = V_G_Approx;
    V_res(:,index) = V_tmp;
    index = index + 1;
end

% V_G_Fusion = func_G_Fusion(V,k,nm);
% V_G_Approx = func_G_Approx(V,k,nm);
% plot(abs(V_G_Approx))
% hold on
% plot(abs(V_G_Fusion))
% hold on
% plot(abs(V_base),linewidth=2)
