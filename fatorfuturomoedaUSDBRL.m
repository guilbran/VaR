function [f1,f2,f3] = futuromoedaUSDBRL(prazo_diasuteis,prazo_dc,cambio)

% cambio
f1 = (cambio(2:end) - cambio(1:end-1))./cambio(1:end-1);
% 
% prazo_diasuteis = 60
% prazo_dc = 87

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
        txbr(i,:)=interp1(prazos,jurosnom(i,:),prazo_diasuteis);
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
        txus(i,:)=interp1(prazos,jurosnom(i,:),prazo_dc);
    end
end

f2 = (txbr(2:end) - txbr(1:end-1));
f3 = (txus(2:end) - txus(1:end-1));

end

