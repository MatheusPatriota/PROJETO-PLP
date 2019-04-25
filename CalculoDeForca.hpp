
#include "CalculoDeForca.h"
#pragma once
#include <iostream>
#include <ctime>
using namespace std;


#ifndef CALCULODEFORCA_HPP
#define CALCULODEFORCA_HPP

//Calculo da forca de um time
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

#endif /* CALCULODEFORCA_H_ */