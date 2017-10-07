function [w] = pesofuturoDI(quantidade,prazo_diasuteis)
% 
% quantidade = q(6)
% 
% prazo_diasuteis = prazodu_futuro(c+1)

ytmfut = (prazo_diasuteis == 206)*0.1021 + (prazo_diasuteis == 452)*0.0966 + (prazo_diasuteis == 949)*0.0996;

% Taxa de juros DI
% 
% [ajuros,tjuros,atjuros] = xlsread('trabalho_versao4.xls','DI');
% 
% prazos=ajuros(1,:);
% jurosnom=ajuros(2:end,:)/100;
% 
% for i=1:size(jurosnom,1)
%     if prazo_diasuteis>prazos(end)
%         tx = jurosnom(:,end);
%     elseif prazo_diasuteis<prazos(1)
%         tx = jurosnom(:,1);
%     else
%         tx(i)=interp1(prazos,jurosnom(i,:),prazo_diasuteis);
%     end
% end

% w = -quantidade*(prazo_diasuteis/252)*100000*exp(-tx(end)*(prazo_diasuteis/252));

w = -quantidade*(prazo_diasuteis/252)*100000/((1+ytmfut)^(1+prazo_diasuteis/252));

end

