% timeSF(NumTime,PtTime).

getPtSF(NumTime,Pts):-
timeSF(NumTime,PtTime).

setPtSF(NumTime, PtsNovos):-
retract(timeSF(NumTime,_)),
assert(timeSF(NumTime,PtsNovos)).

addPtSF(NumTime,PtsNovos):-
getPtSF(NumTime,Pts),
PtsFinal is Pts + PtsNovos,
setPtSF(NumTime,PtsFinal).



classificadosSemi(Time1,Time2,Time3,Time4).

semifinal():-
write("---------Semifinal---------"),nl,
classificadosSemi(Time1,Time2,Time3,Time4),
partidaSemiFinal(Time1,Time2),
partidaSemiFinal(Time2,Time1),
partidaPenaltis(Time1,Time2),
partidaSemiFinal(Time3,Time4),
partidaSemiFinal(Time4,Time3),
partidaPenaltis(Time3,Time4).



%verifica se é necessario penaltis joga, e ja atualiza os dados dos times assim como exibe o jogo.

partidaPenaltis(Time1,Time2):-
getPtSF(Time1,Pt1),
getPtSF(Time2,Pt2),
Pt1 == Pt2,
nl,writenl("----Partida de penaltis----"),
jogaRecurPenaltis(Rodada,Time1,Time2,0,0).

%caso n seja necssario penaltis.
partidaPenaltis(_,_).


%Joga recursivamente os penaltis, qnd há um ganhador, para e exibe o resultado. 
jogaRecurPenaltis(Rodada,Time1,Time2,Pt1,Pt2):-
Rodada > 5,
Pt1 \= Pt2,
getNome(Time1,Nome1),getNome(Time2,Nome2),
addPtSF(Time1,Pt1),
addPtSF(Time2,Pt2),
write(Nome1),write(" ( "),write(Pt1),write(" )  ( "),
write(Pt2),write(" ) "),write(Nome2),nl.

%loop
jogaRecurPenaltis(Rodada,Time1,Time2,Pt1,Pt2):-
RodadaMaisUm is Rodada + 1,
batePenalti(Time1,X),
batePenalti(Time2,Y),
Pt1Novo is Pt1 + X,
Pt2Novo is Pt2 + Y,
jogaRecurPenaltis(RodadaMaisUm,Time1,Time2,Pt1Novo,Pt2Novo).

%regra para bater um penalti, so retorna "1", se a condicao for atendida.
batePenalti(Time,1):-
numAleatorio(Num),
jogaMoeda(Moeda),
getAtq(Time,Atk),
getDef(Time,Def),
Moeda == 1,
Num < Atk + Def.

batePenalti(_,0).

verificaAposta(Time1,Time2,Aposta):-
getPtSF(Time1,PtTime1),
getPtSF(Time2,PtTime2),
PtTime1 > PtTime2,
Aposta == "1",
write("Voce ganhou 600!!"),nl,
caixa(600).

verificaAposta(Time1,Time2,Aposta):-
getPtSF(Time1,PtTime1),
getPtSF(Time2,PtTime2),
PtTime2 > PtTime1,
Aposta == "2",
writenl("Voce ganhou 600!!"),
caixa(600).

verificaAposta(_,_,Aposta):-
Aposta \= "1";
Aposta \= "2",
writenl("Voce nao apostou!!"),
caixa(600).

verificaAposta(_,_,_):-
writenl("Voce perdeu 500!!"),nl,
caixa(-500).

statusSemiEfinal(Time1,Time2):-
getNome(Time1,Nome1),getNome(Time2,Nome2),
nl,
write(" 1 "),write(Nome1),write(" vs "),write(" 2 "),writenl(Nome2).


nl.

numAleatorio(X):-
random(40,180,X).

jogaMoeda(X):-
random(0,1,X).