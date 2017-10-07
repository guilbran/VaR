function [ w ] = pesontnb(quantidade,prazo_diasuteis,mesvencimento,ytm,preco_titulo)

VNA = 2977.003333;

[ajuros,tjuros,atjuros] = xlsread('trabalho_versao4.xls','Juros Real Brasil');

prazos=ajuros(1,:);
jurosreal=ajuros(2:end,:)/100;

prazomaio=[47,
175,
296,
423,
542,
672,
792,
918,
1039];

prazoagosto=[112,
235,
360,
483,
606,
733,
856,
978,
1102];

if mesvencimento==5
    prazoscuponsdu = prazomaio(prazomaio<=prazo_diasuteis);
elseif mesvencimento==8
    prazoscuponsdu = prazoagosto(prazoagosto<=prazo_diasuteis);
else
    disp('O mês especificado na função não é compatível com prazo de NTNB');
end


for j=1:size(prazoscuponsdu)
    for i=1:size(jurosreal,1)
        if prazoscuponsdu(j)>prazos(end)
            tx(:,j) = jurosreal(:,end);
        elseif prazoscuponsdu(j)<prazos(1)
            tx(:,j) = jurosreal(:,1);
        else
        tx(i,j)=interp1(prazos,jurosreal(i,:),prazoscuponsdu(j));
        end
    end
end

prazoscuponsdu;
cupom=(1.06^0.5-1);
cupons=repmat(cupom,length(prazoscuponsdu),1);
cupons(end)=cupons(end)+1;

w=quantidade*VNA*cupons'.*(prazoscuponsdu'/252)./(preco_titulo*(1+ytm).^(prazoscuponsdu'/252));

end

