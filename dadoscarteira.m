%% Carteiras

% qual carteira você quer?
c = 1

% Importo os dados
[A,T,AT] = xlsread('trabalho_versao4.xls','Dados Carteiras','G13:N20');
[A1,T1,AT1] = xlsread('trabalho_versao4.xls','Dados Carteiras','G22:N29');

% Ativos objeto das calls
obj1='AMBEV'
obj2='Bradesco'
obj3='Itau'
obj4='Petrobras'


T(:,c==A)
A1(2:8,c==A1(1,:))


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

%%



