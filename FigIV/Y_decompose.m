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

    %截取前k个
    A_K = A(1:k,1:k);
    U = U_Z(:,1:k);
    U_Z_BK = U_Z(:,k+1:B);
    Y_k = U * A_K *U.'*U * U';


end