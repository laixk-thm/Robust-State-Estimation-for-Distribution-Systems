function mae_A_Base = func_A_Base(V,case_name,k,nm,B)

    [V_base,Y,S,I,X] = Y_create(case_name,B);
    V_abs = abs(V_base);
    
    [Y_k,U,~,~,~] = Y_decompose(Y,k,B);%Y_decompose_new
    [Sm,~] = Sm_create(Y_k,U,k,B,nm);%y_k -> y
    Hi = Hi_simple_all(Y,B,nm,Sm);
    Xm = Xm_create(V*V',Y*V*V'*Y',Y,nm,Sm);
%     if B<100,alpha=9;else, alpha=14; end
    alpha = 0.1*B;
    
    cvx_begin sdp
        variable Wopt(B,B) Hermitian
        minimize norm( Xm - Hi * vec(Wopt))
        subject to 
            norm(diag(Wopt)) < alpha
            Wopt >= 0;
            Wopt(1,1) == 1;
    cvx_end
    Wopt_return = full(Wopt) ;
    Wopt_V_case3 = sqrt(diag(Wopt_return));
    
    mae_A_Base = mean(abs(Wopt_V_case3-V_abs));

end