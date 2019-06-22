:- dynamic caixaUsuario/1.
:- dynamic time/7.


% time tem (id, nome, ataque, defesa, controle, confianca, condicao )

time(1, 'Campinense',  		 77, 72, 77, 76, 100).
time(2, 'Treze',       		 73, 70, 74, 72, 100).
time(3, 'Botafogo-PB', 		 80, 76, 81, 78, 100).
time(4, 'Atletico-PB', 		 58, 61, 62, 59, 100).
time(5, 'Souza', 	   		 63, 65, 65, 68, 100).
time(6, 'Nacional de Patos', 59, 60, 45, 61, 100).
time(7, 'Serrano', 			 48, 50, 56, 52, 100).
time(8, 'Perilima', 		 46, 50, 59, 46, 100).
time(9, 'Esporte de Patos',  57, 62, 61, 57, 100).
time(10,'CSP', 			     64, 66, 69, 65, 100).

% Capital do usuario

caixaUsuario(2000).


% Gets
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

getCaixa(Saida):-
    caixaUsuario(Saida).

    
% Sets

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

