clear all
clc

%% Qual trabalho você quer avaliar?

a = choosedialog;
c = str2num(a);

%% Informações sobre os ativos

prazodu_titulos=[206,
452,
949,
1446,
360,
542,
856,
1039,
81,
145,
206,
452,
512];

prazodu_futuro=[20,
60,
7,
73,
7,
7,
73,
73,
206,
452,
949];

prazodc_futuro=[28,
87,
9,
107,
9,
9,
107,
107,
302,
667,
1400];

preco_titulo=[1016.13,
1024.00,
1020.38,
1012.66,
3014.13,
3082.83,
3053.41,
3100.69,
966.23,
943.62,
924.01,
846.16,
826.88];

ytm = [10.19,
9.63,
9.93,
10.15,
5.34,
5.18,
5.28,
5.38,
11.28,
10.61,
10.15,
9.67,
9.71]/100;

strike = [15,
15.25,
33.14,
34.14,
16.98,
17.95,
38.67,
39.67];

precoopc=[0.60,
0.90,
0.96,
0.39,
0.42,
0.25,
1.81,
1.12];

precofuturo=[3144.79,
3188.50,
74.555,
74.645,
75.820,
87.790,
75.690,
88.185,
92360.44,
84631.44,
69649.07];

precotitulos=[1016.13,
1024.00,
1020.38,
1012.66,
3014.13,
3082.83,
3053.41,
3100.69,
966.23,
943.62,
924.01,
846.16,
826.88];


%% Carteira

% a1='AMBEV';
% a2='Itau';
% a3='Bank of America';
% a4='Futuro 1';
% a5='Título 1';
% a6='Futuro 9';
% a7='Opção 1';  % ATENÇÃO: falta associar ao nome do ativo objeto
% 
% %%% tipo do ativo
% 
% t1='açãobr';
% t2='açãobr';
% t3='açãous';
% t4='futuroUSDBRL';
% t5='ntnf';
% t6='futurodi';
% t7='opção';
% 
% %%% quantidades
% 
% q1=1000000;
% q2=-400000;
% q3=250000;
% q4=150;
% q5=180000;
% q6=2500;
% q7=2000000;
% 
% q = [q1,q2,q3,q4,q5,q6,q7];

% Importo os dados
[A,T,AT] = xlsread('trabalho_versao4.xls','Dados Carteiras','G13:N20');
[A1,T1,AT1] = xlsread('trabalho_versao4.xls','Dados Carteiras','G22:N29');

% Ativos objeto das calls
obj1='Petrobras';
obj2='Bradesco';
obj3='AMBEV';
obj4='Itau';

Ativos = T(:,c==A);
q = A1(2:8,c==A1(1,:));

o=str2num(Ativos{end}(end));
if o==1 | o==2
    objeto = obj1;
elseif o==3 | o==4
    objeto = obj2;
elseif o==5 | o==6
    objeto = obj3;
elseif o==7 | o==8
    objeto = obj4;    
end

table(Ativos,q)

['Aguarde alguns instantes...']

%% Importando os dados relevantes

[aBR,tBR,atBR] = xlsread('trabalho_versao4.xls','Acoes BZ Fut');
[aUS,tUS,atUS] = xlsread('trabalho_versao4.xls','Acoes US');
[acambio,tcambio,atcambio] = xlsread('trabalho_versao4.xls','fx');

% Ativo 1

ind=[];
% Transformo o índice de células em matriz
tBR = tBR(1,:);
% Encontro qual índice está associado ao ativo
for i=1:(length(tBR)-1)
ind(i) = strcmp(Ativos(1),tBR{1,i+1});
end
% Defino o o vetor coluna associado ao ativo
sa1 = aBR(:,(1:(length(tBR)-1))*ind');

% Ativo 2

ind=[];
% Transformo o índice de células em matriz
tBR = tBR(1,:);
% Encontro qual índice está associado ao ativo
for i=1:(length(tBR)-1)
ind(i) = strcmp(Ativos(2),tBR{1,i+1});
end
% Defino o o vetor coluna associado ao ativo
sa2 = aBR(:,(1:(length(tBR)-1))*ind');

% Ativo 3

ind=[];
% Transformo o índice de células em matriz
tUS = tUS(1,:);
% Encontro qual índice está associado ao ativo
for i=1:(length(tUS)-1)
ind(i) = strcmp(Ativos(3),tUS{1,i+1});
end
% Defino o o vetor coluna associado ao ativo
sa3 = aUS(:,(1:(length(tUS)-1))*ind');

% Ativo 4

if c==3|c==4
qualmoeda = 'Canadian Dollar';
elseif c==5|c==7
qualmoeda = 'Australian Dollar';
elseif c==6|c==8
qualmoeda = 'Japanese Yen';
end

if c>2
% Aqui importo as taxas de câmbio
ind=[];
tcambio = tcambio(1,:);
for i=1:(length(tcambio)-1)
ind(i) = strcmp(qualmoeda,tcambio{1,i+1});
end
cambio = acambio(:,(1:(length(tcambio)-1))*ind');
end

% Dólar (preço de 1 dólar em reais)
ind=[];
tcambio = tcambio(1,:);
for i=1:(length(tcambio)-1)
ind(i) = strcmp('Brazilian Real',tcambio{1,i+1});
end
pdolar = acambio(:,(1:(length(tcambio)-1))*ind');

% Ativo 10

ind=[];
% Transformo o índice de células em matriz
tBR = tBR(1,:);
% Encontro qual índice está associado ao ativo
for i=1:(length(tBR)-1)
ind(i) = strcmp(objeto,tBR{1,i+1});
end
% Defino o o vetor coluna associado ao ativo
sa10 = aBR(:,(1:(length(tBR)-1))*ind');

%% Valor da carteira
pos=[];
pos(1)=q(1)*sa1(end);
pos(2)=q(2)*sa2(end);
pos(3)=q(3)*sa3(end)*pdolar(end);
pos(4)=q(4)*precofuturo(c);
pos(5)=q(5)*precotitulos(c);
if c<4
pos(6)=q(6)*precofuturo(8+c);
else
pos(6)=q(6)*preco_titulo(5+c); 
end
pos(7)=q(7)*precoopc(c);

valorcarteira=sum(pos);

%% Fatores de risco

% Ativo 1
f1 = fatoracaobr(sa1);
% Ativo 2
f2 = fatoracaobr(sa2);
% Ativo 3
[f3,f4]=fatoracaous(sa3,pdolar);
% Ativo 4
if c==1 | c==2
[f5,f6,f7]=fatorfuturomoedaUSDBRL(prazodu_futuro(c),prazodc_futuro(c),pdolar);
elseif c==3|c==4
[f5,f6,f7] = fatorfuturomoedafora(prazodc_futuro(c),cambio,'CAD');
elseif c==5|c==7
[f5,f6,f7] = fatorfuturomoedafora(prazodc_futuro(c),cambio,'AUD');
elseif c==6|c==8
[f5,f6,f7] = fatorfuturomoedafora(prazodc_futuro(c),cambio,'JPY');
end
% Ativo 5
if c<5
f8=fatorntnf(prazodu_titulos(c));
elseif c>4
f8=fatorntnb(prazodu_titulos(c),8*(c == 5 | c == 7)+5*(c == 6 | c == 8)); 
end
% Ativo 6
if c<4
f9=fatorfuturoDI(prazodu_futuro(c+8));
else
f9=fatorltn(prazodu_titulos(c+5));   
end
% Ativo 7
[f10,f11]=fatoropc(sa10);

F=[f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,[0;f11]];


%% Pesos de cada fator

% Ativo 1
w1 = pesoacaobr(sa1,q(1));
% Ativo 2
w2 = pesoacaobr(sa2,q(2));
% Ativo 3
w3 = pesoacaous(sa3,q(3),pdolar(end));
w4 = w3;
% Ativo 4
if c==1|c==2
[w5,w6,w7]=pesofuturomoedaUSDBRL(q(4),prazodu_futuro(c),prazodc_futuro(c),pdolar(end));
elseif c==3|c==4
[w5,w6,w7] = pesofuturomoedafora(q(4),prazodu_futuro(c),cambio,'CAD');
elseif c==5|c==7
[w5,w6,w7] = pesofuturomoedafora(q(4),prazodu_futuro(c),cambio,'AUD');
elseif c==6|c==8
[w5,w6,w7] = pesofuturomoedafora(q(4),prazodu_futuro(c),cambio,'JPY');
end
% Ativo 5
if c<5
w8 = pesontnf(q(5),prazodu_titulos(c),ytm(c),preco_titulo(c));
else
w8 = pesontnb(q(5),prazodu_titulos(c),8*(c == 5 | c == 7)+5*(c == 6 | c == 8),ytm(c),preco_titulo(c));
end
% Ativo 6
if c<4
w9 = pesofuturoDI(q(6),prazodu_futuro(c+8));
else
w9=pesoltn(q(6),prazodu_titulos(c+5));   
end
% Ativo 7
[w10,w11] = pesoopc(sa10,q(7),strike(c));

W=[w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11];


%% Calculando o VaR paramétrico da carteira

% Defino o nível de significância
alpha = 0.05;

Omega=EWMA(F,0.94);
Omega_end=Omega(:,:,end);

VaR = (W*Omega_end*W'*norminv(alpha)^2)^0.5;

VaR/valorcarteira;

%% Calculando o VaR de cada posição

VaRpos=[];
% Ativo 1
VaRpos(1) = (W(1)*Omega_end(1,1)*W(1)'*norminv(alpha)^2)^0.5;
% Ativo 2
VaRpos(2) = (W(2)*Omega_end(2,2)*W(2)'*norminv(alpha)^2)^0.5;
% Ativo 3
VaRpos(3) = (W(3:4)*Omega_end(3:4,3:4)*W(3:4)'*norminv(alpha)^2)^0.5;
% Ativo 4
VaRpos(4) = (W(5:7)*Omega_end(5:7,5:7)*W(5:7)'*norminv(alpha)^2)^0.5;
% Ativo 5
VaRpos(5) = (W(8:(7+length(w8)))*Omega_end(8:(7+length(w8)),8:(7+length(w8)))*W(8:(7+length(w8)))'*norminv(alpha)^2)^0.5;
% Ativo 6
VaRpos(6) = (W((7+length(w8)+1))*Omega_end((7+length(w8)+1),(7+length(w8)+1))*W((7+length(w8)+1))'*norminv(alpha)^2)^0.5;
% Ativo 7
VaRpos(7) = (W(end-1:end)*Omega_end(end-1:end,end-1:end)*W(end-1:end)'*norminv(alpha)^2)^0.5;

VaRpos./pos;

% Verificar o que há de errado com a opção.

format long;
VaRpos;

%% VaR marginal

theta = W./valorcarteira;
R_carteira = F*theta';
C_aux = EWMA([F R_carteira],0.94);
C = C_aux(end,1:end-1,end);
vol_carteira = (theta*Omega_end*theta')^0.5;
VaR_marg = (norminv(alpha))*C/vol_carteira;

%% Component VaR

VaR_comp_fator = VaR_marg.*W;

VaR_comp_inst = [
    sum(VaR_comp_fator(1)),
    sum(VaR_comp_fator(2)),
    sum(VaR_comp_fator(3:4)),
    sum(VaR_comp_fator(5:7)),
    sum(VaR_comp_fator(8)),
    sum(VaR_comp_fator(9)),
    sum(VaR_comp_fator(10:11))]';

%% VaR Incremental

VaR_Inc = VaR_comp_inst'./q;

%% VaR Histórico

% defino o número de cenários
ncen = 500;

PNL1 = q(1)*sa1(end)*f1(end-ncen:end-1);
PNL2 = q(2)*sa2(end)*f2(end-ncen:end-1);
PNL3 = q(3)*sa3(end)*pdolar(end)*(f3(end-ncen:end-1)+f4(end-ncen:end-1));
PNL4 = w5*f5(end-ncen:end-1) + w6*f6(end-ncen:end-1) + w7*f7(end-ncen:end-1);
PNL5 = sum(repmat(w8,ncen,1).*f8(end-ncen:end-1,:),2);
PNL6 = w9*f9(end-ncen:end-1,:);

volimp = blsimpv(sa10(end),strike(c), 0.12037205954098, 10/252, precoopc(c));
Espvimp = volimp + f11(end-ncen:end-1,:);
f10_mod=f10(end-ncen:end-1,:);
for i=1:length(Espvimp)
Espcall(i,1) = blsprice(sa10(end)*(1+f10_mod(i)),strike(c), 0.12037205954098,10/252,Espvimp(i),0);
end
PNL7 = q(7)*(Espcall - precoopc(c));

PNL = [PNL1, PNL2, PNL3, PNL4, PNL5, PNL6, PNL7];

VaRhist_pos = prctile(PNL,alpha*100);
VaRhist = prctile(sum(PNL,2),alpha*100);

%% Resultados de VaR paramétrico, histórico e incremental

table([VaRpos,-VaR]', [VaR_Inc;sum(VaR_Inc)],[VaRhist_pos,VaRhist]','VariableNames',{'VaRpar' 'Varinc' 'VaRhist'},'RowNames',{'pos1' 'pos2' 'pos3' 'pos4' 'pos5' 'pos6' 'pos7' 'total'})


%% TVE
% defino o corte como sendo em 10%

% defino o número de cenários
ncen = 1200;

PNL1 = q(1)*sa1(end)*f1(end-ncen:end-1);
PNL2 = q(2)*sa2(end)*f2(end-ncen:end-1);
PNL3 = q(3)*sa3(end)*pdolar(end)*(f3(end-ncen:end-1)+f4(end-ncen:end-1));
PNL4 = w5*f5(end-ncen:end-1) + w6*f6(end-ncen:end-1) + w7*f7(end-ncen:end-1);
PNL5 = sum(repmat(w8,ncen,1).*f8(end-ncen:end-1,:),2);
PNL6 = w9*f9(end-ncen:end-1,:);

volimp = blsimpv(sa10(end),strike(c), 0.12037205954098, 10/252, precoopc(c));
Espvimp = volimp + f11(end-ncen:end-1,:);
f10_mod=f10(end-ncen:end-1,:);
for i=1:length(Espvimp)
Espcall(i,1) = blsprice(sa10(end)*(1+f10_mod(i)),strike(c), 0.12037205954098,10/252,Espvimp(i),0);
end
PNL7 = q(7)*(Espcall - precoopc(c));

PNL = [PNL1, PNL2, PNL3, PNL4, PNL5, PNL6, PNL7];
cenarios = sum(PNL/valorcarteira,2);

% Defino o corte
D = prctile(cenarios,alpha*2*100);

% Defino a cauda
cauda = cenarios(cenarios<=D);
cauda = -sort(cauda);

% Aqui fazemos o fit com a distribuição de Pareto
par=fitdist(cauda,'GeneralizedPareto');

% Calculo o VaR por TVE
VaR_TVE = (D-icdf(par,0.5));

% Calculo o Expected Shortfall se superar o VaR.
ES = VaR_TVE - (par.sigma + par.k*(VaR_TVE - D))/(1+par.k);

['VaR de TVE é ', num2str(VaR_TVE*valorcarteira),' com ES de ', num2str(ES*valorcarteira)]


%% Simulação 250 simulações históricas para testar os cenários.

%janela de backtesting ultimos NB dias, assumindo que a carteira não mudou
%nesse periodo
% NB=250;
% 
% %retornos históricos da carteira
% Valor_Carteira=P*q';
% PnL_Carteira=Valor_Carteira(2:end)-Valor_Carteira(1:end-1);
% PnL_Carteira=PnL_Carteira(end-NB+1:end);
% 
% %VaR historico da carteira  dentro da janela NB usando N cenários
% N=500;
% F_historico=zeros(N,size(F,2),NB);
% for i=1:NB
%     F_historico(:,:,i)=F(end-N-i+1:end-i,:);
% end
% 
% Valor_Ativos_Carteira=P.*repmat(q,size(P,1),1);
% 
% PnL_historico=zeros(N,NB);
% for i=1:NB
%     PnL_historico(:,i)=F_historico(:,:,i)*Valor_Ativos_Carteira(end-i,:)';
% end
% 
