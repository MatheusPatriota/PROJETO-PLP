# Simulador do Campeonato Paraibano de Futebol

![C++](https://img.shields.io/badge/C%2B%2B-Done-success.svg) 
![Haskell](https://img.shields.io/badge/Haskell-Done-success.svg) 
![Prolog](https://img.shields.io/badge/Prolog-In%20Process-yellow.svg) 


## Descrição do Projeto
O projeto consiste em um simulador do campeonato paraibano  de futebol, onde será efetuado às simulações dos resultados dos jogos até o fim do campeonato.
O usuário pode fazer suas apostas a cada rodada, as recompensas da aposta varia de acordo com a importância da partida. O usuário não é obrigado a realizar suas apostas em tal rodada.

O usuário começa no simulador com um certo valor disponível para apostas, no caso desse valor zerar, o usuário não consegue realizar suas apostas na próxima rodada, porém, passando-se outra rodada, ele receberá um valor igual ao valor que ele iniciou o  simulador, podendo assim retornar suas apostas.

Os times possuem a sua força inicial pré-definida, esses valores vão sendo alterados ao longo do campeonato, baseado nos resultados das partidas. Existe a possibilidade de acontecer zebra durante o campeonato.
Ao final do campeonato, é declarado o time vencedor e o valor acumulado pelo usuário.

## Como é calculado a força de um time?

CÁLCULO DE FORÇA DO TIME:
(((ATAQUE + DEFESA + CONTROLE DE JOGO + CONFIANÇA DA EQUIPE + DISPOSIÇÃO FÍSICA) * 0,7) + (TORCIDA * 0,3)) * 0,01
por padrão o time da casa tem direito a 70% do estádio enquanto o visitante tem direito a 30%. porém essa capacidade será preenchida de acordo com o momento do time no campeonato.

## Implementações 

- Implementado em C++ [aqui](https://github.com/MatheusPatriota/PROJETO-PLP/tree/master/PROJETO_EM_C%2B%2B)
- Implementado em Haskell [aqui](https://github.com/MatheusPatriota/PROJETO-PLP/tree/master/PROJETO_EM_HASKELL)
- Implementado em Prolog [aqui](https://github.com/MatheusPatriota/PROJETO-PLP/tree/master/PROJETO_EM_PROLOG)


## Desenvolvedores

- [Matheus Patriota](https://github.com/MatheusPatriota)

