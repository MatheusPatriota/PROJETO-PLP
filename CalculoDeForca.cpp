
#include "CalculoDeForca.h"

#include <iostream>
#include <ctime>
using namespace std;



//Calculo da for�a de um time
int calculoDeForca(int somatorio, int torcida, float porcentagemDaTorcida){

    // equivale a 70% da for�a do time
	somatorio = (int) (somatorio * 0.7);

	//a porcentagem da torcida � passada como parametro
	torcida = torcida * porcentagemDaTorcida;

	//retorna a for�a total do time
	return somatorio + torcida;
}


//Calcula a for�a de dois times, retornando um array no final, onde a posi��o 0 � o resultado do time 1 e
//a posi��o 1 � o resultado do segundo time
int* resultadoFinal(int time1, int time2){

    srand((unsigned) time(NULL));


    //condi��o para caso um time seja 4 vezes superior ao outro, para que haja chances de acontecer zebras
	if(time1 > 4 * time2){
		time2 = time2 + (rand()% (time1 - time2 + 30));
	}if (time2 > 4 * time1){
		time1 = time1 + (rand()% (time2 - time1 + 30));
	}


	// reduz a for�a do time para uma casa decimal
	int auxTime1 = (int) (time1 * 0.01);
	int auxTime2 = (int) (time2 * 0.01);


	//calcula os resultados
	int random1 = ((-auxTime1) + (rand()% (auxTime1 * 2 -1)));
	int random2 = ((-auxTime2)  + (rand()% (auxTime2 * 2 - 1)));


	auxTime1 += random1;
	auxTime2 += random2;




	// aloca os resultados em um vetor para ser usado futuramente.
	int *result = (int*)malloc(2*sizeof(int));
	result[0] = auxTime1;
	result[1] = auxTime2;
    return result;
}


int* calculoDaAposta(int time1, int time2, double valor){
    int aux1, aux2;


    if (time1 > time2){
        aux1 = valor - (time1 * 0.15);
        aux2 = valor + (time2 *0.35);
    }else{
        aux1 = valor + (time1 *0.35);
        aux2 = valor - (time2 *0.15);
    }
    int* result = (int*)malloc(2*sizeof(int));
    result[0] = aux1;
    result[1] = aux2;

    return result;
}

int main() {

	//array com cadastro dos times
	string idTime[10];
	idTime[0] = "Souza";
	idTime[1] = "CSP";
	idTime[2] = "Campinense";
	idTime[3] = "Treze";
	idTime[4] = "Botafogo";
	idTime[5] = "Serrano";
	idTime[6] = "Perilima";
	idTime[7] = "Atletico-PB";
	idTime[8] = "Esporte De Patos";
	idTime[9] = "Nacional de Patos";



	//Array com atributos dos times
	int timesAtributos [10][6];

	//Souza:
	//ataque
	timesAtributos[0][0] = 63;//0 a 100
	//defesa
	timesAtributos[0][1] = 65;//0 a 100
	//controle de jogo
	timesAtributos[0][2] = 65;//0 a 100
	//confian�a
	timesAtributos[0][3] = 68;//100 a 0
	//disposi��o fisica
	timesAtributos[0][4] = 100;//100 a 0
	//torcida
	timesAtributos[0][5] = 80;
	//jogador1
	//timesAtributos[0][5] = 4;//1 a 10
	//jogador2
	//timesAtributos[0][6] = 5;//1 a 10
	//jogador3
	//timesAtributos[0][7] = 5;//1 a 10
	//Capital
	//timesAtributos[0][8] = 5000;

	//CSP:
	//ataque
	timesAtributos[1][0] = 64;//0 a 100
	//defesa
	timesAtributos[1][1] = 66;//0 a 100
	//controle de jogo
	timesAtributos[1][2] = 69;//0 a 100
	//confian�a
	timesAtributos[1][3] = 65;//100 a 0
	//disposi��o fisica
	timesAtributos[1][4] = 100;//100 a 0
	//torcida
	timesAtributos[1][5] = 80;
	//jogador1
	//timesAtributos[0][5] = 4;//1 a 10
	//jogador2
	//timesAtributos[0][6] = 5;//1 a 10
	//jogador3
	//timesAtributos[0][7] = 5;//1 a 10
	//Capital
	//timesAtributos[0][8] = 5000;



	//Campinense:
	//ataque
	timesAtributos[2][0] = 77;//0 a 100
	//defesa
	timesAtributos[2][1] = 72;//0 a 100
	//controle de jogo
	timesAtributos[2][2] = 77;//0 a 100
	//confian�a
	timesAtributos[2][3] = 76;//100 a 0
	//disposi��o fisica
	timesAtributos[2][4] = 100;//100 a 0
	//torcida
	timesAtributos[2][5] = 80;
	//jogador1
	//timesAtributos[0][5] = 4;//1 a 10
	//jogador2
	//timesAtributos[0][6] = 5;//1 a 10
	//jogador3
	//timesAtributos[0][7] = 5;//1 a 10
	//Capital
	//timesAtributos[0][8] = 5000;

	//Treze:
	//ataque
	timesAtributos[3][0] = 73;//0 a 100
	//defesa
	timesAtributos[3][1] = 70;//0 a 100
	//controle de jogo
	timesAtributos[3][2] = 74;//0 a 100
	//confian�a
	timesAtributos[3][3] = 72;//100 a 0
	//disposi��o fisica
	timesAtributos[3][4] = 100;//100 a 0
	//torcida
	timesAtributos[3][5] = 80;
	// //jogador1
	// timesAtributos[1][5] = 4;//1 a 10
	// //jogador2
	// timesAtributos[1][6] = 5;//1 a 10
	// //jogador3
	// timesAtributos[1][7] = 5;//1 a 10

	//Botafogo:
	//ataque
	timesAtributos[4][0] = 80;//0 a 100
	//defesa
	timesAtributos[4][1] = 76;//0 a 100
	//controle de jogo
	timesAtributos[4][2] = 81;//0 a 100
	//confian�a
	timesAtributos[4][3] = 78;//100 a 0
	//disposi��o fisica
	timesAtributos[4][4] = 100;//100 a 0
	//torcida
	timesAtributos[4][5] = 80;
	// //jogador1
	// timesAtributos[2][5] = 4;//1 a 10
	// //jogador2
	// timesAtributos[2][6] = 5;//1 a 10
	// //jogador3
	// timesAtributos[2][7] = 5;//1 a 10

	//Serrano:
	//ataque
	timesAtributos[5][0] = 48;//0 a 100
	//defesa
	timesAtributos[5][1] = 50;//0 a 100
	//controle de jogo
	timesAtributos[5][2] = 56;//0 a 100
	//confian�a
	timesAtributos[5][3] = 52;//100 a 0
	//disposi��o fisica
	timesAtributos[5][4] = 100;//100 a 0
	//torcida
	timesAtributos[5][5] = 80;
	//jogador1
	// timesAtributos[2][5] = 4;//1 a 10
	// //jogador2
	// timesAtributos[2][6] = 5;//1 a 10
	// //jogador3
	// timesAtributos[2][7] = 5;//1 a 10

	//Perilima:
	//ataque
	timesAtributos[6][0] = 46;//0 a 100
	//defesa
	timesAtributos[6][1] = 50;//0 a 100
	//controle de jogo
	timesAtributos[6][2] = 59;//0 a 100
	//confian�a
	timesAtributos[6][3] = 46;//100 a 0
	//disposi��o fisica
	timesAtributos[6][4] = 100;//100 a 0
	//torcida
	timesAtributos[6][5] = 80;
	//jogador1
	// timesAtributos[2][5] = 4;//1 a 10
	// //jogador2
	// timesAtributos[2][6] = 5;//1 a 10
	// //jogador3
	// timesAtributos[2][7] = 5;//1 a 10

	//Atletico - PB:
	//ataque
	timesAtributos[7][0] = 58;//0 a 100
	//defesa
	timesAtributos[7][1] = 61;//0 a 100
	//controle de jogo
	timesAtributos[7][2] = 62;//0 a 100
	//confian�a
	timesAtributos[7][3] = 59;//100 a 0
	//disposi��o fisica
	timesAtributos[7][4] = 100;//100 a 0
	//torcida
	timesAtributos[7][5] = 80;
	//jogador1
	// timesAtributos[2][5] = 4;//1 a 10
	// //jogador2
	// timesAtributos[2][6] = 5;//1 a 10
	// //jogador3
	// timesAtributos[2][7] = 5;//1 a 10


	//Esporte de Patos:
	//ataque
	timesAtributos[8][0] = 57;//0 a 100
	//defesa
	timesAtributos[8][1] = 62;//0 a 100
	//controle de jogo
	timesAtributos[8][2] = 61;//0 a 100
	//confian�a
	timesAtributos[8][3] = 57;//100 a 0
	//disposi��o fisica
	timesAtributos[8][4] = 100;//100 a 0
	//torcida
	timesAtributos[8][5] = 80;
	//jogador1
	// timesAtributos[2][5] = 4;//1 a 10
	// //jogador2
	// timesAtributos[2][6] = 5;//1 a 10
	// //jogador3
	// timesAtributos[2][7] = 5;//1 a 10


	//Nacional de Patos:
	//ataque
	timesAtributos[9][0] = 59;//0 a 100
	//defesa
	timesAtributos[9][1] = 60;//0 a 100
	//controle de jogo
	timesAtributos[9][2] = 60;//0 a 100
	//confian�a
	timesAtributos[9][3] = 61;//100 a 0
	//disposi��o fisica
	timesAtributos[9][4] = 100;//100 a 0
	//torcida
	timesAtributos[9][5] = 80;
	//jogador1
	// timesAtributos[2][5] = 4;//1 a 10
	// //jogador2
	// timesAtributos[2][6] = 5;//1 a 10
	// //jogador3
	// timesAtributos[2][7] = 5;//1 a 10


	//for�a do campinense
	int resultado1 = 0;

	for(int i = 0; i < 5; i++){
		resultado1 = resultado1 + timesAtributos[3][i];
	}
	int forcaTime1 = calculoDeForca(resultado1, timesAtributos[3][4], 0.7);


	//força do treze
	int resultado2 = 0;
	for(int i = 0; i < 5; i++){
			resultado2 = resultado2 + timesAtributos[2][i];
		}
	int forcaTime2 = calculoDeForca(resultado2, timesAtributos[2][4], 0.3);

	int* resultadoFinalPartida = resultadoFinal(forcaTime1, forcaTime2);
	int* valorRecebidoApostas = calculoDaAposta(forcaTime1, forcaTime2, 500);
	printf("Gols do time1: %d\nGols do time2: %d\n", resultadoFinalPartida[0], resultadoFinalPartida[1]);
	printf("Valor ganho por apostar no time1: %d\nValor ganho por apostar no time2: %d\n", valorRecebidoApostas[0], valorRecebidoApostas[1]);

}
