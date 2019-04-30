#include<stdlib.h>
#include <iostream>
#include <vector>
#include <string>
#include <cstdlib>
#include <unistd.h>
#include "CalculoDeForca.hpp"

#ifndef FINALSEMIFINAL_HPP
#define FINALSEMIFINAL_HPP


using namespace std;


int semiFinalA[2][2] = {{0,0}, {0,0}};
int semiFinalB[2][2] = {{0,0}, {0,0}};
int finalTabela[2][2];
int calculoDeForca(int somatorio, int torcida, float porcentagemDaTorcida);
int* resultadoFinal(int time1, int time2);
int somatorioDasForcas(string times[10][7], int idTime);
int* getMelhoresClassificados();



int* penaltis(int time1, int time2){


    int maior = 150;
    int menor = 0;
    int nPenaltis = 0;
    srand((unsigned)time(0)); //para gerar números aleatórios reais.
    int chancesTime1 = string_to_int(timesAtributos[time1][0]) +  string_to_int(timesAtributos[time1][1]);
    int chancesTime2 = string_to_int(timesAtributos[time2][0]) +  string_to_int(timesAtributos[time2][1]);
    int pontos1 = 0;
    int pontos2 = 0;
    int vencedor = 0;

    while(pontos1 == pontos2 || nPenaltis <= 10){
        int aleatorio = rand()%(maior-menor+1) + menor;
        int aleatorio1 = rand()%(1-0+1) + 0;
        int aleatorio2 = rand()%(1-0+1) + 0;

        nPenaltis ++;
        if(chancesTime1 >= aleatorio && aleatorio1 == 1 ){
            pontos1 ++;
        }if(chancesTime2 >= aleatorio && aleatorio2 == 1){
            pontos2 ++;
        }
    }
    if(pontos1 > pontos2){
        vencedor = time1;
    }else{
        vencedor = time2;
    }

    int *saida = new int[3];
    saida[0] = pontos1;saida[1] = pontos2; saida[2] = vencedor;
    return saida;


}

int* partida(int time1, int time2,int timeJogaEmCasa){
////Deve ser responsavel por fazer os jjogos, alterar os dados de pontos e exibir isso na tela.
    int resultado1 = somatorioDasForcas(timesAtributos, time1);
    int resultado2 = somatorioDasForcas(timesAtributos, time1);

    int forcaTime1 = 0;
    int forcaTime2 = 0;




    if(timeJogaEmCasa == 0){
        forcaTime1 = calculoDeForca(resultado1, string_to_int(timesAtributos[time1][5]), 0.7);
        forcaTime2 = calculoDeForca(resultado1, string_to_int(timesAtributos[time2][5]), 0.3);
    }else{
        forcaTime1 = calculoDeForca(resultado1, string_to_int(timesAtributos[time1][5]), 0.3);
        forcaTime2 = calculoDeForca(resultado1, string_to_int(timesAtributos[time2][5]), 0.7);

    }
    int *resultJogo = new int[2];
    resultJogo = resultadoFinal(forcaTime1, forcaTime2);

    cout<< "----------Resultado Partida----------" << endl;
    cout<< "----- " + timesAtributos[time1][0] + " vs " +  timesAtributos[time2][0] + " -----" << endl;
    cout<< "      " << resultJogo[0]  <<"    " << resultJogo[1] << endl;

    int *saida = new int[2];
    saida[0]= resultJogo[0];
    saida[1]= resultJogo[1];
    return saida;

}

int* getMelhoresClassificados(){

    //Pega os dois melhores classificados da tabela.
    int *saida = new int[2];
    int firstBest = 1;
    int secondBest = 1;

    if(semiFinalA[1][0] >semiFinalA[1][1]){
        firstBest = 0;
    }
    else{
        firstBest = 1;

    }if(semiFinalB[1][0] > semiFinalB[1][1]){
        secondBest = 0;

    }else{
        firstBest = 1;
    }
    saida[0] = semiFinalA[0][firstBest];
    saida[1] = semiFinalB[0][secondBest];
    return saida;
}
void semiFinal(){
    vector<int> timesA = getClassificadosParaFinal(Grupo_A);
    vector<int> timesB = getClassificadosParaFinal(Grupo_B);

     semiFinalA[0][0] = getIdTimeGrupo(timesAtributos,Grupo_A[0][timesA[0]]);
     semiFinalA[0][1] = getIdTimeGrupo(timesAtributos,Grupo_A[0][timesA[1]]);
     
     

     semiFinalB [0][0]= getIdTimeGrupo(timesAtributos,Grupo_B[0][timesB[0]]);
     semiFinalB [0][1]= getIdTimeGrupo(timesAtributos,Grupo_B[0][timesB[1]]);
     
    int *resultado;
    resultado=  new int[2];
    cout <<"\n\n----------SEMIFINAL----------\n\n";
    //Grupo A.
    //Jogos ida e volta
    int timesDaSeminal[4];
    timesDaSeminal[0] = semiFinalA[0][0];
    timesDaSeminal[1] = semiFinalA[0][1];
    timesDaSeminal[2] = semiFinalB[0][0];
    timesDaSeminal[3] = semiFinalB[0][1];

    cout<< "\nGRUPO A :\n";
    cout<< "Jogo 1( " + timesAtributos[timesDaSeminal[0]][0] + " joga em casa): " + timesAtributos[timesDaSeminal[0]][0] + " vs " + timesAtributos[timesDaSeminal[1]][0]<< endl ;
    resultado = partida(timesDaSeminal[0], timesDaSeminal[1], 0);

    semiFinalA[1][0] += resultado[0];
    semiFinalA[1][1] += resultado[1];

    cout<< "Jogo 2( " + timesAtributos[timesDaSeminal[1]][0] + " joga em casa): " + timesAtributos[timesDaSeminal[1]][0] + " vs " + timesAtributos[timesDaSeminal[0]][0]<< endl ;
    resultado = partida(timesDaSeminal[0], timesDaSeminal[1], 1);

    semiFinalA[1][0] += resultado[0];
    semiFinalA[1][1] += resultado[1];

    if(semiFinalA[1][0] == semiFinalA[1][1]){
        int *resultadoPenaltis = new int[3];
        resultadoPenaltis = penaltis(timesDaSeminal[0], timesDaSeminal[1]);
        cout<<"\n-----------EMPATE-----------\n"<<endl;
        cout<<"----------PENALTIS----------"<<endl;

        cout<< resultadoPenaltis[0] << "  Gols ;"<< timesAtributos[timesDaSeminal[0]][0] << endl;
        cout<< resultadoPenaltis[1] << "  Gols ;"<< timesAtributos[timesDaSeminal[1]][0] << endl;
    }
    //Grupo B.
    //Jogos ida e volta
    //  int *timesDaSeminal2 = new int[2];
    cout<< "\nGRUPO B :\n";
   cout<< "Jogo 1( " + timesAtributos[timesDaSeminal[2]][0] + " joga em casa): " + timesAtributos[timesDaSeminal[2]][0] + " vs " + timesAtributos[timesDaSeminal[3]][0]<< endl ;
    resultado = partida(timesDaSeminal[2], timesDaSeminal[3], 0);

    semiFinalB[1][0] += resultado[0];
    semiFinalB[1][1] += resultado[1];

    cout<< "Jogo 2( " + timesAtributos[timesDaSeminal[3]][0] + " joga em casa): " + timesAtributos[timesDaSeminal[2]][0] + " vs " + timesAtributos[timesDaSeminal[3]][0]<< endl ;
    resultado = partida(timesDaSeminal[2], timesDaSeminal[3], 1);

    semiFinalB[1][0] += resultado[0];
    semiFinalB[1][1] += resultado[1];

    if(semiFinalB[1][0] == semiFinalB[1][1]){
        int *resultadoPenaltis = new int[3];
        resultadoPenaltis = penaltis(timesDaSeminal[2], timesDaSeminal[3]);
        cout<<"\n-----------EMPATE-----------\n"<<endl;
        cout<<"----------PENALTIS----------"<<endl;

        cout<< resultadoPenaltis[0] << "  Gols ;"<< timesAtributos[timesDaSeminal[2]][0] << endl;
        cout<< resultadoPenaltis[1] << "  Gols ;"<< timesAtributos[timesDaSeminal[3]][0] << endl;
    }


}


void finalCampeonato(){
    int* classificadosFinal = new int[2];
    classificadosFinal  = getMelhoresClassificados();
    finalTabela[0][0] = classificadosFinal[0];
    finalTabela[0][1] = classificadosFinal[1];
    cout <<"\n\n----------FINAL----------\n\n";

    int timesDaFinal[2];
    timesDaFinal[0] = finalTabela[0][0];
    timesDaFinal[1] = finalTabela[0][1];

    cout<< "Jogo 1(Time: " << timesAtributos[timesDaFinal[0]][0] << " joga em casa): " << timesAtributos[timesDaFinal[0]][0] << " vs " << timesAtributos[timesDaFinal[1]][0]<< endl ;
    int *resultado = new int[2];
    resultado = partida(timesDaFinal[0], timesDaFinal[1], 0);
    finalTabela[1][0] += resultado[0];finalTabela[1][1] += resultado[1];


    cout<<"Jogo 2(Time: " + timesAtributos[timesDaFinal[1]][0] +  " joga em casa): " + timesAtributos[timesDaFinal[1]][0] + " vs " + timesAtributos[timesDaFinal[0]][0]<< endl ;
    resultado = partida(timesDaFinal[0], timesDaFinal[1],1);
    finalTabela[1][0] += resultado[0];finalTabela[1][1] += resultado[1];


    if(finalTabela[1][0] > finalTabela[1][1]){
       

        cout << " VENCEDOR DO CAMPEONATO :" << endl;
        cout << "--------" << timesAtributos[timesDaFinal[0]][0] << "--------";
    }else if(finalTabela[1][0] < finalTabela[1][1]){
       

        cout << " VENCEDOR DO CAMPEONATO :" << endl;
        cout << "--------" << timesAtributos[timesDaFinal[1]][0] << "--------";

    }else{
        int *resultado = new int[3];
        resultado = penaltis(timesDaFinal[0], timesDaFinal[1]);
        cout<<"-----------EMPATE-----------"<<endl;
        cout<<"----------PENALTIS----------"<<endl;
     

        cout << " VENCEDOR DO CAMPEONATO :" << endl;
        cout << "--------" << timesAtributos[timesDaFinal[0]][0] << "--------";

        
    }
}
#endif