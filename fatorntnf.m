function [f] = fatorntnf(prazo_diasuteis)

[ajuros,tjuros,atjuros] = xlsread('trabalho_versao4.xls','Juros nominal Brasil');

prazos=ajuros(1,:);
jurosnom=ajuros(2:end,:)/100;

prazoscuponsdu = [81,
206,
329,
452,
574,
701,
824,
949,
1071,
1196,
1319,
1446];

prazoscuponsdu = prazoscuponsdu(prazoscuponsdu<=prazo_diasuteis);

for j=1:size(prazoscuponsdu)
    for i=1:size(jurosnom,1)
        if prazoscuponsdu(j)>prazos(end)
            tx(:,j) = jurosnom(:,end);
        elseif prazoscuponsdu(j)<prazos(1)
            tx(:,j) = jurosnom(:,1);
        else
        tx(i,j)=interp1(prazos,jurosnom(i,:),prazoscuponsdu(j));
        end
    end
end

f = (tx(2:end,:) - tx(1:end-1,:));

end

