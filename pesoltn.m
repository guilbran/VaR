function [w] = pesoltn(quantidade,prazo_diasuteis)

[ajuros,tjuros,atjuros] = xlsread('trabalho_versao4.xls','Juros nominal Brasil');

prazos=ajuros(1,:);
jurosnom=ajuros(2:end,:)/100;

for i=1:size(jurosnom,1)
tx(i)=interp1(prazos,jurosnom(i,:),prazo_diasuteis);
end

tx=tx';

preco = 1000/((1+tx(end))^(prazo_diasuteis/252));

w = quantidade*preco*(prazo_diasuteis/252)/(1+tx(end));

end

