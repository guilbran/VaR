function [f] = fatorltn(prazo_diasuteis)

[ajuros,tjuros,atjuros] = xlsread('trabalho_versao4.xls','Juros nominal Brasil');

prazos=ajuros(1,:);
jurosnom=ajuros(2:end,:)/100;

for i=1:size(jurosnom,1)
tx(i,:)=interp1(prazos,jurosnom(i,:),prazo_diasuteis);
end

f = (tx(2:end) - tx(1:end-1));


end



