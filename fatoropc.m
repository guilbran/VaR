function [f1,f2] = fatoropc(preco_ativo_obj)
f1 = (preco_ativo_obj(2:end) - preco_ativo_obj(1:end-1))./preco_ativo_obj(1:end-1);
vol = (EWMA(f1,0.94)).^(0.5);     % EWMA nos dá a variância, por isso tiramos a raíz quadrada.
vol1 = permute(vol,[3 1 2]);
f2=(vol1(2:end)-vol1(1:end-1))./vol1(1:end-1);
end

