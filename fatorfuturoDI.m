function [f] = fatorfuturoDI(prazo_diasuteis)

% Taxa de juros DI

[ajuros,tjuros,atjuros] = xlsread('trabalho_versao4.xls','DI');

prazos=ajuros(1,:);
jurosnom=ajuros(2:end,:)/100;

for i=1:size(jurosnom,1)
    if prazo_diasuteis>prazos(end)
        tx = jurosnom(:,end);
    elseif prazo_diasuteis<prazos(1)
        tx = jurosnom(:,1);
    else
        tx(i)=interp1(prazos,jurosnom(i,:),prazo_diasuteis);
    end
end

f = (tx(2:end) - tx(1:end-1));
f = f';

end

