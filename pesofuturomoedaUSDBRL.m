function [w1,w2,w3] = pesofuturomoedaUSDBRL(quantidade,prazo_diasuteis,prazo_dc,cambio)

% Taxa de juros brasileira

[ajuros,tjuros,atjuros] = xlsread('trabalho_versao4.xls','DI');

prazos=ajuros(1,:);
jurosnom=ajuros(2:end,:)/100;

for i=1:size(jurosnom,1)
    if prazo_diasuteis>prazos(end)
        txbr = jurosnom(:,end);
    elseif prazo_diasuteis<prazos(1)
        txbr = jurosnom(:,1);
    else
        txbr(i)=interp1(prazos,jurosnom(i,:),prazo_diasuteis);
    end
end

% Taxa de juros americana no Brasil (Cupom Cambial)

[ajuros,tjuros,atjuros] = xlsread('trabalho_versao4.xls','Cupom Cambial');

prazos=ajuros(1,:);
jurosnom=ajuros(2:end,:)/100;

for i=1:size(jurosnom,1)
    if prazo_dc>prazos(end)
        txus = jurosnom(:,end);
    elseif prazo_dc<prazos(1)
        txus = jurosnom(:,1);
    else
        txus(i)=interp1(prazos,jurosnom(i,:),prazo_dc);
    end
end

w1 = quantidade*50000*cambio(end)*exp(txbr(end)*(prazo_diasuteis/252))/exp(txus(end)*(prazo_dc/360));
w2 = quantidade*50000*cambio(end)*(prazo_diasuteis/252)*exp(txbr(end)*(prazo_diasuteis/252))/exp(txus(end)*(prazo_dc/360));
w3 = -quantidade*50000*cambio(end)*(prazo_dc/360)*exp(txbr(end)*(prazo_diasuteis/252))/exp(txus(end)*(prazo_dc/360));

end

