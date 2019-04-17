/*
 * CalculoDeForca.cpp
 *
 *  Created on: 17 de abr de 2019
 *      Author: yuri
 */

#include "CalculoDeForca.h"

#include <iostream>
#include <ctime>
using namespace std;



//Calculo da força de um time
int calculoDeForca(int somatorio, int torcida, float porcentagemDaTorcida){

    // equivale a 70% da força do time
	somatorio = (int) (somatorio * 0.7);

	//a porcentagem da torcida é passada como parametro
	torcida = torcida * porcentagemDaTorcida;

	//retorna a força total do time
	return somatorio + torcida;
}


//Calcula a força de dois times, retornando um array no final, onde a posição 0 é o resultado do time 1 e
//a posição 1 é o resultado do segundo time
int* resultadoFinal(int time1, int time2){

    srand((unsigned) time(NULL));

    //condição para caso um time seja 4 vezes superior ao outro, para que haja chances de acontecer zebras
	if(time1 > 4 * time2){
		time2 = time2 + (rand() % time1 - time2 + 30);
	}if (time2 > 4 * time1){
		time1 = time1 + (rand() % time2 - time1 + 30);
	}


	// reduz a força do time para uma casa decimal
	int auxTime1 = (int) (time1 * 0.01);
	int auxTime2 = (int) (time1 * 0.01);

	//calcula os resultados
	int random1 = (-auxTime1 + (rand() & auxTime1));
	int random2 = (-auxTime2 + (rand() & auxTime2));
	auxTime1 += random1;
	auxTime2 += random2;


	// aloca os resultados em um vetor para ser usado futuramente.
	int *result = (int*)malloc(2*sizeof(int));
	result[0] = auxTime1;
	result[1] = auxTime2;
    return result;
}

int main() {

	//array com cadastro dos times
	string idTime[3];
	idTime[0] = "Campinense";
	idTime[1] = "Treze";
	idTime[2] = "Botafogo";



	//Array com atributos dos times
	int timesAtributos [3][9];

	//Campinense:
	//ataque
	timesAtributos[0][0] = 60;//0 a 100
	//defesa
	timesAtributos[0][1] = 65;//0 a 100
	//controle de jogo
	timesAtributos[0][2] = 50;//0 a 100
	//confiança
	timesAtributos[0][3] = 60;//100 a 0
	//disposição fisica
	timesAtributos[0][4] = 100;//100 a 0
	//jogador1
	timesAtributos[0][5] = 4;//1 a 10
	//jogador2
	timesAtributos[0][6] = 5;//1 a 10
	//jogador3
	timesAtributos[0][7] = 5;//1 a 10
	//Capital
	timesAtributos[0][8] = 5000;

	//Treze:
	//ataque
	timesAtributos[1][0] = 55;//0 a 100
	//defesa
	timesAtributos[1][1] = 40;//0 a 100
	//controle de jogo
	timesAtributos[1][2] = 50;//0 a 100
	//confiança
	timesAtributos[1][3] = 60;//100 a 0
	//disposição fisica
	timesAtributos[1][4] = 100;//100 a 0
	//jogador1
	timesAtributos[1][5] = 4;//1 a 10
	//jogador2
	timesAtributos[1][6] = 5;//1 a 10
	//jogador3
	timesAtributos[1][7] = 5;//1 a 10

	//Botafogo:
	//ataque
	timesAtributos[2][0] = 60;//0 a 100
	//defesa
	timesAtributos[2][1] = 65;//0 a 100
	//controle de jogo
	timesAtributos[2][2] = 50;//0 a 100
	//confiança
	timesAtributos[2][3] = 60;//100 a 0
	//disposição fisica
	timesAtributos[2][4] = 100;//100 a 0
	//jogador1
	timesAtributos[2][5] = 4;//1 a 10
	//jogador2
	timesAtributos[2][6] = 5;//1 a 10
	//jogador3
	timesAtributos[2][7] = 5;//1 a 10


	//força do campinense

	int resultado1 = 0;
	int resultado2 = 0;
	for(int i = 0; i < 5; i++){
		resultado1 = resultado1 + timesAtributos[0][i];
	}

	for(int i = 0; i < 5; i++){
			resultado2 = resultado2 + timesAtributos[1][i];
		}

	int aux1 = calculoDeForca(resultado1, 100, 0.7);
	int aux2 = calculoDeForca(resultado2, 100, 0.3);

	int* aux = resultadoFinal(aux1, aux2);
	printf("%d %d", aux[0], aux[1]);

}
