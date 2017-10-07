function [f1,f2] = fatoracaous(preco,cambio)
f1 = (preco(2:end) - preco(1:end-1))./preco(1:end-1);
f2 = (cambio(2:end) - cambio(1:end-1))./cambio(1:end-1);
end

