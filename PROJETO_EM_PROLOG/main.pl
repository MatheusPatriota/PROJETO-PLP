:- initialization(main).


main:-
    writeln('BEM VINDO AO CAMPEAONATO PARAIBANO DE FUTEBOL'),
    nl,
    write('ESSES SÃO OS PARTICIPANTES: '),
    write('Campinense, Treze, Botafogo-PB, Atletico-PB, Souza, Nacional de Patos, Serrano, Perilima,Esporte de Patos e CSP'),
    nl,
    nl,
    nl,
    write('BEM VINDO APOSTADOR, GOSTARIA DE MANTER O CAPITAL DE 2000, OU DESEJA AUMENTAR?'),
    read(Resposta),
    aumentaAposta(Resposta).


