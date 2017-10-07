function [f] = fatoracaobr(preco)
f = (preco(2:end) - preco(1:end-1))./preco(1:end-1);
end
