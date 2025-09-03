function mae = IEEE_func_case136(k,nm)
% k = 8;
B = 136;
% nm = 8;
case_name = 'case136ma';

[V,Y,S,I,X] = Y_create(case_name,B);
V_abs = abs(V);

[Y_k,U,~,~,~] = Y_decompose(Y,k,B);%Y_decompose_new

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%量测VIS
[Sm,~] = Sm_create_1(Y,U,k,B,nm);%y_k -> y

Hm = Hm_create(Sm,nm,k,Y,U);
Xm = Xm_create_version1(V*V',Y*V*V'*Y',Y,nm,Sm);

cvx_begin sdp
    variable Wopt(k,k) Hermitian
    minimize norm( Xm - Hm * vec(Wopt))
    subject to 
        Wopt >= 0;
        Vs_opt = U(1,:) * Wopt * U(1,:)';
        Vs_opt == 1;
cvx_end
Wopt_return = U * Wopt * U' ;
Wopt_V_case1 = sqrt(diag(Wopt_return));

mae1 = mean(abs(Wopt_V_case1-V_abs));
F_norm1 = norm(Wopt_V_case1-V_abs,'F');
mdl1 = fitlm(abs(Wopt_V_case1), V_abs);
rsquared1 = mdl1.Rsquared.Ordinary;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%虚拟量测IS
[Sm,~] = Sm_create_V(Y_k,U,k,B,nm);

V_mat_rough = U*pinv(Sm*U)*Sm*V;

W_V_rough = (U*U')*(V_mat_rough*V_mat_rough')*(U*U');
W_I_rough = Y_k*W_V_rough*Y_k';

Hm_IS = Hm_create_version2(Sm,nm,k,Y_k,U,1);
Xm_IS = Xm_create_version2(W_V_rough,W_I_rough,Y_k,nm,Sm,1);
Hm_V = Hm_create_version2(Sm,nm,k,Y_k,U,0);
Xm_V = Xm_create_version2(W_V_rough,W_I_rough,Y_k,nm,Sm,0);

cvx_begin sdp
    variable Wopt(k,k) Hermitian
    minimize norm( Xm_IS - Hm_IS * vec(Wopt))
    subject to 
        Wopt >= 0;
        norm(Xm_V-Hm_V*vec(Wopt)) <= 0.08
        Vs_opt1 = U(1,:) * Wopt * U(1,:)';
        Vs_opt1 == 1;
cvx_end
Wopt_return = U * Wopt * U' ;
Wopt_V_case2 = sqrt(diag(Wopt_return));

mae2 = mean(abs(Wopt_V_case2-V_abs));
F_norm2 = norm(Wopt_V_case2-V_abs,'F');
mdl2 = fitlm(abs(Wopt_V_case2), V_abs);
rsquared2 = mdl2.Rsquared.Ordinary;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SDP方法
% [Sm,~] = Sm_create_1(Y_k,U,k,B,nm);%y_k -> y
Hi = Hi_simple_all(Y,B,nm,Sm);
Xm = Xm_create_version1(V*V',Y*V*V'*Y',Y,nm,Sm);

cvx_begin sdp
    variable Wopt(B,B) Hermitian
    minimize norm( Xm - Hi * vec(Wopt))
    subject to 
        norm(diag(Wopt)) < 14
        Wopt >= 0;
        Wopt(1,1) == 1;
cvx_end
Wopt_return = full(Wopt) ;
Wopt_V_case3 = sqrt(diag(Wopt_return));

mae3 = mean(abs(Wopt_V_case3-V_abs));
F_norm3 = norm(Wopt_V_case3-V_abs,'F');
mdl3 = fitlm(abs(Wopt_V_case3), V_abs);
rsquared3 = mdl1.Rsquared.Ordinary;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mae = [mae1,mae2,mae3];
% plot(abs(V_mat_rough))
% hold on
% plot(abs(Wopt_V_case1))
% hold on
% plot(abs(Wopt_V_case2))
% hold on
% plot(abs(V))
% legend('V-mat','Wopt1','Wopt2','V')
end

