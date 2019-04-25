#include<stdlib.h>
#include <iostream>
#include <vector>
#include "FinalSemiFinal.h"




using namespace std;


int semiFinalA[2][2];
int semiFinalB[2][2];
int finalTabela[2][2];

string Times[3][10] = {{"Campinense","Treze","Botafogo","Souza","Nacional de Patos","Serrano","Atletico-PB","Perilima","Esporte de Patos","CSP" },   // Nome do time
                           {"50"        ,"50"   ,"50"      ,"50"   ,"50"               ,"50"     ,"50"         ,"50"      ,"50"              ,"50"  },   // Ataque
                           {"50"        ,"50"   ,"50"      ,"50"   ,"50"               ,"50"     ,"50"         ,"50"      ,"50"              ,"50"  }};  // Defesa


    // 7 Linhas para o time e seus atributos e 2 linhas a quantidade de times
    string Grupo_A[7][5] = {{},  // Time
                            {"0","0","0","0","0"},  // Pontos
                            {"0","0","0","0","0"},  // Partidas
                            {"0","0","0","0","0"},  // Vitorias
                            {"0","0","0","0","0"},  // Empates
                            {"0","0","0","0","0"},  // Derrotas
                            {"0","0","0","0","0"}}; // Gols

    string Grupo_B[7][5] = {{},  // Time
                            {"0","0","0","0","0"},  // Pontos
                            {"0","0","0","0","0"},  // Partidas
                            {"0","0","0","0","0"},  // Vitorias
                            {"0","0","0","0","0"},  // Empates
                            {"0","0","0","0","0"},  // Derrotas
                            {"0","0","0","0","0"}}; // Gols



int* getMelhoresClassificados(char grupo){

    //Pega os dois melhores classificados da tabela.
    int *saida = new int[2];
    int firstBest = 0;
    int secondBest = 0;
    //Se receber 'A' como parametro proucura na tabela do grupo A
//    if(grupo == 'A'){
//        int j  = 4;
//        for(int i = 0; i < 5; i++){
//
//	            if(grupoA[0][i] > grupoA[0][firstBest]) {
//	        		int aux = firstBest;
//	        		firstBest = i;
//	        		secondBest = aux;
//	        	}if(grupoA[0][j] >grupoA[0][secondBest] && j != firstBest) {
//	        		secondBest = j;
//	        	}
//	        	if(grupoA[0][firstBest] < grupoA[0][secondBest]) {
//	        		int aux = firstBest;
//	        		firstBest = secondBest;
//	        		secondBest = aux;
//	        	}j --;
//        }
//
//        firstBest = grupoA[1][firstBest];
//        secondBest= grupoA[1][secondBest];
//    }//Se receber 'B' como parametro proucura na tabela do grupo B
//    else if(grupo == 'B'){
//        int j  = 4;
//        for(int i = 0; i < 5; i++){
//           if(grupoB[0][i] > grupoB[0][firstBest]) {
//	        		int aux = firstBest;
//	        		firstBest = i;
//	        		secondBest = aux;
//            }if(grupoB[0][j] >grupoB[0][secondBest] && j != firstBest) {
//	        		secondBest = j;
//            }
//            if(grupoB[0][firstBest] < grupoB[0][secondBest]) {
//	        		int aux = firstBest;
//	        		firstBest = secondBest;
//	        		secondBest = aux;
//	        	}j --;
//        }
//        cout<< firstBest<< " first \n";
//        cout << secondBest << "second \n";
//        firstBest = grupoB[1][firstBest];
//        secondBest= grupoB[1][secondBest];
//    }//Se recebe qualquer outro, proucura os dois melhores daas duas tabelas.
//    else{

    if(semiFinalA[1][0] >semiFinalA[1][1]){
        firstBest = 0;
    else{
        firstBest = 1
    }

    }if(semiFinalB[1][0] > semiFinalB[1][1]){
        secondBest = 0;

    }else{
        firstBest = 1;
    }

    firstBest = semiFinal[0][firstBest];
    secondBest = semiFinal[0][secondBest];
    saida[0] = firstBest;
    saida[1] = secondBest;
    return saida;


}

void semiFinal(){
    vector<int> timesA = getClassificadosParaFinal(Grupo_A);
    vector<int> timesB = getClassificadosParaFinal(Grupo_B);

    int semiFinalA[2][2] = {{timesA[0], timesA[1]},
                            {   0     ,    0    }};
    int semiFinalB[2][2] = {{timesB[0], timesB[1]},
                            {   0     ,    0    }};
    int *resultado;
    resultado=  new int[2];
    cout <<"\n\n----------SEMIFINAL----------\n\n";
    //Grupo A.
    //Jogos ida e volta
    int* dupla[2] = {semiFinalA[0],semiFinalA[1]};
    cout<< "\nGRUPO A :\n";
    cout<< "Jogo 1(Time: " + Times[0][*dupla[0]] + " joga em casa): " + Times[0][*dupla[0]] + " vs " + Times[0][*dupla[0]]<< endl ;
    resultado = partida(*dupla[0], *dupla[1], 0);

    semiFinalA[1][0] += resultado[0];
    semiFinalA[1][1] += resultado[1];

    cout<< "Jogo 2(Time: " + Times[0][*dupla[1]] + " joga em casa): " + Times[0][*dupla[0]] + " vs " + Times[0][*dupla[0]]<< endl ;
    resultado = partida(*dupla[0], *dupla[1], 1);

    semiFinalA[1][0] += resultado[0];
    semiFinalA[1][1] += resultado[1];


    //Grupo B.
    //Jogos ida e volta
    //  int *dupla2 = new int[2];
    cout<< "\nGRUPO B :\n";
    int* dupla2[2] = {semiFinalB[0],semiFinalB[1]};
    cout<<"Jogo 1(Time: " + Times[0][*dupla[0]] +  " joga em casa): " + Times[0][*dupla[0]] + " vs " + Times[0][*dupla[0]]<< endl ;
    resultado = partida(*dupla[0], *dupla[1],0);

    semiFinalB[1][0] += resultado[0];
    semiFinalB[1][1] += resultado[1];

    cout<<"Jogo 2(Time: " + Times[0][*dupla[1]] +  " joga em casa): " + Times[0][*dupla[0]] + " vs " + Times[0][*dupla[0]]<< endl ;
    resultado = partida(*dupla[0], *dupla[1],1);

    semiFinalB[1][0] += resultado[0];
    semiFinalB[1][1] += resultado[1];


}


void finalCampeonato(){
    int* classificadosFinal  =  getMelhoresClassificados('f');
    finalTabela[0][0] = *classificadosFinal[0];
    finalTabela[0][1] = *classificadosFinal[1];

    cout <<"\n\n----------FINAL----------\n\n";

    int *dupla = new int[2] = {finalTabela[0][0], finalTabela[0][1]};

    cout<< "Jogo 1(Time: " + Times[0][*dupla[0]] + " joga em casa): " + Times[0][*dupla[0]] + " vs " + Times[0][*dupla[0]]<< endl ;
    resultado = partida(*dupla[0], *dupla[1], 0);

    cout<<"Jogo 2(Time: " + Times[0][*dupla[1]] +  " joga em casa): " + Times[0][*dupla[0]] + " vs " + Times[0][*dupla[0]]<< endl ;
    resultado = partida(*dupla[0], *dupla[1],1);



}


int* partida(int time1, int time2,int timeJogaEmCasa){
////Deve ser responsavel por fazer os jjogos, alterar os dados de pontos e exibir isso na tela.
    int resultado1 = 0;
    int resultado2 = 0;

    int forcaTime1 = 0;
    int forcaTime2 = 0;
    //Supondo que eu consiga referenciar um time na tabela de atributos pela tabela de grupos.
    for(int i = 0; i < 5; i++){
		resultado1 = resultado1 + timesAtributos[time1][i];
	}

	for(int i = 0; i < 5; i++){
        resultado2 = resultado2 + timesAtributos[time2][i];
    }

    if(timeJogaEmCasa == 0){
        forcaTime1 = calculoDeForca(resultado1, timesAtributos[time1][5], 0.7);
        forcaTime2 = calculoDeForca(resultado1, timesAtributos[time2][5], 0.3);
    }else{
        forcaTime1 = calculoDeForca(resultado1, timesAtributos[time1][5], 0.3);
        forcaTime2 = calculoDeForca(resultado1, timesAtributos[time2][5], 0.7);

    }
    int resultJogo = new int[2];
    int* resultJogo = resultadoFinal(forcaTime1, forcaTime2);

    cout<< "----------Resultado Partida----------" << endl;
    cout<< "----- " + Times[0][time1] + " vs " +  Times[0][time1] + " -----" << endl;
    cout<< "      " + resultJogo[0]   <<"    " << resultJogo[1] << endl;

    int saida[2];
    saida[0]= resultJogo[0];
    saida[1]= resultJogo[1];
    return saida;

}

int main()
{

    srand((unsigned)time(NULL));
    setlocale(LC_ALL,"");

    // Estrutura resuzida apenas para testes


    string sorteio = SorteiroFaseDeGrupos(Times, Grupo_A, Grupo_B);
    vector<string> jogos = RealizandoOsJogosDaFaseDeGrupos(Times, Grupo_A, Grupo_B);

    cout << sorteio << endl;

    cout << "---------- Jogos Grupo A ----------" << endl;
    cout << "Rodada 01\n" + jogos[0] << "\n" << endl;
    cout << "Rodada 02\n" + jogos[1] << "\n" << endl;
    cout << "Rodada 03\n" + jogos[2] << "\n" << endl;
    cout << "Rodada 04\n" + jogos[3] << "\n" << endl;
    cout << "Rodada 05\n" + jogos[4] << endl;

    cout << "---------- Jogos Grupo B ----------" << endl;
    cout << "Rodada 06\n" + jogos[5] << "\n" << endl;
    cout << "Rodada 07\n" + jogos[6] << "\n" << endl;
    cout << "Rodada 08\n" + jogos[7] << "\n" << endl;
    cout << "Rodada 09\n" + jogos[8] << "\n" << endl;
    cout << "Rodada 10\n" + jogos[9] << endl;

    cout << "---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------" << endl;
    string resul1 = getGrupoOrdenado(Grupo_A, "A");
    string resul2 = getGrupoOrdenado(Grupo_B, "B");
    cout <<  resul1;
    cout << "---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------" << endl;
    cout <<  resul2;

    vector<int> classificados_A = getClassificadosParaFinal(Grupo_A);
    vector<int> classificados_B = getClassificadosParaFinal(Grupo_B);
    cout << "---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------\n\n" << endl;

    cout << "Classificados para semifinal do Grupo A:" << endl;
    cout << Grupo_A[0][classificados_A[0]] << "\n" << Grupo_A[0][classificados_A[1]] << endl;

    cout << endl;

    cout << "Classificados para semifinal do Grupo B:" << endl;
    cout << Grupo_B[0][classificados_B[0]] << "\n" << Grupo_B[0][classificados_B[1]] << endl;

    return 0;
}





