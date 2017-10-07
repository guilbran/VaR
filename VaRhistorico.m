clear all
clc

% Este é o código desenvolvido nas monitorias dos dias 8 e 9 de março de
% 2017.

% Seja uma carteira fictícia formada pelos seguintes ativos, em 06/03/2017.

% Bradesco (BBDC4 BS Equity)
q1 = -50;
% call Bradesco (Vendimento 20/03/2017)
q2 = 70;
strike = 33.14;
p2 = 0.96;
% Google (GOOGL US Equity)
q3 = 10;
% LTN jul/2017
q4 = 30;                 
p4 = 966.226809;         % preço
ytm = 11.2809;           % Taxa interna de retorno
T = 81;                  % prazo em dias úteis (calculados no excel)

% Nesse ponto, note que não temos informação para o prazo de 81 dias a
% partir da data de formação da carteira. Portanto deveremos decompor esse
% fator de risco em dois. O prazo imediatamente acima e abaixo que
% possuimos informação. No caso 63 e 126 dias. O peso para cada um deles é
% dado pela fórmula: 81 = b1*63 + b2*126, onde b2 = 1-b1.

% O que dá aproximadamente os valores abaixo. 

b1 = 0.71428;            
b2 = 1 - b1;


%% Importar a base de dados

% Para importar a base de dados vocês pode usar o menu em HOME>Import Data.
% Abaixo segue uma forma alternativa utilizando somente funções do matlab,
% sem precisar apertar botões


% Importo todas as bases
[aBR,tBR,atBR] = xlsread('trabalho_versao4.xls','Acoes BZ Fut');
[aUS,tUS,atUS] = xlsread('trabalho_versao4.xls','Acoes US');
[acambio,tcambio,atcambio] = xlsread('trabalho_versao4.xls','fx');
[ajuros,tjuros,atjuros] = xlsread('trabalho_versao4.xls','Juros nominal Brasil');


% Transformo o índice de células em matriz
tBR = tBR(1,:);
% Encontro qual índice está associado ao ativo
for i=1:(length(tBR)-1)
ind(i) = strcmp('Bradesco',tBR{1,i+1});
end
% Defino o o vetor coluna associado ao ativo
pBRA = aBR(:,(1:(length(tBR)-1))*ind');

% Repito para os demais dados (pode-se automatizar esse processo)

% Google
clear('ind')
tUS = tUS(1,:);
for i=1:(length(tUS)-1)
ind(i) = strcmp('Google',tUS{1,i+1});
end
pGLG = aUS(:,(1:(length(tUS)-1))*ind');

% Dólar (preço de 1 dólar em reais)
clear('ind')
tcambio = tcambio(1,:);
for i=1:(length(tcambio)-1)
ind(i) = strcmp('Brazilian Real',tcambio{1,i+1});
end
pdolar = acambio(:,(1:(length(tcambio)-1))*ind');

% Juros zero-cupom (prazo de 63 dias)
clear('ind')
tjuros = ajuros(1,:);
aajuros = ajuros(2:end,:)/100;
ind = tjuros == 63;
y63 = aajuros(:,(1:(length(tjuros)))*ind');

% Juros zero-cupom (prazo de 126 dias)
clear('ind')
tjuros = ajuros(1,:);
aajuros = ajuros(2:end,:)/100;
ind = tjuros == 126;
y126 = aajuros(:,(1:(length(tjuros)))*ind');

% Juros zero-cupom (prazo de 21 dias)
clear('ind')
tjuros = ajuros(1,:);
aajuros = ajuros(2:end,:)/100;
ind = tjuros == 21;
y21 = aajuros(:,(1:(length(tjuros)))*ind');

%% 1 - Identificando os fatores de risco
% Esta etapa é feita de maneira analítica. Aqui usamos o método
% Delta-Normal (expansão de primeira ordem na variação dos preços dos
% ativos da carteira). Os slides2 e Handout entram em detalhes sobre essa
% etapa.

%% 2 - Montar matriz com os fatores de risco

retBRA = (pBRA(2:end) - pBRA(1:end-1))./pBRA(1:end-1);
volBRA = (EWMA(retBRA,0.94)).^(0.5);     % EWMA nos dá a variância, por isso tiramos a raíz quadrada.

vBRA = permute(volBRA,[3 1 2]);         % Aqui rotacionamos as dimensões.
                                        % permute é transpor a matriz
                                        % quando esta possui mais do que 2
                                        % dimensões.

                                        
f1 = retBRA;
f2 = vBRA(2:end) - vBRA(1:end-1);
f3 = (pGLG(2:end) - pGLG(1:end-1))./pGLG(1:end-1);
f4 = (pdolar(2:end) - pdolar(1:end-1))./pdolar(1:end-1);
f5 = (y63(2:end) - y63(1:end-1));
f6 = (y126(2:end) - y126(1:end-1));

F = [f1(2:end),f2,f3(2:end),f4(2:end),f5(2:end),f6(2:end)];

%% 3 - Reprecificação dos ativos em todos os cenários


% Preço do primeiro ativo, Bradesco, no segundo período, todos cenários:
EspBRA = pBRA(end)*(1+retBRA);
EspBRA1 = EspBRA(2:end);

% Preço de call de Bradesco, no segundo período, todos cenários:
volimp = 0.2657;
EspvimpBRA = volimp + f2;
for i=1:length(EspvimpBRA)
EspcallBRA(i,1) = blsprice(EspBRA(i+1),strike,y21(end),10/252,EspvimpBRA(i),0);
end

% Preço de Google, no segundo período, todos cenários:
EspGLGemdolar = pGLG(end)*(1+f3);
Espdolar = pdolar(end)*(1+f4);
EspGLG = EspGLGemdolar.*Espdolar;

% Preço de LTNjul2017, no segundo período, todos cenários:
mi = (126-80)/(126-63);
y80 = mi*y63 + (1-mi)*y126;
dify80 = y80(2:end) - y80(1:end-1);
Espy80 = y80(end) + dify80;
pespLTN = 1000./((1+Espy80).^(80/252));


% PNL carteira

PNL1 = (EspBRA1-pBRA(end))*q1;

PNL2 = (EspcallBRA - 0.96)*q2;

PNL30 = (EspGLG - pGLG(end)*pdolar(end))*q3;

PNL3 = PNL30(2:end);

PNL40 = (pespLTN - p4*(1+ytm/100)^(1/(252)))*q4;

PNL4 = PNL40(2:end);

PNL = PNL1 + PNL2 + PNL3 + PNL4 ;

%% 4 - Cálculo do VaR

% Definimos o nível de significância.
alpha = 0.05;


VaR = prctile(PNL,alpha*100);
VaR1 = prctile(PNL1,alpha*100);
VaR2 = prctile(PNL2,alpha*100);
VaR3 = prctile(PNL3,alpha*100);
VaR4 = prctile(PNL4,alpha*100);

X0 = q1*pBRA(end) + q2*p2 + q3*pGLG(end)*pdolar(end) + q4*p4;


display(['Nível de confiância: ',num2str(1-alpha),'%']);
display(['Valor da carteira hoje: ',num2str(X0),' reais']);
display(['VaR histórico: ',num2str(-VaR),' reais']);
display(['VaR carteira/X0: ',num2str(-VaR/X0)]);
display(['VaR da posição 1: ',num2str(-VaR1),' reais']);
display(['VaR da posição 2: ',num2str(-VaR2),' reais']);
display(['VaR da posição 3: ',num2str(-VaR3),' reais']);
display(['VaR da posição 4: ',num2str(-VaR4),' reais']);
display(['Soma do VaR de cada posição: ',num2str(-sum([VaR1,VaR2,VaR3,VaR4])),' reais']);







