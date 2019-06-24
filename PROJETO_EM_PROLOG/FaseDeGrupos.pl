:- initialization(main).

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

setGrupos() :- indices([T1|[T2|[T3|[T4|[T5|[T6|[T7|[T8|[T9|[T10|_]]]]]]]]]]),
setGrupoA(T1,T2,T3,T4,T5), setGrupoB(T6,T7,T8,T9,T10).

setGrupoA(T1,T2,T3,T4,T5):-
retract(grupoA(_,_,_,_,_)),
assert(grupoA(T1,T2,T3,T4,T5)).

setGrupoB(T1,T2,T3,T4,T5):-
retract(grupoB(_,_,_,_,_)),
assert(grupoB(T1,T2,T3,T4,T5)).

setTimeVencedor(TIME_ID, GOLS_FEITOS) :- 
retract(timeDeGrupo(TIME_ID,PONTOS,PARTIDAS,VITORIAS,_,_,GOLS)),
NEWPONTOS is PONTOS + 3, NEWPARTIDAS is PARTIDAS + 1, NEWVITORIAS is VITORIAS + 1, NEWGOLS is GOLS + GOLS_FEITOS,
assert(timeDeGrupo(TIME_ID,NEWPONTOS,NEWPARTIDAS,NEWVITORIAS,_,_,NEWGOLS)).

setTimeEmpates(TIME_ID, GOLS_FEITOS) :- 
retract(timeDeGrupo(TIME_ID,PONTOS,PARTIDAS,_,EMPATES,_,GOLS)),
NEWPONTOS is PONTOS + 1, NEWPARTIDAS is PARTIDAS + 1, NEWEMPATES is EMPATES + 1, NEWGOLS is GOLS + GOLS_FEITOS,
assert(timeDeGrupo(TIME_ID,NEWPONTOS,NEWPARTIDAS,_,NEWEMPATES,_,NEWGOLS)).

setTimePerdedor(TIME_ID, GOLS_FEITOS) :- 
retract(timeDeGrupo(TIME_ID,_,PARTIDAS,_,_,DERROTAS,GOLS)),
NEWPARTIDAS is PARTIDAS + 1, NEWDERROTAS is DERROTAS + 1, NEWGOLS is GOLS + GOLS_FEITOS,
assert(timeDeGrupo(TIME_ID,_,NEWPARTIDAS,_,_,NEWDERROTAS,NEWGOLS)).

:- dynamic grupoA/5.
:- dynamic grupoB/5.
:- dynamic timeDeGrupo/7.

% string_concat('Opa', 'Porra', X)
main :-
 write('Luiggy').