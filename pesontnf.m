function [w] = pesontnf(quantidade,prazo_diasuteis,ytm,preco_titulo)

% quantidade = q(5)
% prazo_diasuteis = prazodu_titulos(c)
% ytm = ytm(c)
% preco_titulo = preco_titulo(c)

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

prazoscuponsdu;
cupom=(1.1^0.5-1)*1000;
cupons=repmat(cupom,length(prazoscuponsdu),1);
cupons(end)=cupons(end)+1000;

w=-quantidade*cupons'.*(prazoscuponsdu'/252)./((1+ytm)*(1+ytm).^(prazoscuponsdu'/252));


end

