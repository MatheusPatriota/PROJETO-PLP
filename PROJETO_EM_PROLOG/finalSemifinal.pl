% time tem (id, nome, ataque, defesa, controle, confianca, condicao )

:- initialization semifinal.
time(1, 'Campinense',  		 77, 72, 77, 76, 100).
time(2, 'Treze',       		 73, 70, 74, 72, 100).
time(3, 'Botafogo-PB', 		 80, 76, 81, 78, 100).
time(4, 'Atletico-PB', 		 58, 61, 62, 59, 100).
time(5, 'Souza', 	   		 63, 65, 65, 68, 100).
time(6, 'Nacional de Patos', 59, 60, 45, 61, 100).
time(7, 'Serrano', 			 48, 50, 56, 52, 100).
time(8, 'Perilima', 		 46, 50, 59, 46, 100).
time(9, 'Esporte de Patos',  57, 62, 61, 57, 100).
time(10, 'CSP', 			 64, 66, 69, 65, 100).

caixaUsuario(1200).


getNome(NumTime,Saida):-
time(NumTime,Saida,_,_,_,_,_).

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

% timeSF(NumTime,PtTime).

timeSF(1,0).
timeSF(2,0).
timeSF(3,0).
timeSF(4,0).


getPtSF(NumTime,Pts):-
	timeSF(NumTime,Pts).

setPtSF(NumTime, PtsNovos):-
	retract(timeSF(NumTime,_)),
	assert(timeSF(NumTime,PtsNovos)).

addPtSF(NumTime,PtsNovos):-
	getPtSF(NumTime,Pts),
	PtsFinal is Pts + PtsNovos,
	setPtSF(NumTime,PtsFinal).

addCaixa(Valor):-
	getCaixa(ValorAtual),
	ValorFinal is ValorAtual + Valor,
	setCaixa(ValorFinal).

getGanhadorSF(Time1,Time2,Time1):-
	getPtSF(Time1, Pts1),
	getPtSF(Time2, Pts2),
	Pts1 > Pts2.

getGanhadorSF(_,Time2,Time2).


imprimeTimesSF:-
	nl,
	timeSF(NumTime,Pts),
	getNome(NumTime,Nome),
	write(Nome),write(" : "),write(Pts),nl,fail.

classificadosSemi(1,2,3,4).

%classificadosSemi(Time1,Time2,Time3,Time4).

semifinal:-
write("-------- Fase Semi-Final ---------"),nl,
	classificadosSemi(Time1,Time2,Time3,Time4),
	statusSemiEfinal(Time1,Time2),
	statusSemiEfinal(Time3,Time4),
	write('Deseja Apostar ? Se sim, digite o numero correspondente ao time(1 ou 2), se nao digite qualquer outro numero.'),
	nl,
	write('Aposta1?: '),
	read_line_to_string(user_input,Aposta1),
	write('Aposta2?: '),
	read_line_to_string(user_input,Aposta2),
	partidaSemiFinal(Time1,Time2),
	partidaSemiFinal(Time2,Time1),
	partidaPenaltis(Time1,Time2),
	verificaAposta(Time1,Time2,Aposta1),
	partidaSemiFinal(Time3,Time4),
	partidaSemiFinal(Time4,Time3),
	partidaPenaltis(Time3,Time4),
	verificaAposta(Time3,Time4,Aposta2),
	getGanhadorSF(Time1,Time2,Ganhador1),
	getGanhadorSF(Time3,Time4,Ganhador2),
	setPtSF(Ganhador1,0),
	setPtSF(Ganhador2,0),
	getCaixa(Caixa),
	write('---------Seu valor em caixa eh de: '),
	write(Caixa),
	nl,
	write('Pressione Enter para prosseguir para a fase Final: '),
	read_line_to_string(user_input,_),
	final(Ganhador1,Ganhador2).



final(Time1,Time2):-
	nl,write('----------- Fase Final ------------'),nl,
	statusSemiEfinal(Time1,Time2),
	write('Deseja Apostar ? Se sim, digite o numero correspondente ao time(1 ou 2), se nao digite qualquer outro numero.'),
	nl,
	write('Aposta para a Final?:'),
	read_line_to_string(user_input,Aposta1),nl,
	partidaSemiFinal(Time1,Time2),
	partidaPenaltis(Time1,Time2),
	verificaAposta(Time1,Time2,Aposta1),
	getGanhadorSF(Time1,Time2,Ganhador1),
	getNome(Ganhador1,NomeGanhador),
	nl,
	write('O grande ganhador do campeonato eh:'),
	nl,
	write('         '),write(NomeGanhador),
	nl,
	getCaixa(Caixa),
	write('---------Seu valor em caixa eh de: '),
	write(Caixa).


%funcao generica de partida
partidaSemiFinal(Time1,Time2):-
	random(0,5,Pts1),
	random(0,5,Pts2),
	addPtSF(Time1,Pts1),
	addPtSF(Time2,Pts2),
	getNome(Time1,Nome1),getNome(Time2,Nome2),
	write(Nome1),write(" ( "),write(Pts1),write(" )  ( "),
	write(Pts2),write(" ) "),write(Nome2),nl,nl.


%verifica se é necessario penaltis joga, e ja atualiza os dados dos times assim como exibe o jogo.

partidaPenaltis(Time1,Time2):-
	getPtSF(Time1,Pt1),
	getPtSF(Time2,Pt2),
	Pt1 == Pt2,
	nl,nl,
	write('----Partida de penaltis----'),
	nl,nl,
	jogaRecurPenaltis(0,Time1,Time2,0,0).

%caso n seja necssario penaltis.
partidaPenaltis(_,_).


%Joga recursivamente os penaltis, qnd há um ganhador, para e exibe o resultado. 
jogaRecurPenaltis(Rodada,Time1,Time2,Pt1,Pt2):-
	Rodada > 5,
	Pt1 \= Pt2,
	getNome(Time1,Nome1),getNome(Time2,Nome2),
	addPtSF(Time1,Pt1),
	addPtSF(Time2,Pt2),
	write(Nome1),write(' ( '),write(Pt1),write(' )  ( '),
	write(Pt2),write(' ) '),write(Nome2),nl.

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
	getAtaque(Time,Atk),
	getDefesa(Time,Def),
	Moeda == 1,
	Num < Atk + Def.

batePenalti(_,0).

verificaAposta(Time1,Time2,Aposta):-
	getPtSF(Time1,PtTime1),
	getPtSF(Time2,PtTime2),
	PtTime1 > PtTime2,
	Aposta == "1",
	write('Voce ganhou 600!!'),nl,
	addCaixa(600).

verificaAposta(Time1,Time2,Aposta):-
	getPtSF(Time1,PtTime1),
	getPtSF(Time2,PtTime2),
	PtTime2 > PtTime1,
	Aposta == "2",
	write('Voce ganhou 600!!'),nl,
	addCaixa(600).

verificaAposta(_,_,Aposta):-
	Aposta \= "1",
	Aposta \= "2",
	write('Voce nao apostou!!'),nl,
	addCaixa(600).

verificaAposta(_,_,_):-
	write('Voce perdeu 500!!'),nl,
	addCaixa(-500).

statusSemiEfinal(Time1,Time2):-
	getNome(Time1,Nome1),getNome(Time2,Nome2),
	nl,
	write(' 1 '),write(Nome1),write(' vs '),write(' 2 '),write(Nome2),nl.

numAleatorio(X):-
	random(40,180,X).

jogaMoeda(X):-
	random(0,2,X).



:- dynamic timeSF/2.
:- dynamic caixaUsuario/1.
:- dynamic time/7.