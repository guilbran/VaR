function [w1,w2,w3] = pesofuturomoedafora(quantidade,prazo_dc,cambio,moeda_alem_dolar)

% Taxa de juros outra

[ajuros,tjuros,atjuros] = xlsread('trabalho_versao4.xls','Forex');
prazos=[30,90,180];

if moeda_alem_dolar=='CAD'

    jurosnom=ajuros(:,7:9)/100;

    for i=1:size(jurosnom,1)
        if prazo_dc>prazos(end)
            tx = jurosnom(:,end);
        elseif prazo_dc<prazos(1)
            tx = jurosnom(:,1);
        else
            tx(i)=interp1(prazos,jurosnom(i,:),prazo_dc);
        end
    end

elseif moeda_alem_dolar=='JPY'

    jurosnom=ajuros(:,4:6)/100;

    for i=1:size(jurosnom,1)
        if prazo_dc>prazos(end)
            tx = jurosnom(:,end);
        elseif prazo_dc<prazos(1)
            tx = jurosnom(:,1);
        else
            tx(i)=interp1(prazos,jurosnom(i,:),prazo_dc);
        end
    end
 
elseif moeda_alem_dolar=='AUD'

    jurosnom=ajuros(:,1:3)/100;

    for i=1:size(jurosnom,1)
        if prazo_dc>prazos(end)
            tx = jurosnom(:,end);
        elseif prazo_dc<prazos(1)
            tx = jurosnom(:,1);
        else
            tx(i)=interp1(prazos,jurosnom(i,:),prazo_dc);
        end
    end

else
    disp('Moeda não condiz com dados da base.');  
end
    

% Taxa de juros americana

[ajuros,tjuros,atjuros] = xlsread('trabalho_versao4.xls','Forex');

prazos=[30,90,180];
jurosnom=ajuros(:,10:12)/100;

for i=1:size(jurosnom,1)
    if prazo_dc>prazos(end)
        txus = jurosnom(:,end);
    elseif prazo_dc<prazos(1)
        txus = jurosnom(:,1);
    else
        txus(i)=interp1(prazos,jurosnom(i,:),prazo_dc);
    end
end

if moeda_alem_dolar == 'CAD'
    w1 = quantidade*100*(cambio(end)*exp((tx(end)-txus(end))*(prazo_dc/360)))^-1;
    w2 = quantidade*100*(cambio(end)*(prazo_dc/360)*exp((tx(end)-txus(end))*(prazo_dc/360)))^-1;
    w3 = -quantidade*100*(cambio(end)*(prazo_dc/360)*exp((tx(end)-exp(txus(end)))*(prazo_dc/360)))^-1;
%     w1 = quantidade*100*(cambio(end)*exp((tx(end)-txus(end))*(prazo_dc/360)));
%     w2 = quantidade*100*(cambio(end)*(prazo_dc/360)*exp((tx(end)-txus(end))*(prazo_dc/360)));
%     w3 = -quantidade*100*(cambio(end)*(prazo_dc/360)*exp((tx(end)-txus(end))*(prazo_dc/360)));
elseif moeda_alem_dolar == 'JPY'
    w1 = quantidade*10000*(cambio(end)*exp((tx(end)-txus(end))*(prazo_dc/360)))^-1;
    w2 = quantidade*10000*(cambio(end)*(prazo_dc/360)*exp((tx(end)-txus(end))*(prazo_dc/360)))^-1;
    w3 = -quantidade*10000*(cambio(end)*(prazo_dc/360)*exp((tx(end)-txus(end))*(prazo_dc/360)))^-1;
elseif moeda_alem_dolar == 'AUD'
    w1 = quantidade*100*(cambio(end)*exp((tx(end)-txus(end))*(prazo_dc/360)));
    w2 = quantidade*100*(cambio(end)*(prazo_dc/360)*exp((tx(end)-txus(end))*(prazo_dc/360)));
    w3 = -quantidade*100*(cambio(end)*(prazo_dc/360)*exp((tx(end)-txus(end))*(prazo_dc/360)));
else
    disp('Moeda não condiz com dados da base.');  
end


end

