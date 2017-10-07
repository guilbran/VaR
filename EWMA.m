function[cov_ewma]= EWMA(Ret, lambda)

%calcula a matriz de covariancia de FECHAMENTO para cada instante de
%tempo(size(Ret,1))

%inicio com as primeiras n observações
n=60;
cov_ini=cov(Ret(1:n,:));

cov_ewma=ones(size(Ret,2),size(Ret,2),size(Ret,1));

for i=1:n
    cov_ewma(:,:,i)=cov_ini;
end

for i= n+1:size(Ret,1)
    cov_ewma(:,:,i)=lambda.*cov_ewma(:,:,i-1)+(1-lambda).*Ret(i,:)'*Ret(i,:);
    
end
