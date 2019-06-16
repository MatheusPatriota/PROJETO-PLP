:- module(times, [build_time/2,  getId/2, getNome/2, getAtaque/2, getDefesa/2, getControle/2, getConfianca/2,getCondicao/2]).

setup_bd:-
	consult('bd').

% PREDICADOS

isTime(Id):-
  setup_bd,
  time(Id,_,_,_,_,_,_).

build_time(Id, Time):-
  setup_bd,
  isTime(Id),
  time(Id,Nome,Ataque,Defesa,Controle,Confianca,Condicao),
  Time = time(id(Id), nome(Nome), ataque(Ataque), defesa(Defesa), controle(Controle), confianca(Confianca), condicao(Condicao)).

% GETS

getId(Time, Id):- 
  setup_bd, 
  Time = time(id(Id),_,_,_,_,_,_).

getNome(Time,Nome):- 
  setup_bd, 
  Time = time(_,nome(Nome),_,_,_,_,_).

getAtaque(Time,Ataque):- 
  setup_bd, 
  Time = time(_,_,ataque(Ataque),_,_,_,_).


getDefesa(Time, Defesa):- 
  setup_bd, 
  Time = time(_,_,_,defesa(Defesa),_,_,_).

getControle(Time, Controle) :-
  setup_bd,
  Time = time(_,_,_,_,controle(Controle),_,_).

getConfianca(Time, Confianca) :-
  setup_bd,
  Time = time(_,_,_,_,_,confianca(Confianca),_).

getCondicao(Time, Condicao):-
  setup_bd,
  Time = time(_,_,_,_,_,_,condicao(Condicao)).


