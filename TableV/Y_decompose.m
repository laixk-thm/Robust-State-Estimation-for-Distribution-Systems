function [Y_k,U,A,U_Z,U_Z_BK] = Y_decompose(Y,k,B)
    test1 = Y;
    test1 = flip(flip(test1),2);
    [U,A,V] = svd(test1);

    U = flip(flip(U),2);
    V = flip(flip(V),2);
    A = rot90(rot90(A));


    Z = U' * conj(V); 
    sq_Z = sqrtm(Z);
    U_Z = U * sq_Z;
    test5 = U_Z * A * U_Z.';
    % test2 = U_Z.' * V;
    test2 = U_Z * U_Z';

    %截取前k个
    A_K = A(1:k,1:k);
    U_Z_K = U_Z(:,1:k);
    U_Z_BK = U_Z(:,k+1:B);
    Y_k = U_Z_K * A_K * U_Z_K';
    % test3 = U_Z_K * U_Z_K';
    test3 = U_Z_K * U_Z_K' + U_Z_BK * U_Z_BK';

    %构建Uk
    [U_SVD,A_SVD,V_SVD] = svd(U_Z_K);
    %[U_SVD_BK,U_Bk,V_BK_SVD] = svd(U_Z_BK);
    test4 = V_SVD' * V_SVD;

    %U = U_SVD(:,1:k);
    U_SVD_K = U_SVD(:,1:k);
    A_SVD_K = A_SVD(1:k,1:k);
    V_SVD_K = V_SVD(:,1:k);
    U = U_SVD_K * A_SVD_K * V_SVD_K';
    U_BK = U_SVD(:,k+1:B);
    % test3 = U_Z_K.' * V;
    % test4 = U * U'+ U_BK * U_BK' + U_Z_BK * U_Z_BK.';
    U_extend = [U,zeros(B,B-k)];
    
    U_GFT_K = U_Z_K;

end