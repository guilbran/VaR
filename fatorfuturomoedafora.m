function [f1,f2,f3] = futuromoedafora(prazo_dc,cambio,moeda_alem_dolar)

% cambio
f1 = (cambio(2:end) - cambio(1:end-1))./cambio(1:end-1);

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
            tx(i,:)=interp1(prazos,jurosnom(i,:),prazo_dc);
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
            tx(i,:)=interp1(prazos,jurosnom(i,:),prazo_dc);
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
            tx(i,:)=interp1(prazos,jurosnom(i,:),prazo_dc);
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
        txus(i,:)=interp1(prazos,jurosnom(i,:),prazo_dc);
    end
end

f2 = (tx(2:end) - tx(1:end-1));
f3 = (txus(2:end) - txus(1:end-1));

end

