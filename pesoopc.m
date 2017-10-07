function [w1,w2] = pesoopc(preco_ativo_obj,quantidade,strike)
f1 = (preco_ativo_obj(2:end) - preco_ativo_obj(1:end-1))./preco_ativo_obj(1:end-1);
vol = (EWMA(f1,0.94)).^(0.5);
vol_rent_ativo_objeto = permute(vol,[3 1 2]);

deltacall = blsdelta(preco_ativo_obj(end),strike,0.12037205954098,10/252,vol_rent_ativo_objeto(end)*(252)^(0.5));
vegacall = blsvega(preco_ativo_obj(end),strike,0.12037205954098,10/252,vol_rent_ativo_objeto(end)*(252)^(0.5));

w1=quantidade*deltacall*preco_ativo_obj(end);
w2=quantidade*vegacall;


end