:- initialization(main).

caixaUsuario(1200).

getNome(NumTime,Saida):-
time(NumTime,Saida,_,_,_,_,_).

getNome('','EMPATE').

getAtaque(NumTime,Saida):-
time(NumTime,_,Saida,_,_,_,_).

getDefesa(NumTime,Saida):-
time(NumTime,_,_,Saida,_,_,_).

getControle(NumTime,Saida):-
time(NumTime,_,_,_,Saida,_,_).


getConfianca(NumTime,Saida):-
time(NumTime,_,_,_,_,Saida,_).

getCondicao(NumTime,Saida):-
time(NumTime,_,_,_,_,_,Saida).

getTdsAtributos(NumTime,Atk,Def,Contrl,Confi,Condic):-
time(NumTime,_,Atk,Def,Contrl,Confi,Condic).

getSumAtributos(NumTime,Saida):-
time(NumTime,_,Atk,Def,Control,Confi,Condic),
Saida is (Atk + Def + Control +  Confi + Condic).


setAtaque(NumTime,AtkNovo):-
retract(time(NumTime,Nome,_,Def,Control,Confian,Condicao)),
assert(time(NumTime,Nome,AtkNovo,Def,Control,Confian,Condicao)).

setDefesa(NumTime,DefNova):-
retract(time(NumTime,Nome,Atk,_,Control,Confian,Condicao)),
assert(time(NumTime,Nome,Atk,DefNova,Control,Confian,Condicao)).

setControle(NumTime,ControlNovo):-
retract(time(NumTime,Nome,Atk,Def,_,Confian,Condicao)),
assert(time(NumTime,Nome,Atk,Def,ControlNovo,Confian,Condicao)).

setConfianca(NumTime,ConfiNova):-
retract(time(NumTime,Nome,Atk,Def,Control,_,Condicao)),
assert(time(NumTime,Nome,Atk,Def,Control,ConfiNova,Condicao)).

setCodicao(NumTime,CondiNova):-
retract(time(NumTime,Nome,Atk,Def,Control,Confi,_)),
assert(time(NumTime,Nome,Atk,Def,Control,Confi,CondiNova)).


setCaixa(Valor):-
retract(caixaUsuario(_)),
assert(caixaUsuario(Valor)).

getCaixa(Saida):-
caixaUsuario(Saida).


% TIME( ID , NOME, ATQUE, DEFESA, CONTROLE, CONFIANCA, CONDICAO )
time(1, 'Campinense', 77, 72, 77, 76, 100).
time(2, 'Treze', 73, 70, 74, 72, 100).
time(3, 'Botafogo-PB', 80, 76, 81, 78, 100).
time(4, 'Atletico-PB', 58, 61, 62, 59, 100).
time(5, 'Souza', 63, 65, 65, 68, 100).
time(6, 'Nacional de Patos', 59, 60, 45, 61, 100).
time(7, 'Serrano', 48, 0, 56, 52, 100).
time(8, 'Perilima', 46, 50, 59, 46,100).
time(9, 'Esporte de Patos', 57,62, 61, 57, 100).
time(10, "CSP", 64, 66, 69, 65, 100).

indices(X) :- randseq(10,10,X).

% TIMEDEGRUPO( TIME_ID , PONTOS , PARTIDAS , VITORIAS , EMPATES , DERROTAS , GOLS )
timeDeGrupo(1  ,0,0,0,0,0,0).  
timeDeGrupo(2  ,0,0,0,0,0,0).  
timeDeGrupo(3  ,0,0,0,0,0,0).  
timeDeGrupo(4  ,0,0,0,0,0,0).  
timeDeGrupo(5  ,0,0,0,0,0,0).  
timeDeGrupo(6  ,0,0,0,0,0,0).  
timeDeGrupo(7  ,0,0,0,0,0,0).  
timeDeGrupo(8  ,0,0,0,0,0,0).  
timeDeGrupo(9  ,0,0,0,0,0,0).  
timeDeGrupo(10 ,0,0,0,0,0,0). 

grupoA(-1,-1,-1,-1,-1).
grupoB(-1,-1,-1,-1,-1).

setGrupos() :- 
	indices([T1|[T2|[T3|[T4|[T5|[T6|[T7|[T8|[T9|[T10|_]]]]]]]]]]),
	setGrupoA(T1,T2,T3,T4,T5), setGrupoB(T6,T7,T8,T9,T10).

setGrupoA(T1,T2,T3,T4,T5):-
	retract(grupoA(-1,_,_,_,_)),
	assert(grupoA(T1,T2,T3,T4,T5)).

setGrupoB(T1,T2,T3,T4,T5):-
	retract(grupoB(-1,_,_,_,_)),
	assert(grupoB(T1,T2,T3,T4,T5)).

setTimeVencedor(TIME_ID, GOLS_FEITOS) :- 
	retract(timeDeGrupo(TIME_ID,PONTOS,PARTIDAS,VITORIAS,EMPATES,DERROTAS,GOLS)),
	NEWPONTOS is PONTOS + 3, NEWPARTIDAS is PARTIDAS + 1, NEWVITORIAS is VITORIAS + 1, NEWGOLS is GOLS + GOLS_FEITOS,
	assert(timeDeGrupo(TIME_ID,NEWPONTOS,NEWPARTIDAS,NEWVITORIAS,EMPATES,DERROTAS,NEWGOLS)).

setTimeEmpates(TIME_ID, GOLS_FEITOS) :- 
	retract(timeDeGrupo(TIME_ID,PONTOS,PARTIDAS,VITORIAS,EMPATES,DERROTAS,GOLS)),
	NEWPONTOS is PONTOS + 1, NEWPARTIDAS is PARTIDAS + 1, NEWEMPATES is EMPATES + 1, NEWGOLS is GOLS + GOLS_FEITOS,
	assert(timeDeGrupo(TIME_ID,NEWPONTOS,NEWPARTIDAS,VITORIAS,NEWEMPATES,DERROTAS,NEWGOLS)).

setTimePerdedor(TIME_ID, GOLS_FEITOS) :- 
	retract(timeDeGrupo(TIME_ID,PONTOS,PARTIDAS,VITORIAS,EMPATES,DERROTAS,GOLS)),
	NEWPARTIDAS is PARTIDAS + 1, NEWDERROTAS is DERROTAS + 1, NEWGOLS is GOLS + GOLS_FEITOS,
	assert(timeDeGrupo(TIME_ID,PONTOS,NEWPARTIDAS,VITORIAS,EMPATES,NEWDERROTAS,NEWGOLS)).

getPontos(Time,Pontos):-
	timeDeGrupo(Time ,Pontos,_,_,_,_,_).

getPontosTotal(Time,PontosT):-
	getPontos(Time,Pontos),
	getGols(Time,Gols),
	GolsP is (Gols * 0.01),
	PontosT is Pontos + GolsP.

getPartidas(Time,Partida):-
	timeDeGrupo(Time ,_,Partida,_,_,_,_).

getVitorias(Time,Vitorias):-
	timeDeGrupo(Time ,_,_,Vitorias,_,_,_).

getEmpates(Time,Empates):-
	timeDeGrupo(Time ,_,_,_,Empates,_,_).

getDerrotas(Time,Derrotas):-
	timeDeGrupo(Time ,_,_,_,_,Derrotas,_).

getGols(Time,Gols):-
	timeDeGrupo(Time ,_,_,_,_,_,Gols).

vencedoresDaRodada('','','','','').

setVencedoresDaRodada(Time1,Time2,Time3,Time4,Time5,Time6,Time7,Time8,Time9,Time10):- 
	partidaFaseGrupos(Time1,Time2,Result1),
	partidaFaseGrupos(Time3,Time4,Result2),
	partidaFaseGrupos(Time5,Time6,Result3),
	partidaFaseGrupos(Time7,Time8,Result4),
	partidaFaseGrupos(Time9,Time10,Result5),
	retract(vencedoresDaRodada(_,_,_,_,_)),
	assert(vencedoresDaRodada(Result1,Result2,Result3,Result4,Result5)).

partidaFaseGrupos(Time1,Time2,Resultado):-
	getNome(Time1,Nome1),
	getNome(Time2,Nome2),
	write(Nome1),write(' x '),write(Nome2),nl,
	calculoGolsEmCasa(Time1,Pts1),
	calculoGolsForaCasa(Time2,Pts2),
	verificaResultado(Time1,Time2,Pts1,Pts2,Resultado).

verificaResultado(Time1,Time2,Pts1,Pts2,Time1):-
	Pts1 > Pts2,
	setTimeVencedor(Time1,Pts1),
	setTimePerdedor(Time2,Pts2).

verificaResultado(Time1,Time2,Pts1,Pts2,Time2):-
	Pts1 < Pts2,
	setTimeVencedor(Time2,Pts2),
	setTimePerdedor(Time1,Pts1).

verificaResultado(Time1,Time2,Pts1,Pts2,''):-
	Pts1 == Pts2,
	setTimeEmpates(Time1,Pts1),
	setTimeEmpates(Time2,Pts2).

imprimeGrupoA :-
	ordenaTimes('A',[Time1,Time2,Time3,Time4,Time5]),
	write('---------- ---------- ---------- ---------- ---------- ---------- ---------- -----------\nClassificacao: GrupoA\nPosicao Nome 			Pontos Partidas Vitorias Empates Derrotas Gols'),nl,
	showTime(Time1,1),
	showTime(Time2,2),
	showTime(Time3,3),
	showTime(Time4,4),
	showTime(Time5,5),
	write('---------- ---------- ---------- ---------- ---------- ---------- ---------- -----------'), nl.

imprimeGrupoB :-
	ordenaTimes('B',[Time1,Time2,Time3,Time4,Time5]),
	write('---------- ---------- ---------- ---------- ---------- ---------- ---------- -----------\nClassificacao: GrupoB\nPosicao Nome 			Pontos Partidas Vitorias Empates Derrotas Gols'),nl,
	showTime(Time1,1),
	showTime(Time2,2),
	showTime(Time3,3),
	showTime(Time4,4),
	showTime(Time5,5),
	write('---------- ---------- ---------- ---------- ---------- ---------- ---------- -----------'), nl.

padronizaString(Texto, TextoNovo, Tamanho) :- string_length(Texto, X), X == Tamanho, TextoNovo = Texto.
padronizaString(Texto, TextoNovo, Tamanho) :- addSpace(Texto, NewText), padronizaString(NewText, TextoNovo, Tamanho).
addSpace(Text, NewText) :- string_concat(Text, ' ', NewText). 

showTime(TIME_ID, POS):-
	getNome(TIME_ID,Nome),
	getPontos(TIME_ID,Pontos),
	getPartidas(TIME_ID,Partidas),
	getVitorias(TIME_ID,Vitorias),
	getEmpates(TIME_ID,Empates),
	getDerrotas(TIME_ID,Derrotas),
	getGols(TIME_ID, Gols),
	padronizaString(Nome, NEWNOME, 20),
	padronizaString(Pontos, NEWPONTOS, 2),
	padronizaString(Partidas, NEWPARTIDAS, 2),
	padronizaString(Vitorias, NEWVITORIAS, 2),
	padronizaString(Empates, NEWEMPATES, 2),
	padronizaString(Derrotas, NEWDERROTAS, 2),
	padronizaString(Gols, NEWGOLS, 2),
	write(POS),write('º '),write(NEWNOME),write('	           '),write(NEWPONTOS),write('	  '),write(NEWPARTIDAS),write(' 	   '),write(NEWVITORIAS),write('	    '),write(NEWEMPATES),write('	    '),write(NEWDERROTAS),write('	    '),write(NEWGOLS),nl.


calculoGolsEmCasa(Time,Gols):-
	getSumAtributos(Time,Soma),
	PesoTorcidaCasa is 0.7,
	ValorEquilibrio is 0.01,
	GolsParciaisFloat is Soma * PesoTorcidaCasa * ValorEquilibrio,
    GolsParciaisInt is round(GolsParciaisFloat),
	GolsParciaisIntNegativo is (GolsParciaisInt * -1),
	random(GolsParciaisIntNegativo,GolsParciaisInt,Saida),
	Gols is GolsParciaisInt + Saida.


calculoGolsForaCasa(Time,Gols):-
	getSumAtributos(Time,Soma),
	PesoTorcidaCasa is 0.3,
	ValorEquilibrio is 0.01,
	GolsParciaisFloat is Soma * PesoTorcidaCasa * ValorEquilibrio,
	GolsParciaisInt is round(GolsParciaisFloat),
	GolsParciaisIntNegativo is (GolsParciaisInt * -1),
	random(GolsParciaisIntNegativo,GolsParciaisInt,Saida),
	Gols is GolsParciaisInt + Saida.


ordenaTimes('A',TimesOrdenados):-
	grupoA(Time1,Time2,Time3,Time4,Time5),
	getPontosTotal(Time1,Pts1),
	getPontosTotal(Time2,Pts2),
	getPontosTotal(Time3,Pts3),
	getPontosTotal(Time4,Pts4),
	getPontosTotal(Time5,Pts5),
	Pairs = [Pts1-Time1,Pts2-Time2,Pts3-Time3,Pts4-Time4,Pts5-Time5],
	sort(1, @>=, Pairs, ParesOrdenados),
	pairs_values(ParesOrdenados,TimesOrdenados).


ordenaTimes('B',TimesOrdenados):-
	grupoB(Time1,Time2,Time3,Time4,Time5),
	getPontosTotal(Time1,Pts1),
	getPontosTotal(Time2,Pts2),
	getPontosTotal(Time3,Pts3),
	getPontosTotal(Time4,Pts4),
	getPontosTotal(Time5,Pts5),
	Pairs = [Pts1-Time1,Pts2-Time2,Pts3-Time3,Pts4-Time4,Pts5-Time5],
	sort(1, @>=, Pairs, ParesOrdenados),
	pairs_values(ParesOrdenados,TimesOrdenados).


imprimeVencedoresRodada:-
	vencedoresDaRodada(Time1,Time2,Time3,Time4,Time5),
	getNome(Time1,Nome1),
	getNome(Time2,Nome2),
	getNome(Time3,Nome3),
	getNome(Time4,Nome4),
	getNome(Time5,Nome5),
	write('Vencedores da rodada: '),nl,
	write(Nome1),write(' | '),
	write(Nome2),write(' | '),
	write(Nome3),write(' | '),
	write(Nome4),write(' | '),
	write(Nome5),write(' | '),nl.





:- dynamic grupoA/5.
:- dynamic grupoB/5.
:- dynamic timeDeGrupo/7.
:- dynamic vencedoresDaRodada/5.

main :-
	setGrupos(),
	grupoA(Time1,Time2,Time3,Time4,Time5),
	grupoB(Time6,Time7,Time8,Time9,Time10),

	nl, write('Rodada 01:'), nl,
	setVencedoresDaRodada(Time1,Time6,Time2,Time7,Time3,Time8,Time4,Time9,Time5,Time10),
	imprimeGrupoA,
	imprimeGrupoB,
	imprimeVencedoresRodada,

	nl,nl, write('Rodada 02:'), nl,
	setVencedoresDaRodada(Time1,Time7,Time2,Time8,Time3,Time9,Time4,Time10,Time5,Time6),
	imprimeGrupoA,
	imprimeGrupoB,
	imprimeVencedoresRodada,

	nl,nl, write('Rodada 03:'), nl,
	setVencedoresDaRodada(Time1,Time8,Time2,Time9,Time3,Time10,Time4,Time6,Time5,Time7),
	imprimeGrupoA,
	imprimeGrupoB,
	imprimeVencedoresRodada,

	nl,nl, write('Rodada 04:'), nl,
	setVencedoresDaRodada(Time1,Time9,Time2,Time10,Time3,Time6,Time4,Time7,Time5,Time8), 
	imprimeGrupoA,
	imprimeGrupoB,
	imprimeVencedoresRodada,

	nl,nl, write('Rodada 05:'), nl,
	setVencedoresDaRodada(Time1,Time10,Time2,Time6,Time3,Time7,Time4,Time8,Time5,Time9), 
	imprimeGrupoA,
	imprimeGrupoB,
	imprimeVencedoresRodada,

	nl,nl, write('Rodada 06:'), nl,
	setVencedoresDaRodada(Time6,Time1,Time7,Time2,Time8,Time3,Time9,Time4,Time10,Time5), 
	imprimeGrupoA,
	imprimeGrupoB,
	imprimeVencedoresRodada,

	nl,nl, write('Rodada 07:'), nl,
	setVencedoresDaRodada(Time7,Time1,Time8,Time2,Time9,Time3,Time10,Time4,Time6,Time5), 
	imprimeGrupoA,
	imprimeGrupoB,
	imprimeVencedoresRodada,

	nl,nl, write('Rodada 08:'), nl,
	setVencedoresDaRodada(Time8,Time1,Time9,Time2,Time10,Time3,Time6,Time4,Time7,Time5), 
	imprimeGrupoA,
	imprimeGrupoB,
	imprimeVencedoresRodada,

	nl,nl, write('Rodada 09:'), nl,
	setVencedoresDaRodada(Time9,Time1,Time10,Time2,Time6,Time3,Time7,Time4,Time8,Time5), 
	imprimeGrupoA,
	imprimeGrupoB,
	imprimeVencedoresRodada,

	nl,nl, write('Rodada 10:'), nl,
	setVencedoresDaRodada(Time10,Time1,Time6,Time2,Time7,Time3,Time8,Time4,Time9,Time5),
	imprimeGrupoA,
	imprimeGrupoB,
	imprimeVencedoresRodada.